import 'package:flutter/material.dart';

int getDefaultColor(String fach) {
  fach = fach.toUpperCase();
  if (fach.contains("REV") ||
      fach.contains("RKA") ||
      fach.contains("RJÜD")) {
    return Colors.grey.shade300.value;
  } else if (fach.contains("ETH")) {
    return Colors.grey.shade300.value;
  }
  else if (fach.contains("POWI") || fach.contains("PW")) {
    return Colors.pink.shade100.value;
  } else if (fach.contains("INF")) {
    return Colors.teal.shade100.value;
  } else if (fach.contains("BIO")) {
    return Colors.lightGreen.shade100.value;
  } else if (fach.contains("DSP")) {
    return Colors.cyan.shade100.value;
  } else if (fach.contains("SPO")) {
    return Colors.blueGrey.shade200.value;
  } else if (fach.contains("EK")) {
    return Colors.green.shade100.value;
  } else if (fach.contains("GEO")) {
    return Colors.green.shade100.value;
  }else if (fach.contains("MU")) {
    return Colors.yellow.shade100.value;
  } else if (fach.contains("KU")) {
    return Colors.purple.shade100.value;
  } else if (fach.contains("PH")) {
    return Colors.deepPurple.shade100.value;
  } else if (fach.contains("CH")) {
    return Colors.lime.shade100.value;
  }else if (fach.contains("M")) {
    return Colors.lightBlue.shade100.value;
  } else if (fach.contains("F")) {
    return Colors.orange.shade100.value;
  } else if (fach.contains("SPA")) {
    return Colors.orange.shade100.value;
  } else if (fach.contains("IT")) {
    return Colors.orange.shade100.value;
  } else if (fach.contains("E")) {
    return Colors.amber.shade100.value;
  } else if (fach.contains("D")) {
    return Colors.red.shade100.value;
  } else if (fach.contains("G") && !fach.contains("_G")) {
    return Colors.brown.shade100.value;
  } else if (fach.contains("L") && !fach.contains("_L")) {
    return Colors.indigo.shade100.value;
  } else {
    return 4294967295;
  }
}

String? getDefaultName(String fach) {
  fach = fach.toUpperCase();
  if (fach.contains("REV") ||
      fach.contains("RKA") ||
      fach.contains("RJÜD")) {
    return "Religion";
  } else if (fach.contains("ETH")) {
    return "Ethik";
  }
  else if (fach.contains("POWI") || fach.contains("PW")) {
    return "Politik und Wirtschaft";
  } else if (fach.contains("INF")) {
    return "Informatik";
  } else if (fach.contains("BIO")) {
    return "Biologie";
  } else if (fach.contains("DSP")) {
    return "Darstellendes Spiel";
  } else if (fach.contains("SPO")) {
    return "Sport";
  } else if (fach.contains("EK")) {
    return "Erdkunde";
  } else if (fach.contains("GEO")) {
    return "Geologie";
  }else if (fach.contains("MU")) {
    return "Musik";
  } else if (fach.contains("KU")) {
    return "Kunst";
  } else if (fach.contains("PH")) {
    return "Physik";
  } else if (fach.contains("CH")) {
    return "Chemie";
  } else if (fach.contains("M")) {
    return "Mathematik";
  } else if (fach.contains("F")) {
    return "Französisch";
  } else if (fach.contains("SPA")) {
    return "Spanisch";
  } else if (fach.contains("IT")) {
    return "Italienisch";
  } else if (fach.contains("E")) {
    return "Englisch";
  } else if (fach.contains("D")) {
    return "Deutsch";
  } else if (fach.contains("G") && !fach.contains("_G")) {
    return "Geschichte";
  } else if (fach.contains("L") && !fach.contains("_L")) {
    return "Latein";
  }
  return null;
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
