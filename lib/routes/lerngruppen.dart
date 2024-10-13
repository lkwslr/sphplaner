import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:sphplaner/helper/storage/leistungskontrolle.dart';
import 'package:sphplaner/helper/storage/lerngruppe.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';

class LerngruppenViewer extends StatefulWidget {
  const LerngruppenViewer({super.key});

  @override
  State<LerngruppenViewer> createState() => _LerngruppenViewerState();
}

class _LerngruppenViewerState extends State<LerngruppenViewer> {
  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<StorageNotifier, String>(
        properties: const ['lerngruppen'],
        builder: (context, notify, child) {
          List<Lerngruppe> lerngruppen =
              StorageProvider.isar.lerngruppes.where().findAllSync();

          return Scaffold(
              body: ListView.builder(
                  itemCount: lerngruppen.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<Leistungskontrolle> leistungskontrollen = lerngruppen[index].leistungskontrollen.toList();
                    return Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(12),
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
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${lerngruppen[index].name} ",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              Text(
                                "(${lerngruppen[index].gruppenId})",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 12),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(getDefaultColor(
                                "${lerngruppen[index].gruppenId}") ?? 4294967295),
                            thickness: 3,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                      flex: 1,
                                      child: Text("Lehrkraft:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                          "${lerngruppen[index].lehrkraft.value?.fullLehrkraft}",
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Expanded(
                                      flex: 1,
                                      child: Text("Halbjahr:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                          "${lerngruppen[index].halbjahr}",
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1)),
                                ],
                              ),
                              if (lerngruppen[index].zweig != "")
                                Row(
                                  children: [
                                    const Expanded(
                                        flex: 1,
                                        child: Text("Zweig:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    Expanded(
                                        flex: 3,
                                        child: Text(
                                            "${lerngruppen[index].zweig}",
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.fade,
                                            maxLines: 1)),
                                  ],
                                ),
                              for (Leistungskontrolle leistungskontrolle in leistungskontrollen)
                                if (leistungskontrolle.datum!.isAfter(DateTime.now()))
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Text(leistungskontrolle.art ?? "Klausur",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                          DateFormat('EE, d.M.y').format(leistungskontrolle.datum!),
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.fade,
                                          maxLines: 1)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }));
        });
  }
}