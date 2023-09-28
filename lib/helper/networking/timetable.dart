import 'package:sphplaner/helper/defaults.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/lesson.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/subject.dart';

class TimeTable {
  static downloadTimetable() async {
    await SPH.getSID();
    Isar isar = StorageProvider.isar;

    // TODO: TEXT FÜR AUSWAHL SEITE
    /*
    Wähle deine Kurse aus. Kurse, die zur selben Zeit stattfinden wurden in einer Kategorie zusammengefasst
     */

    List<List> availableLesson = [];
    List<String> timelist = [];

    http.Response response = await SPH.get("/stundenplan.php");
    if (response.statusCode == 200) {
      List<Map<String, String>> vidcourses = [];
      if (StorageProvider.user.school == 5135) {
        http.Response vidresponse = await SPH.get("/videokonferenz.php");
        if (vidresponse.statusCode == 200) {
          dom.Document vidkonferenz = parse(vidresponse.body);
          dom.Element? vidtable = vidkonferenz
              .getElementById("lgroomtab")
              ?.getElementsByTagName("tbody")[0];
          if (vidtable != null) {
            for (dom.Element vidlistitem
                in vidtable.getElementsByTagName("tr")) {
              String name = vidlistitem.getElementsByTagName("td")[0].text;
              String teacher = vidlistitem.getElementsByTagName("td")[1].text;
              vidcourses.add({"name": name, "teacher": teacher});
            }
          }
        }
      }
      dom.Document page = parse(response.body);
      if (page.getElementById("own") != null) {
        dom.Element timetableContainer = page.getElementById("own")!;

        dom.Element timetable =
            timetableContainer.getElementsByTagName("tbody")[0];

        for (dom.Element tr in timetable.getElementsByTagName("tr")) {
          timelist.add(tr.getElementsByClassName("VonBis")[0].text);
          availableLesson.add([true, true, true, true, true]);
        }

        StorageProvider.timelist = timelist;

        for (int currentHour = 0;
            currentHour < availableLesson.length;
            currentHour++) {
          dom.Element tr = timetable.getElementsByTagName("tr")[currentHour];
          for (int currentDay = 1;
              currentDay < availableLesson[currentHour].length + 1;
              currentDay++) {
            if (availableLesson[currentHour][currentDay - 1]) {
              int skippedHours = availableLesson[currentHour]
                  .sublist(0, currentDay)
                  .where((element) => !element)
                  .length;
              if (tr.getElementsByTagName("td").length >
                  currentDay - skippedHours) {
                dom.Element current =
                    tr.getElementsByTagName("td")[currentDay - skippedHours];
                if (current.attributes['rowspan'] != null) {
                  List<dom.Element> allLessons =
                      current.querySelectorAll("div.stunde");
                  for (int i = 0; i < allLessons.length; i++) {
                    dom.Element course = allLessons[i];
                    String subjectName =
                        course.getElementsByTagName("b")[0].text.trim();
                    String teacher =
                        course.getElementsByTagName("small")[0].text.trim();
                    if (_checkLesson(subjectName, teacher, vidcourses) ||
                        (StorageProvider.user.school != 5135)) {
                      String room = course.text
                          .trim()
                          .replaceAll(RegExp(r'\s+'), " ")
                          .replaceAll(subjectName, "")
                          .replaceAll(teacher, "")
                          .trim();

                      Subject? subject = await StorageProvider.isar.subjects
                          .getBySubject(subjectName);

                      if (subject == null) {
                        subject = Subject()
                          ..subject = subjectName
                          ..subjectName = getDefaultName(subjectName)
                          ..teacher = teacher
                          ..color = getDefaultColor(subjectName);

                        await isar.writeTxn(() async {
                          await isar.subjects.putBySubject(subject!);
                        });
                      }
                      List<Lesson> lessons = [];
                      Lesson? lesson = await StorageProvider.isar.lessons
                          .getByDayOfWeekHour(currentDay, currentHour + 1);

                      if (lesson == null) {
                        lessons.add(Lesson()
                          ..subject.value = subject
                          ..dayOfWeek = currentDay
                          ..hour = currentHour + 1
                          ..room = room);
                      } else {
                        lessons.add(lesson..subject.value = subject
                          ..room = room);
                      }

                      if (current.attributes['rowspan'] == "2" &&
                          currentHour < availableLesson.length - 1) {
                        availableLesson[currentHour + 1][currentDay - 1] =
                            false;
                        Lesson? lesson = await StorageProvider.isar.lessons
                            .getByDayOfWeekHour(currentDay, currentHour + 1);

                        if (lesson == null) {
                          lessons.add(Lesson()
                            ..subject.value = subject
                            ..dayOfWeek = currentDay
                            ..hour = currentHour + 2
                            ..room = room);
                        } else {
                          lessons.add(lesson..subject.value = subject
                            ..room = room);
                        }
                      } else if (currentHour < availableLesson.length - 1) {
                        availableLesson[currentHour + 1][currentDay - 1] = true;
                      }
                      await isar.writeTxn(() async {
                        await isar.lessons.putAll(lessons);
                        for (Lesson lesson in lessons) {
                          await lesson.subject.save();
                        }
                      });
                    }
                  }
                }
              }
            } else {
              if (currentHour < availableLesson.length - 1) {
                availableLesson[currentHour + 1][currentDay - 1] = true;
              }
            }
          }
        }
      }
    }
  }

  static _checkLesson(
      String courseName, String teacher, List<Map<String, String>> vidcourses) {
    if (courseName.startsWith("Q")) {
      String courseType =
          "${courseName.split("_")[1].substring(0, 1).toLowerCase()}k";
      String lessonName = courseName.split("_")[0].substring(2).toLowerCase();

      for (Map<String, String> course in vidcourses) {
        if (course['teacher']?.contains(teacher) ?? false) {
          if (course['name']?.toLowerCase().contains(courseType) ?? false) {
            if (course['name']
                    ?.toLowerCase()
                    .contains(getDefaultName(lessonName)?.toLowerCase() ?? "?????") ??
                false) {
              return true;
            }
          }
        }
      }
      return false;
    }
    return true;
  }
}
