import 'package:flutter/material.dart';

class EasterEgg extends StatefulWidget {
  const EasterEgg({super.key});

  @override
  State<EasterEgg> createState() => _EasterEgg();
}

class _EasterEgg extends State<EasterEgg> {
  int spielzug = 0;
  String win = "false";
  List<String> toe = ["", "", "", "", "", "", "", "", ""];
  late double colWidth;

  @override
  Widget build(BuildContext context) {
    Size logicalScreenSize =
        View.of(context).physicalSize / View.of(context).devicePixelRatio;
    double logicalWidth = logicalScreenSize.width;
    colWidth = (logicalWidth - 56) / 6;

    List tictactoe = [];

    for (int i = 0; i < toe.length; i++) {
      if (toe[i] == "X") {
        tictactoe.add(Container(
          height: double.infinity,
          margin: const EdgeInsets.all(4.0),
          child: const Center(
            child: Text("X",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.red)),
          ),
        ));
      } else if (toe[i] == "O") {
        tictactoe.add(Container(
          height: double.infinity,
          margin: const EdgeInsets.all(4.0),
          child: const Center(
            child: Text("O",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Color(0xFF0575E6))),
          ),
        ));
      } else {
        tictactoe.add(GestureDetector(
            onTap: () {
              if (win == "false") {
                toe[i] = spielzug % 2 == 0 ? "X" : "O";

                if (spielzug >= 8 && checkWin(toe[i]) == false) {
                  win = "tie";
                } else if (checkWin(toe[i]) == false) {
                  spielzug++;
                } else {
                  win = "true";
                }

                setState(() {});
              }
            },
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  border: win != "false"
                      ? Border.all(color: Colors.transparent)
                      : Border.all(color: Theme.of(context).primaryColorLight)),
              child: const Text(""),
            )));
      }
    }

    String text = "An der Reihe ist: ${spielzug % 2 == 0 ? "X" : "O"}";
    if (win == "true") {
      text = "Gewinner: ${spielzug % 2 == 0 ? "X" : "O"}";
    } else if (win == "tie") {
      text = "Unentschieden - alle Felder sind ausgefüllt";
    }

    return Scaffold(
        appBar: AppBar(title: const Text("Minigames")),
        body: Container(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                //Tic-Tac-Toe
                const Center(
                  child: Text("Tic-Tac-Toe",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
                ),
                Center(
                  child: Text(text),
                ),
                Container(
                  height: colWidth,
                  padding: EdgeInsets.fromLTRB(colWidth, 0, colWidth, 0),
                  child: Row(children: [
                    Expanded(child: tictactoe[0]),
                    Expanded(child: tictactoe[1]),
                    Expanded(child: tictactoe[2])
                  ]),
                ),
                Container(
                  height: colWidth,
                  padding: EdgeInsets.fromLTRB(colWidth, 0, colWidth, 0),
                  child: Row(children: [
                    Expanded(child: tictactoe[3]),
                    Expanded(child: tictactoe[4]),
                    Expanded(child: tictactoe[5])
                  ]),
                ),
                Container(
                  height: colWidth,
                  padding: EdgeInsets.fromLTRB(colWidth, 0, colWidth, 0),
                  child: Row(children: [
                    Expanded(child: tictactoe[6]),
                    Expanded(child: tictactoe[7]),
                    Expanded(child: tictactoe[8])
                  ]),
                ),
                Container(
                  height: colWidth,
                  padding: EdgeInsets.fromLTRB(colWidth, 0, colWidth, 0),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                toe = ["", "", "", "", "", "", "", "", ""];
                                spielzug = 0;
                                win = "false";
                                setState(() {});
                              },
                              child: const Text("Neues Spiel")))
                    ],
                  ),
                ),
                //^^^ Tic-Tac-Toe ^^^
                // ...
              ],
            )));
  }

  checkWin(String player) {
    if (toe[0] == player && toe[1] == player && toe[2] == player ||
        toe[3] == player && toe[4] == player && toe[5] == player ||
        toe[6] == player && toe[7] == player && toe[8] == player ||
        toe[0] == player && toe[3] == player && toe[6] == player ||
        toe[1] == player && toe[4] == player && toe[7] == player ||
        toe[2] == player && toe[5] == player && toe[8] == player ||
        toe[0] == player && toe[4] == player && toe[8] == player ||
        toe[2] == player && toe[4] == player && toe[6] == player) {
      return true;
    }

    return false;
  }
}
