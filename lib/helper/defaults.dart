import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';

Map getDefaultVertretung() {
  return {
    "heute": {"information": "", "vertretung": [], "day": "", "date": ""},
    "morgen": {"information": "", "vertretung": [], "day": "", "date": ""},
    "lastUpdate": "empty",
    "last": "empty",
    "urls": ""
  };
}

Map getDefaultTable() {
  Map stundenplan = {};
  List days = ["montag", "dienstag", "mittwoch", "donnerstag", "freitag"];
  for (String day in days) {
    stundenplan[day] = {};
    for (int i = 1; i <= 12; i++) {
      stundenplan[day]['$i'] = {"F": "", "R": "", "L": "", "I": "", "A": ""};
    }
  }

  return stundenplan;
}

String getDefaultColors() {
  return jsonEncode({
    "REV": Colors.grey.shade500.value,
    "RKA": Colors.grey.shade500.value,
    "ETHI": Colors.grey.shade500.value,
    "POWI": Colors.pink.shade100.value,
    "INFO": Colors.teal.shade100.value,
    "BIO": Colors.greenAccent.shade100.value,
    "SPA": Colors.orange.shade100.value,
    "SPO": Colors.grey.shade300.value,
    "EK": Colors.green.shade100.value,
    "MU": Colors.yellowAccent.shade100.value,
    "KU": Colors.cyan.shade100.value,
    "CH": Colors.limeAccent.shade100.value,
    "PH": Colors.deepPurple.shade100.value,
    "M": Colors.blue.shade100.value,
    "D": Colors.red.shade100.value,
    "E": Colors.yellow.shade100.value,
    "F": Colors.deepOrangeAccent.shade100.value,
    "G": Colors.brown.shade100.value,
    "L": Colors.lime.shade100.value,
    "ITA": Colors.purple.shade100.value,
    "DSP": Colors.indigo.shade100.value,
  });
}

String getFach(String fach) {
  switch (fach) {
    case "REV":
    case "RKA":
      return "Religion";
    case "ETHI":
      return "Ethik";
    case "POWI":
      return "Politik und Wirtschaft";
    case "INFO":
      return "Informatik";
    case "BIO":
      return "Biologie";
    case "SPA":
      return "Spanisch";
    case "SPO":
      return "Sport";
    case "EK":
      return "Erdkunde";
    case "MU":
      return "Musik";
    case "KU":
      return "Kunst";
    case "CH":
      return "Chemie";
    case "PH":
      return "Physik";
    case "M":
      return "Mathematik";
    case "D":
      return "Deutsch";
    case "E":
      return "Englisch";
    case "F":
      return "Französisch";
    case "ITA":
      return "Italienisch";
    case "G":
      return "Geschichte";
    case "L":
      return "Latein";
    case "DSP":
      return "Darstellendes Spiel";
    default:
      return fach;
  }
}

List getColors() {
  return [
    {"name": "Aquamarin", "normal": Colors.teal.shade100.value, "akzent": Colors.tealAccent.shade100.value},
    {"name": "Grün", "normal": Colors.green.shade100.value, "akzent": Colors.greenAccent.shade100.value},
    {"name": "Hellgrün", "normal": Colors.lightGreen.shade100.value, "akzent": Colors.lightGreenAccent.shade100.value},
    {"name": "Lindgelb", "normal": Colors.lime.shade100.value, "akzent": Colors.limeAccent.shade100.value},
    {"name": "Gelb", "normal": Colors.yellow.shade100.value, "akzent": Colors.yellowAccent.shade100.value},
    {"name": "Bernstein", "normal": Colors.amber.shade100.value, "akzent": Colors.amberAccent.shade100.value},
    {"name": "Orange", "normal": Colors.orange.shade100.value, "akzent": Colors.orangeAccent.shade100.value},
    {"name": "Rot-Orange", "normal": Colors.deepOrange.shade100.value, "akzent": Colors.deepOrangeAccent.shade100.value},
    {"name": "Rot", "normal": Colors.red.shade100.value, "akzent": Colors.redAccent.shade100.value},
    {"name": "Pink", "normal": Colors.pink.shade100.value, "akzent": Colors.pinkAccent.shade100.value},
    {"name": "Lila", "normal": Colors.purple.shade100.value, "akzent": Colors.purpleAccent.shade100.value},
    {"name": "Dunkles Lila", "normal": Colors.deepPurple.shade100.value, "akzent": Colors.deepPurpleAccent.shade100.value},
    {"name": "Indigo", "normal": Colors.indigo.shade100.value, "akzent": Colors.indigoAccent.shade100.value},
    {"name": "Blau", "normal": Colors.blue.shade100.value, "akzent": Colors.blueAccent.shade100.value},
    {"name": "Hellblau", "normal": Colors.lightBlue.shade100.value, "akzent": Colors.lightBlueAccent.shade100.value},
    {"name": "Cyan", "normal": Colors.cyan.shade100.value, "akzent": Colors.cyanAccent.shade100.value},
    {"name": "Blau-Grau", "normal": Colors.blueGrey.shade200.value, "akzent": Colors.blueGrey.shade300.value},
    {"name": "Grau", "normal": Colors.grey.shade300.value, "akzent": Colors.grey.shade500.value},
    {"name": "Braun", "normal": Colors.brown.shade100.value, "akzent": Colors.brown.shade300.value},
  ];
}

Widget buildZeitColumn(BuildContext ctx, bool online) {
  Size logicalScreenSize = View.of(ctx).physicalSize / View.of(ctx).devicePixelRatio;
  double cellWidth = 0;
  double cellHeight = 64;
  if (MediaQuery.of(ctx).orientation == Orientation.portrait) {
    cellWidth = (logicalScreenSize.width / 11) - 8;
    if (Platform.isAndroid) {
      double appBarHeight =
          (Scaffold.of(ctx).appBarMaxHeight ?? 0) + kToolbarHeight + 40;
      cellHeight = (logicalScreenSize.height - appBarHeight) / 12;
    } else if (Platform.isIOS) {
      cellHeight = (logicalScreenSize.height) / 12.5 - (online ? 18 : 23);
    }
  } else {
    cellWidth = (logicalScreenSize.width / 6) - 8;
    // TODO: unterschied tablet handy
  }

  List timeList = [
    "07:55 - 08:40",
    "08:45 - 09:30",
    "09:45 - 10.30",
    "10:35 - 11:20",
    "11:35 - 12:20",
    "12:25 - 13:10",
    "13:15 - 14:00",
    "14:05 - 14:50",
    "14:50 - 15:35",
    "15:40 - 16:25",
    "16:25 - 17:10"
  ];


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
                            color:
                                Theme.of(ctx).colorScheme.onSecondaryContainer),
                      )))
            ]),
    )
  ];

  for (int i = 1; i <= 11; i++) {
    columns.add(GestureDetector(
      onTap: cellWidth < 100
          ? () => showDialog(
              context: ctx,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("$i. Stunde"),
                  content: Text(timeList[i - 1]),
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
                        color: Theme.of(ctx).colorScheme.onSecondaryContainer)),
              )
            : Column(children: [
                Text(i.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(ctx).colorScheme.onSecondaryContainer)),
                Container(
                    height: 30,
                    margin: const EdgeInsets.all(2.0),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(timeList[i - 1],
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
