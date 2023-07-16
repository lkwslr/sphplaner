import 'dart:convert';

import 'package:flutter/material.dart';

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

int getDefaultColor(String fach) {
  //TODO: regex for fächer
  return 4294967295;
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
    {
      "name": "Aquamarin",
      "normal": Colors.teal.shade100.value,
      "akzent": Colors.tealAccent.shade100.value
    },
    {
      "name": "Grün",
      "normal": Colors.green.shade100.value,
      "akzent": Colors.greenAccent.shade100.value
    },
    {
      "name": "Hellgrün",
      "normal": Colors.lightGreen.shade100.value,
      "akzent": Colors.lightGreenAccent.shade100.value
    },
    {
      "name": "Lindgelb",
      "normal": Colors.lime.shade100.value,
      "akzent": Colors.limeAccent.shade100.value
    },
    {
      "name": "Gelb",
      "normal": Colors.yellow.shade100.value,
      "akzent": Colors.yellowAccent.shade100.value
    },
    {
      "name": "Bernstein",
      "normal": Colors.amber.shade100.value,
      "akzent": Colors.amberAccent.shade100.value
    },
    {
      "name": "Orange",
      "normal": Colors.orange.shade100.value,
      "akzent": Colors.orangeAccent.shade100.value
    },
    {
      "name": "Rot-Orange",
      "normal": Colors.deepOrange.shade100.value,
      "akzent": Colors.deepOrangeAccent.shade100.value
    },
    {
      "name": "Rot",
      "normal": Colors.red.shade100.value,
      "akzent": Colors.redAccent.shade100.value
    },
    {
      "name": "Pink",
      "normal": Colors.pink.shade100.value,
      "akzent": Colors.pinkAccent.shade100.value
    },
    {
      "name": "Lila",
      "normal": Colors.purple.shade100.value,
      "akzent": Colors.purpleAccent.shade100.value
    },
    {
      "name": "Dunkles Lila",
      "normal": Colors.deepPurple.shade100.value,
      "akzent": Colors.deepPurpleAccent.shade100.value
    },
    {
      "name": "Indigo",
      "normal": Colors.indigo.shade100.value,
      "akzent": Colors.indigoAccent.shade100.value
    },
    {
      "name": "Blau",
      "normal": Colors.blue.shade100.value,
      "akzent": Colors.blueAccent.shade100.value
    },
    {
      "name": "Hellblau",
      "normal": Colors.lightBlue.shade100.value,
      "akzent": Colors.lightBlueAccent.shade100.value
    },
    {
      "name": "Cyan",
      "normal": Colors.cyan.shade100.value,
      "akzent": Colors.cyanAccent.shade100.value
    },
    {
      "name": "Blau-Grau",
      "normal": Colors.blueGrey.shade200.value,
      "akzent": Colors.blueGrey.shade300.value
    },
    {
      "name": "Grau",
      "normal": Colors.grey.shade300.value,
      "akzent": Colors.grey.shade500.value
    },
    {
      "name": "Braun",
      "normal": Colors.brown.shade100.value,
      "akzent": Colors.brown.shade300.value
    },
  ];
}
