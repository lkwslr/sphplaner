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
        builder: (context, notify, _) {
      Size logicalScreenSize =
          View.of(context).physicalSize / View.of(context).devicePixelRatio;
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        cellWidth = (logicalScreenSize.width / 6) - 8;
        if (Platform.isAndroid) {
          double appBarHeight =
              (Scaffold.of(context).appBarMaxHeight ?? 0) + kToolbarHeight + 40;
          cellHeight = (logicalScreenSize.height - appBarHeight) / 12;
        } else if (Platform.isIOS) {
          cellHeight = (logicalScreenSize.height) / 12.5 - 18;
        }
      } else {
        cellWidth = (logicalScreenSize.width / 6) - 8;
        // TODO: unterschied tablet handy
      }

      List<String> dates = StorageProvider.isar.vertretungs
          .where()
          .distinctByDate()
          .findAllSync()
          .map((e) => DateFormat('EEEE')
              .format(DateFormat("dd.MM.yyyy").parse(e.date ?? "01.01.1970"))
              .substring(0, 2))
          .toList();
      if (dates.isEmpty) {
        dates = ["", ""];
      }
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

            if (StorageProvider.isar.vertretungs
                    .where()
                    .dayOfWeekHourEqualTo(day, hour)
                    .findFirstSync() !=
                null) {
              textcolor = Colors.red;
              subject = StorageProvider.isar.vertretungs
                      .where()
                      .dayOfWeekHourEqualTo(day, hour)
                      .findFirstSync()
                      ?.subject
                      .value
                      ?.subjectName ??
                  " ";
              room = StorageProvider.isar.vertretungs
                      .where()
                      .dayOfWeekHourEqualTo(day, hour)
                      .findFirstSync()
                      ?.room ??
                  " ";
              type = StorageProvider.isar.vertretungs
                      .where()
                      .dayOfWeekHourEqualTo(day, hour)
                      .findFirstSync()
                      ?.type ??
                  " ";
              note = StorageProvider.isar.vertretungs
                  .where()
                  .dayOfWeekHourEqualTo(day, hour)
                  .findFirstSync()
                  ?.note ??
                  " ";
              if (["Entfall", "Freisetzung"].contains(type) || ["fällt aus"].contains(note)) {
                subject = "---";
                room = "---";
              }
              color = Color(StorageProvider.isar.vertretungs
                      .where()
                      .dayOfWeekHourEqualTo(day, hour)
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
                                fontWeight: FontWeight.bold, color: textcolor)),
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
        return Container(
          width: cellWidth,
          height: cellHeight,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(5),
          ),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(e,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: (today == e || tomorrow == e)
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer))),
        );
      }).toList(),
    );
  }

  Widget buildZeitColumn(BuildContext ctx, bool online) {
    List<Widget> columns = [
      Container(
        alignment: Alignment.center,
        width: cellWidth,
        height: cellHeight,
        decoration: BoxDecoration(
          color: Theme.of(ctx).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.all(4),
        child: cellWidth < 100
            ? RotatedBox(
                quarterTurns: cellWidth < 50 ? -1 : 0,
                child: Text('Stunde',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(ctx).colorScheme.onSecondaryContainer)),
              )
            : Column(children: [
                Text('Stunde',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(ctx).colorScheme.onSecondaryContainer)),
                Container(
                    height: 21,
                    margin: const EdgeInsets.all(2.0),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Uhrzeit",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Theme.of(ctx)
                                  .colorScheme
                                  .onSecondaryContainer),
                        )))
              ]),
      )
    ];

    for (int i = 1; i <= StorageProvider.timelist.length; i++) {
      columns.add(GestureDetector(
        onTap: cellWidth < 100
            ? () => showDialog(
                context: ctx,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("$i. Stunde"),
                    content: Text(StorageProvider.timelist[i - 1]),
                  );
                })
            : null,
        child: Container(
          alignment: Alignment.center,
          width: cellWidth,
          height: cellHeight,
          decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: const EdgeInsets.all(4.0),
          child: cellWidth < 100 //TODO: variable nach Box Breite machen
              ? Center(
                  child: Text(i.toString(),
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(ctx).colorScheme.onSecondaryContainer)),
                )
              : Column(children: [
                  Text(i.toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(ctx).colorScheme.onSecondaryContainer)),
                  Container(
                      height: 30,
                      margin: const EdgeInsets.all(2.0),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(StorageProvider.timelist[i - 1],
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Theme.of(ctx)
                                      .colorScheme
                                      .onSecondaryContainer))))
                ]),
        ),
      ));
    }

    return Column(children: columns);
  }
}
