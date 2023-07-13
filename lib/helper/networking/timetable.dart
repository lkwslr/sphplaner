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
      dom.Document page = parse(response.body);
      if (page.getElementById("own") != null) {
        dom.Element timetableContainer = page.getElementById("own")!;

        dom.Element timetable = timetableContainer.getElementsByTagName(
            "tbody")[0];

        for (dom.Element tr in timetable.getElementsByTagName("tr")) {
          timelist.add(tr.getElementsByClassName("VonBis")[0].text);
          availableLesson.add([true, true, true, true, true]);
        }

        StorageProvider.timelist = timelist;

        for (int currentHour = 0; currentHour <
            availableLesson.length; currentHour++) {
          dom.Element tr = timetable.getElementsByTagName("tr")[currentHour];
          for (int currentDay = 1; currentDay <
              availableLesson[currentHour].length + 1; currentDay++) {
            if (availableLesson[currentHour][currentDay-1]) {
              int skippedHours = availableLesson[currentHour].sublist(0, currentDay).where((element) => !element).length;
              if (tr.getElementsByTagName("td").length > currentDay-skippedHours) {
                dom.Element current = tr.getElementsByTagName("td")[currentDay-skippedHours];
                if (current.attributes['rowspan'] != null) {
                  dom.Element course = current.querySelector("div.stunde")!;//TODO: auswahl ermöglichen, wenn mehrere Fächer möglich
                  String subjectName = course.getElementsByTagName("b")[0].text
                      .trim();
                  String teacher = course.getElementsByTagName("small")[0].text
                      .trim();
                  String room = course.text.trim().replaceAll(RegExp(r'\s+'), " ")
                      .replaceAll(subjectName, "").replaceAll(teacher, "")
                      .trim();

                  Subject subject = (await StorageProvider.isar.subjects.getBySubject(subjectName)) ?? Subject()
                    ..subject = subjectName
                    ..subjectName = subjectName
                    ..teacher = teacher;

                  int subjectId = 0;
                  await isar.writeTxn(() async {
                    subjectId = await isar.subjects.putBySubject(subject);
                  });

                  subject = (await isar.subjects.get(subjectId))!;

                  List<Lesson> lessons = [Lesson()
                    ..subject.value = subject
                    ..dayOfWeek = currentDay
                    ..hour = currentHour + 1
                    ..room = room];

                  if (current.attributes['rowspan'] == "2" &&
                      currentHour < availableLesson.length-1) {
                    availableLesson[currentHour + 1][currentDay-1] = false;
                    lessons.add(Lesson()
                      ..subject.value = subject
                      ..dayOfWeek = currentDay
                      ..hour = currentHour + 2
                      ..room = room);
                  } else if (currentHour < availableLesson.length-1) {
                    availableLesson[currentHour + 1][currentDay-1] = true;
                  }
                  await isar.writeTxn(() async {
                    await isar.lessons.putAll(lessons);
                    for (Lesson lesson in lessons) {
                      await lesson.subject.save();
                    }
                  });
                }
              }
            } else {
              if (currentHour < availableLesson.length-1) {
                availableLesson[currentHour + 1][currentDay-1] = true;
              }
            }
          }
        }
      }

    }
  }

}
