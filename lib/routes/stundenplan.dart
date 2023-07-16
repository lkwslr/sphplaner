import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/lesson.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/helper/storage/vertretung.dart';

class Stundenplan extends StatefulWidget {
  const Stundenplan({super.key});

  @override
  State<Stundenplan> createState() => _StundenplanState();
}

class _StundenplanState extends State<Stundenplan> {
  double cellWidth = 1;
  double cellHeight = 64;

  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<StorageNotifier, String>(
        properties: const ['stundenplan'],
        builder: (context, notify, _) {
          Size logicalScreenSize =
              View.of(context).physicalSize / View.of(context).devicePixelRatio;
          if (MediaQuery.of(context).orientation == Orientation.portrait) {
            cellWidth = (logicalScreenSize.width / 6) - 8;
            if (Platform.isAndroid) {
              double appBarHeight =
                  (Scaffold.of(context).appBarMaxHeight ?? 0) +
                      kToolbarHeight +
                      40;
              cellHeight = (logicalScreenSize.height - appBarHeight) / 12;
            } else if (Platform.isIOS) {
              cellHeight = (logicalScreenSize.height) / 12.5 - 18;
            }
          } else {
            cellWidth = (logicalScreenSize.width / 6) - 8;
            // TODO: unterschied tablet handy
          }

          List<String> dates = StorageProvider.vertretungsDate;
          List<Widget> columns = [buildHeader(dates[0], dates[1])];

          for (int hour = 1; hour <= StorageProvider.timelist.length; hour++) {
            List<Widget> row = [];
            for (int day = 0; day <= 5; day++) {
              if (day == 0) {
                row.add(Container(
                  width: cellWidth,
                  height: cellHeight,
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                          height: (cellHeight - 4) / 2,
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(hour.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer)))),
                      SizedBox(
                          height: (cellHeight - 4) / 2,
                          child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(StorageProvider.timelist[hour - 1],
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer))))
                    ],
                  ),
                ));
              } else {
                String subject = " ";
                String room = " ";
                Color color = Colors.transparent;
                Color textcolor = Colors.black;
                String type = " ";
                String note = " ";

                String date = dates.firstWhere(
                    (element) =>
                        DateFormat("dd.MM.yyyy").parse(element).weekday == day,
                    orElse: () => "01.01.1970");

                if (StorageProvider.isar.vertretungs
                        .where()
                        .dateDayOfWeekHourEqualTo(date, day, hour)
                        .findFirstSync() !=
                    null) {
                  textcolor = Colors.red;
                  subject = StorageProvider.isar.vertretungs
                          .where()
                          .dateDayOfWeekHourEqualTo(date, day, hour)
                          .findFirstSync()
                          ?.subject
                          .value
                          ?.subjectName ??
                      " ";
                  room = StorageProvider.isar.vertretungs
                          .where()
                          .dateDayOfWeekHourEqualTo(date, day, hour)
                          .findFirstSync()
                          ?.room ??
                      " ";
                  type = StorageProvider.isar.vertretungs
                          .where()
                          .dateDayOfWeekHourEqualTo(date, day, hour)
                          .findFirstSync()
                          ?.type ??
                      " ";
                  note = StorageProvider.isar.vertretungs
                          .where()
                          .dateDayOfWeekHourEqualTo(date, day, hour)
                          .findFirstSync()
                          ?.note ??
                      " ";
                  if (["Entfall", "Freisetzung"].contains(type) ||
                      ["fällt aus"].contains(note)) {
                    subject = "---";
                    room = "---";
                  }
                  color = Color(StorageProvider.isar.vertretungs
                          .where()
                          .dateDayOfWeekHourEqualTo(date, day, hour)
                          .findFirstSync()
                          ?.subject
                          .value
                          ?.color ??
                      Theme.of(context).colorScheme.secondaryContainer.value);
                } else {
                  subject = StorageProvider.isar.lessons
                          .where()
                          .dayOfWeekHourEqualTo(day, hour)
                          .findFirstSync()
                          ?.subject
                          .value
                          ?.subject ??
                      " ";
                  room = StorageProvider.isar.lessons
                          .where()
                          .dayOfWeekHourEqualTo(day, hour)
                          .findFirstSync()
                          ?.room ??
                      " ";
                  color = Color(StorageProvider.isar.lessons
                          .where()
                          .dayOfWeekHourEqualTo(day, hour)
                          .findFirstSync()
                          ?.subject
                          .value
                          ?.color ??
                      Theme.of(context).colorScheme.secondaryContainer.value);
                }

                row.add(Container(
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
                        Container(
                          height: (cellHeight - 4) / 2,
                          padding: const EdgeInsets.all(2),
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(subject,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: textcolor)),
                          ),
                        ),
                        Container(
                          height: (cellHeight - 4) / 2,
                          padding: const EdgeInsets.all(2),
                          child: Text(room, style: TextStyle(color: textcolor)),
                        ),
                      ],
                    )));
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
        String shortToday = DateFormat('EEEE')
            .format(DateFormat("dd.MM.yyyy").parse(today))
            .substring(0, 2);

        String shortTomorrow = DateFormat('EEEE')
            .format(DateFormat("dd.MM.yyyy").parse(tomorrow))
            .substring(0, 2);

        return Container(
          width: cellWidth,
          height: cellHeight,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(5),
          ),
          child: (shortToday == e || shortTomorrow == e)
              ? Column(
                  children: [
                    SizedBox(
                        height: (cellHeight - 4) / 2,
                        child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(e,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary)))),
                    SizedBox(
                        height: (cellHeight - 4) / 2,
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(shortToday == e ? today : tomorrow,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary))))
                  ],
                )
              : FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(e,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer))),
        );
      }).toList(),
    );
  }
}
