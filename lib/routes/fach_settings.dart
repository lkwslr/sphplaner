import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/helper/storage/subject.dart';

class FachSettings extends StatefulWidget {
  const FachSettings({Key? key, required this.subject}) : super(key: key);
  final Subject subject;

  @override
  State<FachSettings> createState() => _FachSettings();
}

class _FachSettings extends State<FachSettings> {
  late Subject subject;
  Map colors = jsonDecode(getDefaultColors());
  late Size logicalScreenSize;
  double buttonSizeFactor = 40;

  TextEditingController? subjectNameController;

  @override
  Widget build(BuildContext context) {
    subject = widget.subject;
    StorageNotifier notify = PropertyChangeProvider.of<StorageNotifier, String>(
            context,
            listen: true,
            properties: ['settings'])!
        .value;

    subjectNameController ??= TextEditingController(
        text: widget.subject.subjectName != widget.subject.subject
            ? widget.subject.subjectName
            : null);

    logicalScreenSize =
        View.of(context).physicalSize / View.of(context).devicePixelRatio;
    if (logicalScreenSize.height < logicalScreenSize.width) {
      buttonSizeFactor = min(max(40.0, logicalScreenSize.height / 12), 64.0);
    } else {
      buttonSizeFactor = 40;
    }

    List<Widget> listitems = [
      const Align(
        alignment: Alignment.center,
        child: Text(
          "Alle Einstellungen werden automatisch gespeichert!",
          style: TextStyle(
              fontStyle: FontStyle.italic, fontSize: 16, color: Colors.red),
        ),
      ),
      const SizedBox(
        height: 32,
      ),
      const Align(
        alignment: Alignment.center,
        child: Text("Fachname",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      TextField(
        controller: subjectNameController,
        decoration: InputDecoration(
          hintText: subject.subjectName,
          labelText: "Fachname",
          helperText:
              "Dieser Name wird an unterschiedlichen Orten verwendet, an denen dieses Fach angezeigt wird. Er soll dir helfen, dass Fach besser zu erkennen.\n"
              "\nBeispiel: WP1_SPO_Hj1 kann als Sport angezeigt werden.",
          helperMaxLines: 10,
        ),
        onChanged: (value) async {
          if (value.isEmpty) {
            value = subject.subject!;
          }
          setState(() {
            subject.subjectName = value;
          });
        },
        onTapOutside: (event) async {
          await StorageProvider.isar.writeTxn(() async {
            await StorageProvider.isar.subjects.putBySubject(subject);
          }).then((value) {
            notify.notifyAll(["stundenplan", "settings"]);
          });
        },
      ),
      const SizedBox(
        height: 16,
      ),
      const Align(
        alignment: Alignment.center,
        child: Text("Fachfarbe",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      const SizedBox(
        height: 16,
      )
    ];
    List colorNames = getColors();

    for (Map color in colorNames) {
      HSLColor hslDefault = HSLColor.fromColor(Color(color["normal"]));
      Color lightenedDefault = hslDefault
          .withLightness((hslDefault.lightness + .1).clamp(0.0, 1.0))
          .toColor();

      HSLColor hslAccent = HSLColor.fromColor(Color(color["akzent"]));
      Color lightenedAccent = hslAccent
          .withLightness((hslAccent.lightness + .1).clamp(0.0, 1.0))
          .toColor();

      listitems.addAll([
        Text(color['name']),
        if (buttonSizeFactor > 40)
          const SizedBox(
            height: 8,
          ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: () async {
                subject.color = color["normal"];
                await StorageProvider.isar.writeTxn(() async {
                  await StorageProvider.isar.subjects.putBySubject(subject);
                }).then((value) {
                  notify.notifyAll(["stundenplan", "settings"]);
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: color["normal"] == subject.color
                      ? lightenedDefault
                      : Color(color["normal"]),
                  minimumSize: Size.fromHeight(buttonSizeFactor),
                  side: color["normal"] == subject.color
                      ? const BorderSide(width: 3, color: Colors.green)
                      : null),
              child: color["normal"] == subject.color
                  ? const Icon(
                      Icons.check,
                      color: Colors.green,
                    )
                  : null,
            )),
            const SizedBox(width: 8),
            Expanded(
                child: ElevatedButton(
              onPressed: () async {
                subject.color = color["akzent"];
                await StorageProvider.isar.writeTxn(() async {
                  await StorageProvider.isar.subjects.putBySubject(subject);
                }).then((value) {
                  notify.notifyAll(["stundenplan", "settings"]);
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: color["akzent"] == subject.color
                      ? lightenedAccent
                      : Color(color["akzent"]),
                  minimumSize: Size.fromHeight(buttonSizeFactor),
                  side: color["akzent"] == subject.color
                      ? const BorderSide(width: 3, color: Colors.green)
                      : null),
              child: color["akzent"] == subject.color
                  ? const Icon(Icons.check_rounded, color: Colors.green)
                  : null,
            ))
          ],
        ),
        const SizedBox(height: 16)
      ]);
    }

    return Scaffold(
        appBar: AppBar(title: Text('Einstellungen für ${subject.subjectName}')),
        body: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: ListView(
            children: listitems,
          ),
        ));
  }
}
