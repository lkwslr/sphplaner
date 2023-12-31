import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/homework.dart';
import 'package:sphplaner/helper/storage/lesson.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/helper/storage/vertretung.dart';

import '../helper/storage/subject.dart';
import 'fach_settings.dart';

class Stundenplan extends StatefulWidget {
  const Stundenplan({super.key});

  @override
  State<Stundenplan> createState() => _StundenplanState();
}

class _StundenplanState extends State<Stundenplan> {
  double cellWidth = 1;
  double cellHeight = 64;
  double hourCellWidth = 1;
  Logger logger = Logger("Stundenplan");

  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<StorageNotifier, String>(
        properties: const ['stundenplan', 'homework'],
        builder: (context, notify, _) {
          Size logicalScreenSize = MediaQuery.of(context).size;
          cellWidth = (logicalScreenSize.width / 5.5) - 9;

          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            cellHeight = (logicalScreenSize.height) * 0.0545;
          } else {
            cellHeight = (logicalScreenSize.height) * 0.125;
          }
          if (cellHeight < 45) {
            cellHeight = 45;
          }


          List<String> dates = StorageProvider.vertretungsDate;
          List<Widget> columns = [buildHeader(dates[0], dates[1])];
          for (int hour = 1; hour <= StorageProvider.timelist.length; hour++) {
            List<Widget> row = [];
            for (int day = 0; day <= 5; day++) {
              if (day == 0) {
                row.add(Container(
                  width: cellWidth / 2,
                  height: cellHeight,
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(hour.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer))),
                      ),
                      if (cellWidth > 128)
                        Expanded(
                          child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(StorageProvider.timelist[hour - 1],
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer))),
                        )
                    ],
                  ),
                ));
              } else {
                String subject = " ";
                String room = " ";
                String teacher = " ";
                Color color = Colors.transparent;
                Color textcolor = Colors.black;
                String type = " ";
                String note = " ";
                String date = " ";
                Homework? homework;
                try {
                  date = dates.firstWhere(
                          (element) =>
                      DateFormat("dd.MM.yyyy").parse(element).weekday ==
                          day,
                      orElse: () => "01.01.1970");
                } on FormatException catch (_) {}

                Vertretung? vertretung = StorageProvider.isar.vertretungs
                    .where()
                    .dateDayOfWeekHourEqualTo(date, day, hour)
                    .findFirstSync();

                Lesson? lesson = StorageProvider.isar.lessons
                    .where()
                    .dayOfWeekHourEqualTo(day, hour)
                    .findFirstSync();

                homework = StorageProvider.isar.homeworks.filter().finishedEqualTo(false).subject((subject) {
                  return subject.subjectEqualTo(lesson?.subject.value?.subject);
                }).findFirstSync();

                if (StorageProvider.settings.showVertretung &&
                    vertretung != null) {
                  textcolor = Colors.red;
                  subject = vertretung.subject.value?.subjectName ??
                      vertretung.vertrSubject ??
                      "";
                  if (subject.trim() == "") {
                    subject = vertretung.subject.value?.subject ?? "???";
                  }
                  teacher = vertretung.teacher ?? " ";
                  room = vertretung.room ?? " ";
                  type = vertretung.type ?? " ";
                  note = vertretung.note ?? " ";
                  if (["Entfall", "Freisetzung"].contains(type) ||
                      ["fällt aus"].contains(note)) {
                    subject = "---";
                    room = "---";
                  }
                  if (room.trim() == "") {
                    room = "---";
                  }
                  color = Color(vertretung.subject.value?.color ?? 4292600319);
                } else {
                  subject = lesson?.subject.value?.subjectName ?? "";
                  if (subject.trim() == "") {
                    subject = lesson?.subject.value?.subject ?? " ";
                  }
                  room = lesson?.room ?? " ";
                  teacher = lesson?.subject.value?.teacher ?? " ";
                  color = Color(lesson?.subject.value?.color ??
                      Theme.of(context).colorScheme.secondaryContainer.value);
                }
                if (subject.trim() == "") {
                  subject = lesson != null ? "---" : " ";
                }
                if (room.trim() == "") {
                  room = lesson != null ? "---" : " ";
                }
                if (teacher.trim() == "") {
                  teacher = lesson != null ? "---" : " ";
                }
                row.add(GestureDetector(
                  onTap: vertretung == null && room.trim() == "" ? null : () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              contentPadding: const EdgeInsets.all(8),
                              scrollable: true,
                              title: Text(
                                  "Informationen zu ${lesson?.subject.value?.subjectName ?? lesson?.subject.value?.subject}"),
                              content: Container(
                                padding:
                                const EdgeInsets.fromLTRB(16, 8, 16, 16),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: Text("Fachname: ")),
                                        Expanded(
                                            child: Text(
                                                "${lesson?.subject.value?.subjectName}"))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(
                                            child: Text("Fachbezeichnung: ")),
                                        Expanded(
                                            child: Text(
                                                "${lesson?.subject.value?.subject}"))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(child: Text("Raum: ")),
                                        Expanded(child: Text("${lesson?.room}"))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Expanded(child: Text("Lehrer: ")),
                                        Expanded(
                                            child: Text(
                                                "${lesson?.subject.value?.teacher}"))
                                      ],
                                    ),
                                    if (vertretung != null)
                                      Column(
                                          children: [
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              children: [
                                                Text("Vertretung", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.left,),
                                              ],
                                            ),const SizedBox(
                                              height: 8,
                                            ),

                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: Text("Fach: ")),
                                                Expanded(
                                                    child: Text(
                                                        subject))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(child: Text("Raum: ")),
                                                Expanded(child: Text(room))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(child: Text("Lehrer: ")),
                                                Expanded(
                                                    child: Text(teacher))
                                              ],
                                            ),
                                            if (vertretung.type?.isNotEmpty ?? false)
                                              Row(
                                                children: [
                                                  const Expanded(child: Text("Art: ")),
                                                  Expanded(
                                                      child: Text("${vertretung.type}"))
                                                ],
                                              ),
                                            if (vertretung.note?.isNotEmpty ?? false)
                                              Row(
                                                children: [
                                                  const Expanded(child: Text("Hinweis: ")),
                                                  Expanded(
                                                      child: Text("${vertretung.note}"))
                                                ],
                                              ),
                                          ]
                                      ),
                                    if (homework != null)
                                      Column(
                                          children: [
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            Row(
                                              children: [
                                                Text("Hausaufgaben", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.left,),
                                              ],
                                            ),const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(child: Text("Titel: ")),
                                                Expanded(child: Text("${homework.title}"))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Expanded(
                                                    child: Text("Zu erledigen bis: ")),
                                                Expanded(
                                                    child: Text(
                                                        DateFormat("dd.MM.yy").format(
                                                            DateTime.fromMillisecondsSinceEpoch(
                                                                homework.due ?? 0))))
                                              ],
                                            ),
                                          ]
                                      ),
                                  ],
                                ),
                              ));
                        });
                  },
                  onLongPress: () async {
                    await StorageProvider.isar.subjects
                        .where()
                        .findAll()
                        .then((value) {
                      Lesson lesson = Lesson();

                      List<Widget> subjects = value.map<Widget>((e) {
                        return Container(
                          padding: const EdgeInsets.all(4),
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(e.color),
                                minimumSize: const Size.fromHeight(40)),
                            onPressed: () {
                              Navigator.of(context).pop(e);
                            },
                            child: Text(
                              e.subjectName ?? "???",
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }).toList();

                      subjects.add(Container(
                        padding: const EdgeInsets.all(4),
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize: const Size.fromHeight(40)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FachSettings(subject: Subject()))).then(
                                    (value) => Navigator.of(context).pop(value));
                          },
                          child: const Text(
                            "Fach hinzufügen",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ));

                      if (room != " ") {
                        subjects.add(Container(
                          padding: const EdgeInsets.all(4),
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(40)),
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(Subject()..subject = "remove");
                            },
                            child: const Text(
                              "Stunde löschen",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ));
                      }

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                contentPadding: const EdgeInsets.all(8),
                                scrollable: true,
                                title: const Text("Fach hinzufügen"),
                                content: Column(
                                  children: subjects,
                                ));
                          }).then((value) async {
                        if (value != null) {
                          lesson.subject.value = value;

                          if (lesson.subject.value?.subject == "remove") {
                            await StorageProvider.isar.writeTxn(() async {
                              await StorageProvider.isar.lessons
                                  .deleteByDayOfWeekHour(day, hour);
                            }).then((value) => notify
                                ?.notifyAll(["stundenplan", "vertretung"]));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  TextEditingController roomController =
                                  TextEditingController();
                                  return AlertDialog(
                                    contentPadding: const EdgeInsets.all(8),
                                    scrollable: true,
                                    title: const Text("Fach hinzufügen"),
                                    content: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text("Fach: "),
                                            Expanded(
                                                child: ElevatedButton(
                                                    onPressed: null,
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      disabledBackgroundColor:
                                                      Color(lesson
                                                          .subject
                                                          .value
                                                          ?.color ??
                                                          Colors
                                                              .white.value),
                                                      disabledForegroundColor:
                                                      Colors.black,
                                                      minimumSize:
                                                      const Size.fromHeight(
                                                          32),
                                                    ),
                                                    child: Text(lesson
                                                        .subject
                                                        .value
                                                        ?.subjectName ??
                                                        lesson.subject.value
                                                            ?.subject ??
                                                        "")))
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          child: TextField(
                                            controller: roomController,
                                            decoration: const InputDecoration(
                                                labelText: 'Raum'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop("");
                                          },
                                          child: const Text("Abbrechen")),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(roomController.text);
                                          },
                                          child: const Text("Speichern"))
                                    ],
                                  );
                                }).then((value) async {
                              if (value != "") {
                                lesson.hour = hour;
                                lesson.dayOfWeek = day;
                                lesson.room = value;
                                await StorageProvider.isar.writeTxn(() async {
                                  await StorageProvider.isar.lessons
                                      .put(lesson);
                                  await lesson.subject.save();
                                }).then((value) => notify
                                    ?.notifyAll(["stundenplan", "vertretung"]));
                              }
                            });
                          }
                        }
                      });
                    });
                  },
                  child: Stack(
                    children: [
                      Container(
                          width: cellWidth,
                          height: cellHeight,
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Text(subject,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: textcolor)),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(child: Container(
                                          padding: const EdgeInsets.all(2),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(room,
                                                style: TextStyle(
                                                    color: textcolor)),
                                          )
                                      ),),
                                      if (cellWidth >= 120)
                                        Expanded(child: Container(
                                            padding: const EdgeInsets.all(2),
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(teacher,
                                                  style: TextStyle(
                                                      color: textcolor)),
                                            )
                                        ),)
                                    ],
                                  )
                              ),
                            ],
                          )),
                      if (note.trim() != "" || homework != null)
                        Container(
                            width: cellWidth + 6,
                            height: cellHeight + 6,
                            alignment: Alignment.topRight,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.info, color: Colors.red,size: 14,),
                                  ],
                                )
                            )
                        ),
                    ],
                  ),
                ));
              }
            }
            columns.add(Row(children: row));
          }

          return LayoutBuilder(
              builder: (context, constraints) => RefreshIndicator(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: columns,
                    ),
                  ),
                  onRefresh: () async {
                    await SPH.update(notify!);
                  }));
        });
  }

  Row buildHeader(String today, String tomorrow) {
    return Row(
      children: ['Stunde', 'Mo', 'Di', 'Mi', 'Do', 'Fr'].map((e) {
        String shortToday = " ";
        String shortTomorrow = " ";
        try {
          shortToday = DateFormat('EEEE')
              .format(DateFormat("dd.MM.yyyy").parse(today))
              .substring(0, 2);

          shortTomorrow = DateFormat('EEEE')
              .format(DateFormat("dd.MM.yyyy").parse(tomorrow))
              .substring(0, 2);
        } on FormatException catch (_) {}

        if (e == "Stunde") {
          return Container(
            width: cellWidth / 2,
            height: cellHeight,
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(5),
            ),
            child: RotatedBox(
                quarterTurns:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 3
                    : 0,
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(e,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer)))),
          );
        }

        return Container(
          width: cellWidth,
          height: cellHeight,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(5),
          ),
          child: (StorageProvider.settings.showVertretung &&
              (shortToday == e || shortTomorrow == e))
              ? Column(
            children: [
              Expanded(
                child: Container(
                    padding: const EdgeInsets.all(2),
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(e,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary)))),
              ),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.all(4),
                    child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(shortToday == e ? today : tomorrow,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary)))),
              )
            ],
          )
              : Container(
              padding: EdgeInsets.all(cellHeight / 4),
              child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(e,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer)))),
        );
      }).toList(),
    );
  }
}

