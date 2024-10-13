import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/storage/homework.dart';
import 'package:sphplaner/helper/storage/lerngruppe.dart';
import 'package:sphplaner/helper/storage/schulstunde.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/helper/storage/vertretung.dart';

import '../helper/defaults.dart';

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
        properties: const ['stundenplan', 'vertretung', 'homework'],
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

          List<String> dates = StorageProvider.isar.vertretungs
              .filter()
              .placeholderEqualTo(true)
              .distinctByDatum()
              .findAllSync()
              .map((element) {
            return element.datum ?? "01.01.1970";
          }).toList();

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

                Schulstunde? lesson = StorageProvider.isar.schulstundes
                    .where()
                    .wochentagStundeEqualTo(day - 1 + (StorageProvider.settings.lerngruppen ? 0 : 1), hour)
                    .findFirstSync();

                Vertretung? vertretung = StorageProvider.isar.vertretungs
                    .filter()
                    .datumEqualTo(date)
                    .wochentagEqualTo(day)
                    .stundenElementEqualTo(hour)
                    .lerngruppe((q) {
                  return q.fullNameEqualTo(lesson?.fach.value?.fullName);
                }).findFirstSync();

                homework = StorageProvider.isar.homeworks
                    .filter()
                    .finishedEqualTo(false)
                    .lerngruppe((subject) {
                  return subject.gruppenIdEqualTo(lesson?.fach.value?.gruppenId);
                }).findFirstSync();

                if (StorageProvider.settings.showVertretung &&
                    vertretung != null) {
                  textcolor = Colors.red;
                  subject = vertretung.lerngruppe.value?.gruppenId ??
                      vertretung.vertretungsFach ??
                      vertretung.fach ??
                      "";
                  if (subject.trim() == "") {
                    subject = vertretung.fach ?? "???";
                  }
                  teacher = vertretung.vertretungsLehrkraft ??
                      vertretung.lehrkraft ??
                      " ";
                  room = vertretung.vertretungsRaum ?? vertretung.raum ?? " ";
                  type = vertretung.art ?? " ";
                  note = vertretung.hinweis ?? " ";
                  if (["Entfall", "Freisetzung"].contains(type) ||
                      ["fällt aus"].contains(note)) {
                    subject = "---";
                    room = "---";
                  }
                  if (room.trim() == "") {
                    room = "---";
                  }
                  color =
                      Color(vertretung.lerngruppe.value?.farbe ?? 4292600319);
                } else {
                  subject = lesson?.fach.value?.generatedName ??
                      lesson?.fach.value?.name ??
                      lesson?.fach.value?.gruppenId ??
                      " ";
                  room = lesson?.raum ?? " ";
                  teacher = lesson?.fach.value?.lehrkraft.value?.kuerzel ?? " ";
                  color = Color(lesson?.fach.value?.farbe ??
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
                  onTap: vertretung == null && room.trim() == ""
                      ? null
                      : () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                if (subject == "---") {
                                  subject = lesson?.fach.value?.generatedName ??
                                      lesson?.fach.value?.name ??
                                      lesson?.fach.value?.gruppenId ??
                                      "???";
                                }
                                return AlertDialog(
                                    contentPadding: const EdgeInsets.all(8),
                                    scrollable: true,
                                    title: Text("Informationen zu $subject"),
                                    content: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 8, 16, 16),
                                      child: Column(
                                        children: [
                                          if (vertretung != null)
                                            Column(
                                              children: [
                                                if (vertretung
                                                        .fach?.isNotEmpty ??
                                                    false)
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                          child: Text("statt:",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                      Expanded(
                                                          child: Text(
                                                              "${vertretung.fach}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              maxLines: 1)),
                                                    ],
                                                  ),
                                                if ((vertretung
                                                            .vertretungsLehrkraft
                                                            ?.isNotEmpty ??
                                                        false) ||
                                                    (vertretung.lehrkraft
                                                            ?.isNotEmpty ??
                                                        false))
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                          child: Text(
                                                              "Lehrkraft:",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                      Expanded(
                                                          flex: 3,
                                                          child: Row(
                                                            children: [
                                                              if (vertretung
                                                                  .vertretungsLehrkraft
                                                                  .toString()
                                                                  .isNotEmpty)
                                                                Text(
                                                                    "${vertretung.vertretungsLehrkraft} ",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                    maxLines:
                                                                        1),
                                                              if (vertretung
                                                                  .lehrkraft
                                                                  .toString()
                                                                  .isNotEmpty)
                                                                Text("(",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w100),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                    maxLines:
                                                                        1),
                                                              if (vertretung
                                                                  .lehrkraft
                                                                  .toString()
                                                                  .isNotEmpty)
                                                                Text(
                                                                    "${vertretung.lehrkraft}",
                                                                    style: TextStyle(
                                                                        decoration:
                                                                            TextDecoration
                                                                                .lineThrough,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w100),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                    maxLines:
                                                                        1),
                                                              if (vertretung
                                                                  .lehrkraft
                                                                  .toString()
                                                                  .isNotEmpty)
                                                                Text(")",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w100),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                    maxLines:
                                                                        1),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                if (vertretung.vertretungsRaum
                                                        ?.isNotEmpty ??
                                                    false)
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                          child: Text("Raum:",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                      Expanded(
                                                          flex: 3,
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                  "${vertretung.vertretungsRaum} ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade,
                                                                  maxLines: 1),
                                                              if (vertretung
                                                                          .raum !=
                                                                      null &&
                                                                  vertretung.raum
                                                                      .toString()
                                                                      .isNotEmpty)
                                                                Text(
                                                                    "(",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w100),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                    maxLines:
                                                                        1),
                                                              if (vertretung.raum !=
                                                                      null &&
                                                                  vertretung.raum
                                                                      .toString()
                                                                      .isNotEmpty)
                                                                Text("${vertretung.raum}",
                                                                    style: TextStyle(
                                                                        decoration: TextDecoration
                                                                            .lineThrough,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w100),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                    maxLines:
                                                                        1),
                                                              if (vertretung
                                                                          .raum !=
                                                                      null &&
                                                                  vertretung.raum
                                                                      .toString()
                                                                      .isNotEmpty)
                                                                Text(
                                                                    ")",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w100),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .fade,
                                                                    maxLines:
                                                                        1),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                if (vertretung
                                                        .art?.isNotEmpty ??
                                                    false)
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                          child: Text("Art:",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                      Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                              "${vertretung.art}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              maxLines: 1)),
                                                    ],
                                                  ),
                                                if (vertretung
                                                        .hinweis?.isNotEmpty ??
                                                    false)
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                          child: Text(
                                                              "Hinweis:",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                      Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                              "${vertretung.hinweis}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .fade,
                                                              maxLines: 1)),
                                                    ],
                                                  ),
                                                if (vertretung
                                                        .kurs?.isNotEmpty ??
                                                    false)
                                                  Row(
                                                    children: [
                                                      const Expanded(
                                                          child: Text("Klasse:",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))),
                                                      Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            "${vertretung.kurs}",
                                                            textAlign:
                                                                TextAlign.left,
                                                          )),
                                                    ],
                                                  ),
                                                Divider(
                                                  thickness: 1,
                                                  height: 16,
                                                  color: Color(vertretung
                                                          .lerngruppe
                                                          .value
                                                          ?.farbe ??
                                                      getDefaultColor(vertretung
                                                          .vertretungsFach) ??
                                                      getDefaultColor(
                                                          vertretung.fach) ??
                                                      4294967295),
                                                ),
                                              ],
                                            ),
                                          if (homework != null)
                                            Column(children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Hausaufgaben",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  const Expanded(
                                                      child: Text("Titel: ")),
                                                  Expanded(
                                                      child: Text(
                                                          "${homework.title}"))
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Expanded(
                                                      child: Text(
                                                          "Zu erledigen bis: ")),
                                                  Expanded(
                                                      child: Text(DateFormat(
                                                              "dd.MM.yy")
                                                          .format(DateTime
                                                              .fromMillisecondsSinceEpoch(
                                                                  homework.due ??
                                                                      0))))
                                                ],
                                              ),
                                              Divider(
                                                thickness: 1,
                                                height: 16,
                                                color: Color(vertretung
                                                        ?.lerngruppe
                                                        .value
                                                        ?.farbe ??
                                                    getDefaultColor(vertretung
                                                        ?.vertretungsFach) ??
                                                    getDefaultColor(
                                                        vertretung?.fach) ??
                                                    4294967295),
                                              ),
                                            ]),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "Fach laut Stundenplan:",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                                textAlign: TextAlign.center,
                                              )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              const Expanded(
                                                  child: Text("Fachname: ")),
                                              Expanded(child: Text(subject))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Expanded(
                                                  child: Text(
                                                      "Fachbezeichnung: ")),
                                              Expanded(
                                                  child: Text(
                                                      "${lesson?.fach.value?.fullName}"))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Expanded(
                                                  child: Text("Raum: ")),
                                              Expanded(
                                                  child:
                                                      Text("${lesson?.raum}"))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Expanded(
                                                  child: Text("Lehrer: ")),
                                              Expanded(
                                                  child: Text(
                                                      "${lesson?.fach.value?.lehrkraft.value?.name}"))
                                            ],
                                          )
                                        ],
                                      ),
                                    ));
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
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.all(2),
                                        child: FittedBox(
                                          fit: BoxFit.contain,
                                          child: Text(room,
                                              style:
                                                  TextStyle(color: textcolor)),
                                        )),
                                  ),
                                  if (cellWidth >= 120)
                                    Expanded(
                                      child: Container(
                                          padding: const EdgeInsets.all(2),
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(teacher,
                                                style: TextStyle(
                                                    color: textcolor)),
                                          )),
                                    )
                                ],
                              )),
                            ],
                          )),
                      if (note.trim() != "" ||
                          (homework != null &&
                              StorageProvider.showHomeworkInfo))
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
                                    Icon(
                                      Icons.info,
                                      color: Colors.red,
                                      size: 14,
                                    ),
                                  ],
                                ))),
                    ],
                  ),
                ));
              }
            }
            columns.add(Row(children: row));
          }

          return LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: columns,
                ),
              ));
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
