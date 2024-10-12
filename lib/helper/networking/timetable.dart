import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:sphplaner/helper/networking/lerngruppen.php.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/networking/stundenplan.php.dart';
import 'package:sphplaner/helper/storage/lerngruppe.dart';
import 'package:sphplaner/helper/storage/schulstunde.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';

import '../storage/lehrkraft.dart';

class TimeTable {
  static downloadTimetable() async {
    bool lerngruppen = StorageProvider.settings.lerngruppen;
    if (lerngruppen) {
      await downloadLerngruppen();
      await downloadStundenplan();
    } else {
      //TODO: deprecated?
      Isar isar = StorageProvider.isar;
      List<List> availableLesson = [];
      List<String> timelist = [];
      int offset = 0;

      http.Response response = await SPH.get("/stundenplan.php");
      if (response.statusCode == 200) {
        List<Map<String, String>> vidcourses = [];
        if (await StorageProvider.getSchool() == 5135) {
          http.Response vidresponse = await SPH.get("/videokonferenz.php");
          if (vidresponse.statusCode == 200) {
            dom.Document vidkonferenz = parse(vidresponse.body);
            dom.Element? vidtable = vidkonferenz
                .getElementById("lgroomtab")
                ?.getElementsByTagName("tbody")[0];
            if (vidtable != null) {
              for (dom.Element vidlistitem
                  in vidtable.getElementsByTagName("tr")) {
                String name =
                    vidlistitem.getElementsByTagName("td")[0].text.trim();
                String teacher =
                    vidlistitem.getElementsByTagName("td")[1].text.trim();
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
            if (tr.text.trim().isNotEmpty) {
              // Warum? - Siehe in else
              timelist.add(tr.getElementsByClassName("VonBis")[0].text);
              availableLesson.add([true, true, true, true, true]);
            } else {
              offset++;
              //Weil das Schulportal manchmal unverständliche Sachen macht,
              // wie in diesem Fall eine leere Tabellen Zeile zu Beginn
            }
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
                          (await StorageProvider.getSchool() != 5135)) {
                        String room = course.text
                            .trim()
                            .replaceAll(RegExp(r'\s+'), " ")
                            .replaceAll(subjectName, "")
                            .replaceAll(teacher, "")
                            .trim();

                        Lerngruppe? subject = await StorageProvider.isar.lerngruppes.getByGruppenId(subjectName);

                        Lehrkraft? lehrkraft = await StorageProvider.isar.lehrkrafts.getByKuerzel(teacher);
                        lehrkraft ??= Lehrkraft()
                          ..kuerzel = teacher
                          ..name = teacher
                          ..fullLehrkraft = teacher;

                        if (subject == null) {
                          subject = Lerngruppe()
                            ..gruppenId = subjectName
                            ..fullName = getDefaultName(subjectName)
                            ..name = getDefaultName(subjectName)
                            ..generatedName = getDefaultName(subjectName)
                            ..farbe = getDefaultColor(subjectName) ?? 4294967295
                            ..lehrkraft.value = lehrkraft;

                          await isar.writeTxn(() async {
                            await isar.lerngruppes.putByGruppenId(subject!);
                            await subject.lehrkraft.save();
                          });
                        }
                        List<Schulstunde> lessons = [];
                        Schulstunde? lesson = await StorageProvider.isar.schulstundes
                            .getByWochentagStunde(
                                currentDay, currentHour + 1 - offset);

                        if (lesson == null) {
                          lessons.add(Schulstunde()
                            ..fach.value = subject
                            ..wochentag = currentDay
                            ..stunde = currentHour + 1 - offset
                            ..raum = room);
                        } else {
                          lessons.add(lesson
                            ..fach.value = subject
                            ..raum = room);
                        }

                        if (current.attributes['rowspan'] == "2" &&
                            currentHour < availableLesson.length - 1) {
                          availableLesson[currentHour + 1][currentDay - 1] =
                              false;
                          Schulstunde? lesson = await StorageProvider.isar.schulstundes
                              .getByWochentagStunde(
                                  currentDay, currentHour + 1 - offset);

                          if (lesson == null) {
                            lessons.add(Schulstunde()
                              ..fach.value = subject
                              ..wochentag = currentDay
                              ..stunde = currentHour + 2 - offset
                              ..raum = room);
                          } else {
                            lessons.add(lesson
                              ..fach.value = subject
                              ..raum = room);
                          }
                        } else if (currentHour < availableLesson.length - 1) {
                          availableLesson[currentHour + 1][currentDay - 1] =
                              true;
                        }
                        await isar.writeTxn(() async {
                          await isar.schulstundes.putAll(lessons);
                          for (Schulstunde lesson in lessons) {
                            await lesson.fach.save();
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
            if (course['name']?.toLowerCase().contains(
                    getDefaultName(lessonName, check: true)?.toLowerCase() ??
                        "?????") ??
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
