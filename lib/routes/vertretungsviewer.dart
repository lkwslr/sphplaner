import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:sphplaner/helper/storage/lerngruppe.dart';
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
              .distinctByDatum()
              .findAllSync()
              .map((e) => e.datum ?? "01.01.1970")
              .toList();
          dates.sort((a, b) => Comparable.compare(
              DateTime.parse(
                      "${a.split(".")[2]}-${a.split(".")[1]}-${a.split(".")[0]}")
                  .millisecondsSinceEpoch,
              DateTime.parse(
                      "${b.split(".")[2]}-${b.split(".")[1]}-${b.split(".")[0]}")
                  .millisecondsSinceEpoch));
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
    List<Vertretung> vertretungs = [];
    if (StorageProvider.settings.showAllVertretung) {
      vertretungs = StorageProvider.isar.vertretungs
          .filter()
          .datumEqualTo(date)
          .placeholderEqualTo(false)
          .findAllSync();
    } else {
      vertretungs = StorageProvider.isar.vertretungs
          .filter()
          .datumEqualTo(date)
          .placeholderEqualTo(false)
          .lerngruppe((q) {
        return q.fullNameIsNotEmpty();
      }).findAllSync();
    }

    if (vertretungs.isEmpty) {
      return LayoutBuilder(
          builder: (context, constraints) => Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: const Text(
              "Es ist keine Vertretung vorhanden!",
              textAlign: TextAlign.center,
              style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ));
    }

    return ListView.builder(
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
                    if (vertretungs[index].stunden.length <= 1)
                      Expanded(
                          child: Text(
                            "${vertretungs[index].stunden[0]}. Stunde",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 23),
                          ))
                    else
                      Expanded(
                          child: Text(
                            "${vertretungs[index].stunden[0]}. - ${vertretungs[index].stunden[1]}. Stunde",
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 23),
                          )),
                    Expanded(
                      child: Text(
                        vertretungs[index].vertretungsFach ?? "?",
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 23),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 3,
                  color: Color(vertretungs[index].lerngruppe.value?.farbe ??
                      getDefaultColor(vertretungs[index].vertretungsFach) ??
                      getDefaultColor(vertretungs[index].fach) ??
                      4294967295),
                ),
                Column(
                  children: [
                    if (vertretungs[index].fach?.isNotEmpty ?? false)
                      Row(
                        children: [
                          const Expanded(
                              child: Text("statt:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                              child: Text("${vertretungs[index].fach}",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1)),
                        ],
                      ),
                    if ((vertretungs[index]
                        .vertretungsLehrkraft
                        ?.isNotEmpty ??
                        false) ||
                        (vertretungs[index].lehrkraft?.isNotEmpty ?? false))
                      Row(
                        children: [
                          const Expanded(
                              child: Text("Lehrkraft:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  if (vertretungs[index]
                                      .vertretungsLehrkraft
                                      .toString()
                                      .isNotEmpty)
                                    Text(
                                        "${vertretungs[index].vertretungsLehrkraft} ",
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1),
                                  if (vertretungs[index]
                                      .lehrkraft
                                      .toString()
                                      .isNotEmpty)
                                    Text("(",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1),
                                  if (vertretungs[index]
                                      .lehrkraft
                                      .toString()
                                      .isNotEmpty)
                                    Text("${vertretungs[index].lehrkraft}",
                                        style: TextStyle(
                                            decoration:
                                            TextDecoration.lineThrough,
                                            fontWeight: FontWeight.w100),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1),
                                  if (vertretungs[index]
                                      .lehrkraft
                                      .toString()
                                      .isNotEmpty)
                                    Text(")",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1),
                                ],
                              )),
                        ],
                      ),
                    if (vertretungs[index].vertretungsRaum?.isNotEmpty ??
                        false)
                      Row(
                        children: [
                          const Expanded(
                              child: Text("Raum:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Text(
                                      "${vertretungs[index].vertretungsRaum} ",
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1),
                                  if (vertretungs[index].raum != null &&
                                      vertretungs[index]
                                          .raum
                                          .toString()
                                          .isNotEmpty)
                                    Text("(",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1),
                                  if (vertretungs[index].raum != null &&
                                      vertretungs[index]
                                          .raum
                                          .toString()
                                          .isNotEmpty)
                                    Text("${vertretungs[index].raum}",
                                        style: TextStyle(
                                            decoration:
                                            TextDecoration.lineThrough,
                                            fontWeight: FontWeight.w100),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1),
                                  if (vertretungs[index].raum != null &&
                                      vertretungs[index]
                                          .raum
                                          .toString()
                                          .isNotEmpty)
                                    Text(")",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1),
                                ],
                              )),
                        ],
                      ),
                    if (vertretungs[index].art?.isNotEmpty ?? false)
                      Row(
                        children: [
                          const Expanded(
                              child: Text("Art:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text("${vertretungs[index].art}",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1)),
                        ],
                      ),
                    if (vertretungs[index].hinweis?.isNotEmpty ?? false)
                      Row(
                        children: [
                          const Expanded(
                              child: Text("Hinweis:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text("${vertretungs[index].hinweis}",
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.fade,
                                  maxLines: 1)),
                        ],
                      ),
                    if (vertretungs[index].kurs?.isNotEmpty ?? false)
                      Row(
                        children: [
                          const Expanded(
                              child: Text("Klasse:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold))),
                          Expanded(
                              flex: 3,
                              child: Text(
                                "${vertretungs[index].kurs}",
                                textAlign: TextAlign.left,
                              )),
                        ],
                      ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
