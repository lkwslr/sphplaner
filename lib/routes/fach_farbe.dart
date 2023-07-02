import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sphplaner/helper/backend.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class FachFarbe extends StatefulWidget {
  const FachFarbe({Key? key, required this.fach}) : super(key: key);
  final String fach;

  @override
  State<FachFarbe> createState() => _FachFarbe();
}

class _FachFarbe extends State<FachFarbe> {
  late String fach;
  late Map colors;
  late Size logicalScreenSize;
  double buttonSizeFactor = 40;

  @override
  Widget build(BuildContext context) {
    fach = widget.fach;
    colors = PropertyChangeProvider.of<Backend, String>(context, listen: false)!
        .value
        .colors;

    logicalScreenSize = View.of(context).physicalSize / View.of(context).devicePixelRatio;
    if (logicalScreenSize.height < logicalScreenSize.width) {

      buttonSizeFactor = min(max(40.0, logicalScreenSize.height/12), 64.0);
    } else {
      buttonSizeFactor = 40;
    }

    List<Widget> colorList = [
      const Align(
        alignment: Alignment.center,
        child: Text("Wähle eine Farbe durch Klicken aus.", style: TextStyle(fontSize: 20)),
      ),
      const SizedBox(
        height: 16,
      )
    ];
    List colorNames = getColors();

    for (Map color in colorNames) {
      colorList.addAll([
        Text(color['name']),
        if (buttonSizeFactor > 40)
          const SizedBox(height: 8,),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: () {
                colors[fach] = color["normal"];
                PropertyChangeProvider.of<Backend, String>(context,
                        listen: false)!
                    .value
                    .colors = colors;
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(color["normal"]),
                  minimumSize: Size.fromHeight(buttonSizeFactor)
              ),
              child: null,
            )),
            const SizedBox(width: 8),
            Expanded(
                child: ElevatedButton(
              onPressed: () {
                colors[fach] = color["akzent"];
                PropertyChangeProvider.of<Backend, String>(context,
                        listen: false)!
                    .value
                    .colors = colors;
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(color["akzent"]),
              minimumSize: Size.fromHeight(buttonSizeFactor)),
              child: null,
            ))
          ],
        ),
        const SizedBox(height: 16)
      ]);
    }

    return Scaffold(
        appBar: AppBar(title: Text('Farbwahl für $fach')),
        body: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: ListView(
            children: colorList,
          ),
        ));
  }
}
