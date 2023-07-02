import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sphplaner/helper/backend.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/theme.dart';

class Stundenplan extends StatefulWidget {
  const Stundenplan({super.key});

  @override
  State<Stundenplan> createState() => _Stundenplan();
}

class _Stundenplan extends State<Stundenplan> {
  bool updateLock = false;

  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<Backend, String>(
        properties: const ['vertretungsplan', 'planerView', 'online'],
        builder: (context, backend, child) {
          List<Widget> sortedDays = [];
          List dateToday =
              backend!.vertretungsplan['heute']['date'].toString().split(".");
          List dateTomorrow =
              backend.vertretungsplan['morgen']['date'].toString().split(".");

          if (dateToday.length > 1 && dateTomorrow.length > 1) {
            for (int i = 0; i <= 1; i++) {
              if (dateToday[i].toString().length == 1) {
                dateToday[i] = "0${dateToday[i]}";
              }
              if (dateTomorrow[i].toString().length == 1) {
                dateTomorrow[i] = "0${dateTomorrow[i]}";
              }
            }

            DateTime today = DateTime.parse(
                '${dateToday[2]}-${dateToday[1]}-${dateToday[0]} 18:00:00');
            DateTime tomorrow = DateTime.parse(
                '${dateTomorrow[2]}-${dateTomorrow[1]}-${dateTomorrow[0]} 18:00:00');

            for (int i = 1; i <= 5; i++) {
              sortedDays.add(_getDay(
                  i,
                  i == today.weekday && (DateTime.now().isBefore(today) || !backend.hideToday) ||
                      i == tomorrow.weekday &&
                          (DateTime.now().isBefore(tomorrow) || !backend.hideToday)));
            }
          } else {
            for (int i = 1; i <= 5; i++) {
              sortedDays.add(_getDay(i, false));
            }
          }

          return SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildZeitColumn(context, backend.sphLogin),
                Flexible(
                  child: Row(
                    children: sortedDays,
                  ),
                ),
              ],
            ),
          );
        });
  }

  _getDay(int day, bool vertretung) {
    switch (day) {
      case 1:
        return _buildDay("Montag", vertretung);
      case 2:
        return _buildDay("Dienstag", vertretung);
      case 3:
        return _buildDay("Mittwoch", vertretung);
      case 4:
        return _buildDay("Donnerstag", vertretung);
      case 5:
        return _buildDay("Freitag", vertretung);
    }
  }

  Widget _buildDay(String day, bool showVertretung) {
    return Row(children: [
      Column(
          children: List.generate(
              12, (index) => _buildCell(day, index.toString(), showVertretung)))
    ]);
  }

  Widget _buildCell(String day, String column, bool showVertretung) {
    return PropertyChangeConsumer<Backend, String>(
      properties: const ['stundenplan', 'colors'],
      builder: (context, backend, child) {
        Size logicalScreenSize = View.of(context).physicalSize / View.of(context).devicePixelRatio;
        double cellWidth = 0;
        double cellHeight = 64;
        if (logicalScreenSize.height > logicalScreenSize.width) {
          cellWidth = (logicalScreenSize.width / 5.5) - 8;
          double appBarHeight = (Scaffold.of(context).appBarMaxHeight ?? 0) +
              kToolbarHeight +
              40;
          cellHeight = (logicalScreenSize.height - appBarHeight) / 12;
          if (Platform.isIOS) {
            //TODO: auf Apple testen
          }
        } else {
          cellWidth = (logicalScreenSize.width / 6) - 8;
          double appBarHeight = (Scaffold.of(context).appBarMaxHeight ?? 0) +
              kToolbarHeight +
              40;
          cellHeight = max(64, (logicalScreenSize.height - appBarHeight) / 12);
        }

        if (column == "0") {
          String relativeDay = "heute";
          if (day.toLowerCase() ==
              backend!.vertretungsplan['morgen']['day']
                  .toString()
                  .toLowerCase()) {
            relativeDay = "morgen";
          }

          String date = "";
          bool infoBorder = false;
          String information = "Noch keine Informationen verfügbar.";
          if (showVertretung) {
            date = backend.vertretungsplan[relativeDay]['date'];
            infoBorder =
                backend.vertretungsplan[relativeDay]['information'] != "";
            information = backend.vertretungsplan[relativeDay]['information'];
          }

          return GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _showDayInfo(day, date, information, context);
                    });
              },
              child: Container(
                  width: cellWidth,
                  height: cellHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: infoBorder
                        ? Border.all(color: Colors.red)
                        : Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  margin: const EdgeInsets.all(4.0),
                  child: Center(
                    child: cellWidth < 112
                        ? Text(day.substring(0, 2),
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: showVertretung
                                    ? sphBlue
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer))
                        : Column(
                            children: [
                              Text(day,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: showVertretung
                                          ? sphBlue
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer)),
                              Text(
                                date,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic),
                              )
                            ],
                          ),
                  )));
        }

        bool doppelstunde = true;
        int offset = 0;

        if (backend!.stundenplan[day.toLowerCase()][column]["F"] != "") {
          List<String> compare = ["F", "R", "L"];
          if (showVertretung) {
            compare.addAll(["I", "A"]);
          }

          if (int.parse(column) % 2 == 1 && int.parse(column) <= 6 ||
              int.parse(column) % 2 == 0 && int.parse(column) > 6) {
            offset = 1;
          }
          if (int.parse(column) % 2 == 0 && int.parse(column) <= 6 ||
              int.parse(column) % 2 == 1 && int.parse(column) > 6) {
            offset = -1;
          }

          if (offset != 0) {
            for (String key in compare) {
              if (backend.stundenplanVertr[day.toLowerCase()][column][key] !=
                  backend.stundenplanVertr[day.toLowerCase()]
                      ["${int.parse(column) + offset}"][key]) {
                doppelstunde = false;
                break;
              }
            }
          } else {
            doppelstunde = false;
          }

          if (doppelstunde) {
            if (offset < 0) {
              cellHeight = 0;
            } else {
              cellHeight = 2 * (cellHeight + 4);
            }
          }
        }

        bool showHA = false;

        Color fachColor = Colors.black;
        Color raumColor = Colors.black;
        Color lehrerColor = Colors.black;
        Color backgroundColor =
            Theme.of(context).colorScheme.tertiaryContainer.withOpacity(.25);
        String fach = "";
        String fachOriginal = "";
        String raum = "";
        String lehrer = "";
        String info = "";
        try {
          if (showVertretung) {
            fach = backend.stundenplanVertr[day.toLowerCase()][column]["F"];
            fachOriginal = backend.stundenplan[day.toLowerCase()][column]["F"];
            raum = backend.stundenplanVertr[day.toLowerCase()][column]["R"];
            lehrer = backend.stundenplanVertr[day.toLowerCase()][column]["L"];
            info = backend.stundenplanVertr[day.toLowerCase()][column]["I"];
          } else {
            fach = backend.stundenplan[day.toLowerCase()][column]["F"];
            fachOriginal = backend.stundenplan[day.toLowerCase()][column]["F"];
            raum = backend.stundenplan[day.toLowerCase()][column]["R"];
            lehrer = backend.stundenplan[day.toLowerCase()][column]["L"];
          }
        } catch (_) {}
        String homeworks = "";
        for (String ha in backend.homework) {
          Map hausaufgabe = json.decode(ha);
          if (fach == hausaufgabe['fach']) {
            if (homeworks == "") {
              homeworks = "\nHausaufgaben:";
            }

            showHA = true;
            homeworks +=
                "\n\t- \"${hausaufgabe['titel']}\" bis ${DateFormat("dd.MM.yy").format(DateTime.fromMillisecondsSinceEpoch(hausaufgabe['due']))}";
          }
        }

        bool border = false;
        RegExp reg = RegExp(
          r"[A-Z]+-[GLT]\d",
          caseSensitive: false,
          multiLine: false,
        );
        String fachId = fach;
        if (fach != "") {
          if (fachId == "---") {
            //damit Farbe richtig gesetzt werden kann
            fachId = fachOriginal;
            raum = "---";
            lehrer = "---";
          }

          if (fachId.startsWith("W")) {
            fachId = fachId.split("_")[2];
          }
          if (fachId.contains("_")) {
            fachId = fachId.split("_")[0];
          }
          if (reg.hasMatch(fachId)) {
            fachId = fachId.split("-")[0];
          }

          backgroundColor =
              Color(backend.colors[fachId] ?? backgroundColor.value);

          if (fach == "---") {
            //damit nach farbsetzung wieder entfall angezeigt werden kann
            fachId = fach;
          }

          if (fach != fachOriginal) {
            fachColor = Colors.red;
            lehrer = "";
          }
          if (raum != backend.stundenplan[day.toLowerCase()][column]["R"]) {
            raumColor = Colors.red;
          }
          if (fach == "---") {
            lehrer = "---";
            lehrerColor = Colors.red;
          }

          if (info != "") {
            border = true;
          }
        }
        if (cellHeight > 0) {
          return GestureDetector(
              onTap: () {
                if (fach != "") {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _showInfo(day, column, homeworks, showVertretung,
                            doppelstunde);
                      });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return _editCell(day, column);
                      });
                }
              },
              onLongPress: () async {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _editCell(day, column);
                    });
              },
              child: Container(
                width: cellWidth,
                height: cellHeight,
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: border
                      ? Border.all(color: Colors.red)
                      : Border.all(color: backgroundColor),
                  color: backgroundColor,
                ),
                child: Stack(
                  children: [
                    if (showHA)
                      Padding(
                        padding: cellWidth < 112 ? const EdgeInsets.all(0.0) : const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.4),
                              child: const Icon(
                                Icons.home_work,
                                color: Colors.red,
                              ),
                            )),
                      ),
                    Align( //TODO: warum doppelt aligned
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: cellWidth,
                          height:
                              cellHeight <= 64 ? cellHeight : cellHeight / 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: cellHeight > 64
                                  ? cellHeight / 2
                                  : cellHeight,
                              child: Column(children: [
                                Text(
                                  cellWidth < 112 ? fachId : fach,
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(fontSize: cellWidth < 112 ? 18 : 20, color: fachColor, fontWeight: cellWidth < 112 ? null : FontWeight.bold),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                cellWidth < 112
                                    ? Text(
                                        raum,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: raumColor,
                                            fontStyle: FontStyle.italic),
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                      )
                                    : Row(
                                        children: [
                                          Container(
                                            width: cellWidth / 2 - 8,
                                            padding: const EdgeInsets.fromLTRB(
                                                4, 4, 4, 0),
                                            child: Text(
                                              raum,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: raumColor,
                                                  fontStyle: FontStyle.italic),
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                          ),
                                          Container(
                                            width: cellWidth / 2 - 8,
                                            padding: const EdgeInsets.fromLTRB(
                                                4, 4, 4, 0),
                                            child: Text(
                                              lehrer,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: lehrerColor,
                                                  fontStyle: FontStyle.italic),
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                          )
                                        ],
                                      )
                              ]),
                            ),
                          )),
                    ),
                  ],
                ),
              ));
        }
        return Container();
      },
    );
  }

  Widget _showDayInfo(
      String day, String date, String information, BuildContext ctx) {
    return AlertDialog(
      title: Text(
        'Information für $day\n$date',
        textAlign: TextAlign.center,
      ),
      content: information != ""
          ? Text(information)
          : const Text("Keine Informationen"),
      scrollable: true,
    );
  }

  Widget _editCell(String day, String column) {
    return PropertyChangeConsumer<Backend, String>(
      properties: const ['stundenplan'],
      builder: (context, backend, child) {
        TextEditingController fachController = TextEditingController();
        TextEditingController lehrerController = TextEditingController();
        TextEditingController raumController = TextEditingController();

        final ValueNotifier<bool> doppelstunde = ValueNotifier<bool>(false);

        String fach = "";
        String raum = "";
        String lehrer = "";

        String fachText = "Fach";
        String raumText = "Raum";
        String lehrerText = "Lehrer";
        try {
          fach = backend!.stundenplan[day.toLowerCase()][column]["F"];
          raum = backend.stundenplan[day.toLowerCase()][column]["R"];
          lehrer = backend.stundenplan[day.toLowerCase()][column]["L"];
        } catch (_) {}

        if (fach != "") {
          fachText += " ($fach)";
        }
        if (raum != "") {
          raumText += " ($raum)";
        }
        if (lehrer != "") {
          lehrerText += " ($lehrer)";
        }

        return AlertDialog(
          title: Text('Bearbeite $day, $column. Stunde'),
          scrollable: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: 64,
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: fachController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: fachText,
                        hintText: fach),
                  )),
              Container(
                  height: 64,
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: raumController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: raumText,
                        hintText: raum),
                  )),
              Container(
                  height: 64,
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: lehrerController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: lehrerText,
                        hintText: lehrer),
                  )),
              if (int.parse(column) < 11)
                Container(
                    height: 64,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        const Expanded(child: Text("Doppelstunde")),
                        ValueListenableBuilder<bool>(
                            valueListenable: doppelstunde,
                            builder: (BuildContext context, bool value,
                                Widget? child) {
                              return Switch(
                                value: doppelstunde.value,
                                onChanged: (changed) {
                                  doppelstunde.value = changed;
                                },
                              );
                            })
                      ],
                    )),
              const Text(
                  "Bitte trage das Fach und Raum so ein, wie es auch auf dem Vertretungsplan steht (z.B.: D statt Deutsch).")
            ],
          ),
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                      Theme.of(context).colorScheme.error,
                    ),
                  ),
                  onPressed: () {
                    Map stundenplan = backend!.stundenplan;
                    if (fach != "") {
                      stundenplan[day.toLowerCase()][column]["F"] = "";
                      stundenplan[day.toLowerCase()][column]["R"] = "";
                      stundenplan[day.toLowerCase()][column]["L"] = "";

                      if (doppelstunde.value) {
                        column = "${int.parse(column) + 1}";
                        stundenplan[day.toLowerCase()][column]["F"] = "";
                        stundenplan[day.toLowerCase()][column]["R"] = "";
                        stundenplan[day.toLowerCase()][column]["L"] = "";
                      }
                    }
                    backend.stundenplan = stundenplan;
                    Navigator.pop(context);
                  },
                  child: Text('Löschen',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onError))),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 32, 16),
              child: ElevatedButton(
                  onPressed: () async {
                    Map stundenplan = backend!.stundenplan;
                    if (fachController.text == "" && doppelstunde.value) {
                      fachController.text = fach;
                    }
                    if (raumController.text == "" && doppelstunde.value) {
                      raumController.text = raum;
                    }
                    if (lehrerController.text == "" && doppelstunde.value) {
                      lehrerController.text = lehrer;
                    }
                    if (fachController.text != "") {
                      stundenplan[day.toLowerCase()][column]["F"] =
                          fachController.text.toUpperCase();
                      if (doppelstunde.value) {
                        String tmpColumn = "${int.parse(column) + 1}";
                        stundenplan[day.toLowerCase()][tmpColumn]["F"] =
                            fachController.text.toUpperCase();
                      }
                    }
                    if (raumController.text != "") {
                      String newRaum = raumController.text;
                      if (int.tryParse(newRaum) != null) {
                        int raum = int.parse(newRaum);
                        if (raum < 300) {
                          newRaum = "R$newRaum";
                        } else if (raum >= 400) {
                          newRaum = "S$newRaum";
                        } else {
                          newRaum = "P$newRaum";
                        }
                      }
                      stundenplan[day.toLowerCase()][column]["R"] =
                          newRaum.toUpperCase();
                      if (doppelstunde.value) {
                        String tmpColumn = "${int.parse(column) + 1}";
                        stundenplan[day.toLowerCase()][tmpColumn]["R"] =
                            newRaum.toUpperCase();
                      }
                    }
                    if (lehrerController.text != "") {
                      stundenplan[day.toLowerCase()][column]["L"] =
                          lehrerController.text.toUpperCase();
                      if (doppelstunde.value) {
                        String tmpColumn = "${int.parse(column) + 1}";
                        stundenplan[day.toLowerCase()][tmpColumn]["L"] =
                            lehrerController.text.toUpperCase();
                      }
                    }
                    backend.stundenplan = stundenplan;
                    Navigator.pop(context);
                  },
                  child: const Text('Speichern')),
            ),
          ],
        );
      },
    );
  }

  Widget _showInfo(String day, String column, String homework,
      bool showVertretung, bool doppelstunde) {
    return PropertyChangeConsumer<Backend, String>(
      properties: const ['stundenplan'],
      builder: (context, backend, child) {
        String informationen = "";
        String art = "";
        String fach = "";
        String plan = "";
        RegExp reg = RegExp(
          r"[A-Z]+-[GLT]\d",
          caseSensitive: false,
          multiLine: false,
        );

        fach = backend!.stundenplan[day.toLowerCase()][column]["F"];
        String fachID = fach;
        if (reg.hasMatch(fach)) {
          fach = getFach(fach.split("-")[0]);
        }

        if (fach != "") {
          plan = "Dein ursprünglicher Stundenplan:\n${getFach(fach)} ($fachID)";
          if (backend.stundenplan[day.toLowerCase()][column]["R"] != null) {
            plan +=
                " in Raum ${backend.stundenplan[day.toLowerCase()][column]["R"]}";
          }
          if (backend.stundenplan[day.toLowerCase()][column]["L"] != null) {
            plan +=
                " bei ${backend.stundenplan[day.toLowerCase()][column]["L"]}\n";
          }
          plan += "\n";

          if (showVertretung) {
            if (backend.stundenplanVertr[day.toLowerCase()][column]["A"] !=
                null) {
              art = backend.stundenplanVertr[day.toLowerCase()][column]["A"] +
                  "\n";
            }
            if (backend.stundenplanVertr[day.toLowerCase()][column]["I"] !=
                null) {
              informationen = backend.stundenplanVertr[day.toLowerCase()]
                      [column]["I"] +
                  "\n";
            }
          }
        } else {
          plan = "Kein Unterricht";
        }

        List<Widget> actions = [
          TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _editCell(day, column);
                    });
              },
              child: Text("$column. Std. bearbeiten"))
        ];

        String hour = column;
        if (doppelstunde) {
          hour = "$column-${int.parse(column) + 1}";
          actions.add(TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return _editCell(day, column);
                    });
              },
              child: Text("${int.parse(column) + 1}. Std. bearbeiten")));
        }

        return AlertDialog(
          title: Text(
            'Information zu ${getFach(fach)}\n($day, $hour. Std.)',
            textAlign: TextAlign.center,
          ),
          content: Text('$plan$art$informationen$homework',
              textAlign: TextAlign.left),
          actions: actions,
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}
