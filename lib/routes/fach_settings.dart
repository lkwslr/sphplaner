import 'dart:math';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/storage/lesson.dart';
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
  late Size logicalScreenSize;
  double buttonSizeFactor = 40;

  TextEditingController? subjectNameController;
  TextEditingController? subjectController;

  @override
  Widget build(BuildContext context) {
    subject = widget.subject;
    bool isNew = subject.subject == null;
    StorageNotifier notify = PropertyChangeProvider.of<StorageNotifier, String>(
            context,
            listen: true,
            properties: ['settings'])!
        .value;

    subjectNameController ??= TextEditingController(
        text: subject.subjectName != subject.subject
            ? subject.subjectName
            : null);

    subjectController ??= TextEditingController(text: subject.subject ?? "");

    logicalScreenSize =
        View.of(context).physicalSize / View.of(context).devicePixelRatio;
    if (logicalScreenSize.height < logicalScreenSize.width) {
      buttonSizeFactor = min(max(40.0, logicalScreenSize.height / 12), 64.0);
    } else {
      buttonSizeFactor = 40;
    }

    List<Widget> listitems = [
      const SizedBox(
        height: 32,
      ),
      const Align(
        alignment: Alignment.center,
        child: Text("Fachbezeichnung",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      TextField(
        controller: subjectController,
        decoration: InputDecoration(
          hintText: subject.subject,
          labelText: "Fachbezeichnung",
          helperText:
              "Diese Bezeichnung wird zur internen Identifikation verwendet und kann nur einmal vergeben werden.\nSie dient dazu Vertretungen richtig anzuzeigen!\n"
              "\nBeispiel: WP1_SPO_Hj1\n\nÄndere diese nur, wenn du weißt, was du tust!",
          helperMaxLines: 10,
        ),
        onChanged: (value) {
          if (value != "") {
            setState(() {
              subject.subject = value;
            });
          } else {
            setState(() {
              subject.subject = null;
            });
          }
        },
      ),
      const SizedBox(
        height: 16,
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
        onChanged: (value) {
          if (value.isEmpty) {
            value = subject.subject ?? "Kein Name angegeben!";
          }
          setState(() {
            subject.subjectName = value;
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
              onPressed: () {
                setState(() {
                  subject.color = color["normal"];
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
              onPressed: () {
                setState(() {
                  subject.color = color["akzent"];
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
    listitems.addAll([
      const Divider(
        height: 32,
        thickness: 3,
      ),
      ElevatedButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (builder) {
                  return AlertDialog(
                    title: const Text("Fach löschen?"),
                    content: Text(
                        "Möchtest du das Fach (${subject.subject}) wirklich löschen?\nDies kann nicht rückgängig gemacht werden!"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop("0");
                          },
                          child: const Text("Nein")),
                      TextButton(
                          onPressed: () async {
                            await StorageProvider.isar.writeTxn(() async {
                              await StorageProvider.isar.subjects
                                  .delete(subject.id);
                              await StorageProvider.isar.lessons
                                  .filter()
                                  .subject((q) => q.idEqualTo(subject.id))
                                  .deleteAll(); //TODO: test
                            }).then((value) {
                              notify.notifyAll(["stundenplan", "settings"]);
                              Navigator.of(context).pop("1");
                            });
                          },
                          child: const Text("Ja")),
                    ],
                  );
                }).then((value) {
              if (value == "1") {
                Navigator.of(context).pop();
              }
            });
          },
          style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(buttonSizeFactor)),
          child: const Text("Fach löschen")),
      const SizedBox(
        height: 32,
      ),
      ElevatedButton(
          onPressed: () async {
            await StorageProvider.isar.writeTxn(() async {
              if (isNew) {
                await StorageProvider.isar.subjects.putBySubject(subject);
              } else {
                await StorageProvider.isar.subjects.put(subject);
              }
            }).then((value) {
              notify.notifyAll(["stundenplan", "settings"]);
              Navigator.of(context).pop(subject);
            });
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              minimumSize: Size.fromHeight(buttonSizeFactor)),
          child: Text("Änderungen speichern",
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)))
    ]);

    return Scaffold(
        appBar: AppBar(
            title: Text(
                'Einstellungen für ${subject.subjectName ?? subject.subject}')),
        body: Container(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: ListView(
            children: listitems,
          ),
        ));
  }
}
