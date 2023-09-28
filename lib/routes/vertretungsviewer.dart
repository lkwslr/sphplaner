import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';

import '../helper/storage/vertretung.dart';

class VertretungsViewer extends StatefulWidget {
  const VertretungsViewer({super.key});

  @override
  State<VertretungsViewer> createState() => _VertretungsViewerState();
}

class _VertretungsViewerState extends State<VertretungsViewer> {
  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<StorageNotifier, String>(
        properties: const ['vertretung'],
        builder: (context, notify, child) {
          List<String> dates = StorageProvider.isar.vertretungs
              .where()
              .sortByDate()
              .distinctByDate()
              .findAllSync()
              .map((e) => e.date ?? "01.01.1970")
              .toList();
          if (dates.isEmpty) {
            dates = ['Keine Vertretung vorhanden'];
          }

          return DefaultTabController(
              length: dates.length,
              initialIndex: dates.length >= 2 ? dates.length - 2 : 0,
              child: Scaffold(
                  appBar: TabBar(
                    isScrollable: dates.length > 3,
                    tabs: [
                      for (String date in dates)
                        Tab(
                          text: date,
                        ),
                    ],
                  ),
                  body: TabBarView(
                    children: dates
                        .map<Widget>((e) => _buildTab(e, notify!))
                        .toList(),
                  )));
        });
  }

  _buildTab(String date, StorageNotifier notify) {
    List<Vertretung> vertretungs = StorageProvider.isar.vertretungs
        .where()
        .dateEqualToAnyDayOfWeekHour(date)
        .filter()
        .placeholderEqualTo(false)
        .findAllSync();

    if (vertretungs.isEmpty) {
      return LayoutBuilder(
          builder: (context, constraints) => RefreshIndicator(
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    child: const Text(
                      "Es ist keine Vertretung vorhanden!",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  )),
              onRefresh: () async {
                await SPH.update(notify);
              }));
    }

    return RefreshIndicator(
        child: ListView.builder(
            itemCount: vertretungs.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withOpacity(.5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "${vertretungs[index].hour}. Stunde",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 23),
                        )),
                        Expanded(
                          child: Text(
                            vertretungs[index]
                                    .subject
                                    .value
                                    ?.subjectName
                                    .toString() ??
                                vertretungs[index].vertrSubject ??
                                "?",
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 23),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Column(
                      children: [
                        if (vertretungs[index].room?.isNotEmpty ?? false)
                          Row(
                            children: [
                              const Expanded(
                                  child: Text("Raum:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Expanded(
                                  child: Text("${vertretungs[index].room}",
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1)),
                            ],
                          ),
                        if (vertretungs[index].type?.isNotEmpty ?? false)
                          Row(
                            children: [
                              const Expanded(
                                  child: Text("Art:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Expanded(
                                  child: Text("${vertretungs[index].type}",
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1)),
                            ],
                          ),
                        if (vertretungs[index].note?.isNotEmpty ?? false)
                          Row(
                            children: [
                              const Expanded(
                                  child: Text("Hinweis:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Expanded(
                                  child: Text("${vertretungs[index].note}",
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1)),
                            ],
                          ),
                        if (vertretungs[index].classes?.isNotEmpty ?? false)
                          Row(
                            children: [
                              const Expanded(
                                  child: Text("Klasse:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold))),
                              Expanded(
                                  child: Text(
                                "${vertretungs[index].classes}",
                                textAlign: TextAlign.left,
                              )),
                            ],
                          ),
                      ],
                    )
                  ],
                ),
              );
            }),
        onRefresh: () async {
          await SPH.update(notify);
        });
  }
}
