import 'dart:math';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/helper/storage/subject.dart';
import 'package:sphplaner/main.dart';
/*import 'package:sphplaner/routes/settings_email.dart';
import 'package:sphplaner/routes/settings_password.dart';
import 'package:sphplaner/routes/settings_profilbild.dart';*/
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'fach_farbe.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  StorageNotifier? notify;
  String klasse = "Klasse";
  String information = "";
  ValueNotifier<bool> loading = ValueNotifier(false);
  String result = "";
  late Size logicalScreenSize;
  double buttonSizeFactorLarge = 0;
  double buttonSizeFactorSmall = 0;
  double buttonSizeFactorXSmall = 0;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, _) {
      return PropertyChangeConsumer<StorageNotifier, String>(
          properties: const ['settings', 'main'],
          builder: (context, notify, child) {
            this.notify ??= notify;

            logicalScreenSize = View.of(context).physicalSize /
                View.of(context).devicePixelRatio;
            if (logicalScreenSize.height < logicalScreenSize.width) {
              buttonSizeFactorLarge =
                  min(max(40.0, logicalScreenSize.height / 12), 64.0);
              buttonSizeFactorSmall =
                  min(max(40.0, logicalScreenSize.height / 12), 56.0);
              buttonSizeFactorXSmall =
                  min(max(40.0, logicalScreenSize.height / 12), 52.0);
            } else {
              buttonSizeFactorLarge = 40;
              buttonSizeFactorSmall = 40;
              buttonSizeFactorXSmall = 40;
            }
            return Scaffold(
                appBar: AppBar(title: const Text('Settings')),
                body: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _userSettings(),
                    //_plan(),
                    _theme(),
                    _autoUpdate(),
                    colors(context, buttonSizeFactorSmall),
                    _imexport(),
                    _logout()
                  ],
                ));
          });
    });
  }

  Widget _logout() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(buttonSizeFactorLarge),
        ),
        onPressed: () async {
          StorageProvider.deleteAll().then((value) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SPHPlaner()),
                ModalRoute.withName('/'));
          });
        },
        child: const Text("Abmelden"));
  }

  /*Widget _plan() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text("Ansicht Stundenplan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Row(
          children: [
            const Expanded(
              child: ListTile(
                title: Text("Vertretung nach 18 Uhr"),
                subtitle: Text(
                  "Nach 18 Uhr wird die Vertretung für den heutigen Tag ausgeblendet.",
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            Switch(
              value: backend.hideToday,
              onChanged: (changed) {
                backend.hideToday = changed;
              },
            )
          ],
        ),
        const Divider(height: 32, thickness: 3)
      ],
    );
  }*/

  Widget _theme() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text("Aussehen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        RadioListTile(
            title: const Text('Systemstandard'),
            value: "system",
            groupValue: StorageProvider.settings.themeByString,
            onChanged: (String? value) {
              StorageProvider.settings.themeByString = "system";
              notify!.notifyAll(["theme", "settings"]);
            }),
        RadioListTile(
            title: const Text('Hell'),
            value: "light",
            groupValue: StorageProvider.settings.themeByString,
            onChanged: (String? value) {
              StorageProvider.settings.themeByString = "light";
              notify!.notifyAll(["theme", "settings"]);
            }),
        RadioListTile(
            title: const Text('Dunkel'),
            value: "dark",
            groupValue: StorageProvider.settings.themeByString,
            onChanged: (String? value) {
              StorageProvider.settings.themeByString = "dark";
              notify!.notifyAll(["theme", "settings"]);
            }),
        const Divider(height: 32, thickness: 3)
      ],
    );
  }

  Widget _autoUpdate() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text("Automatische Verbindungen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Row(
          children: [
            const Expanded(child: Text("Aktualisierung beim Start")),
            Switch(
              value: StorageProvider.user!.autoUpdate!,
              onChanged: (changed) {
                StorageProvider.user!.autoUpdate = changed;
                StorageProvider.saveUser();
                notify!.notify("settings");
              },
            )
          ],
        ),
        const Divider(height: 32, thickness: 3)
      ],
    );
  }

  Widget _userSettings() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text("Profileinstellungen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        _anzeigeName(),
        Divider(
            height: buttonSizeFactorSmall > 40 ? 8 : 0,
            color: Colors.transparent),
        _email(),
        Divider(
            height: buttonSizeFactorSmall > 40 ? 8 : 0,
            color: Colors.transparent),
        _passwort(),
        Divider(
            height: buttonSizeFactorSmall > 40 ? 8 : 0,
            color: Colors.transparent),
        _profilbild(),
        Divider(
            height: buttonSizeFactorSmall > 40 ? 24 : 8,
            color: Colors.transparent),
        _forceUpdate(),
        const Divider(height: 32, thickness: 3)
      ],
    );
  }

  Widget _forceUpdate() {
    return PropertyChangeConsumer<StorageNotifier, String>(
        properties: const ['status'],
        builder: (context, notify, child) {
          String localStatus = StorageProvider.settings.updateLock
              ? StorageProvider.settings.updateLockText
              : StorageProvider.settings.status;
          if (localStatus.startsWith("Letztes Update:")) {
            localStatus = "Alle Daten aktualisieren";
          }
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(buttonSizeFactorSmall),
            ),
            onPressed: !localStatus.startsWith("Alle")
                ? null
                : () async {
                    await SPH.update(notify!);
                  },
            child: SizedBox(
              width: double.infinity,
              height: 32,
              child:
                  Align(alignment: Alignment.center, child: Text(localStatus)),
            ),
          );
        });
  }

  Widget _anzeigeName() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(buttonSizeFactorXSmall),
      ),
      onPressed: () async {
        anzeigeNameDialog(context);
      },
      child: const SizedBox(
        width: double.infinity,
        height: 32,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Anzeigenamen anpassen")),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }

  Widget _email() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(buttonSizeFactorXSmall),
      ),
      onPressed: () {
        Fluttertoast.showToast(
            msg: "Coming Soon...", toastLength: Toast.LENGTH_SHORT);
        /*Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Email()));*/
      },
      child: const SizedBox(
        width: double.infinity,
        height: 32,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text("E-Mail-Adresse ändern")),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }

  Widget _passwort() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(buttonSizeFactorXSmall),
      ),
      onPressed: () {
        Fluttertoast.showToast(
            msg: "Coming Soon...", toastLength: Toast.LENGTH_SHORT);
        /*Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Password()));*/
      },
      child: const SizedBox(
        width: double.infinity,
        height: 32,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Passwort ändern")),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }

  Widget _profilbild() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(buttonSizeFactorXSmall),
      ),
      onPressed: () {
        Fluttertoast.showToast(
            msg: "Coming Soon...", toastLength: Toast.LENGTH_SHORT);
        /*Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Profilbild()));*/
      },
      child: const SizedBox(
        width: double.infinity,
        height: 32,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text("Profilbild ändern")),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }

  Widget _imexport() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text("Daten",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "Coming Soon...", toastLength: Toast.LENGTH_SHORT);

                    /*showDialog(context: context, builder: (BuildContext context) {
            /*String base64Stundenplan = base64Encode(
                        utf8.encode(jsonEncode(backend.stundenplan))
                      );*/

            String base64Stundenplan = "";

            return AlertDialog(title: const Text("Daten exportieren"),
              content: Text(base64Stundenplan, maxLines: 10,
                overflow: TextOverflow.ellipsis,),
              actions: [TextButton(onPressed: () {
                Clipboard.setData(ClipboardData(text: base64Stundenplan));
                Navigator.of(context).pop();
              }, child: const Text("Alles kopieren"))
              ],);
          });*/
                  },
                  child: const Text("Export")),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "Coming Soon...", toastLength: Toast.LENGTH_SHORT);

                    /*TextEditingController input = TextEditingController();
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(scrollable: true,
              title: const Text("Daten importieren"),
              content: TextField(controller: input, maxLines: 5,),
              actions: [
                TextButton(onPressed: () {
                  Clipboard.getData(Clipboard.kTextPlain).then((value) {
                    input.text = value!.text ?? "";
                  });
                }, child: const Text("Einfügen aus Zwischenablage")),
                TextButton(onPressed: () {
                  try {
                    //Map stundenplan = jsonDecode(utf8.decode(base64.decode(input.text)));
                    //backend.stundenplan = stundenplan;
                    Navigator.of(context).pop();
                  } catch (error) {
                    showDialog(
                        context: context, builder: (BuildContext context) {
                      return AlertDialog(scrollable: true,
                        title: const Text("Es ist ein Fehler aufgetreten"),
                        content: Text(error.toString()),
                        actions: [TextButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, child: const Text("OK"))
                        ],);
                    });
                  }
                }, child: const Text("Speichern"))
              ],);
          });*/
                  },
                  child: const Text("Import")),
            )
          ],
        ),
        const Divider(height: 32, thickness: 3)
      ],
    );
  }
}

Future anzeigeNameDialog(BuildContext context) {
  StorageNotifier notify = PropertyChangeProvider.of<StorageNotifier, String>(
          context,
          listen: false)!
      .value;

  TextEditingController controller =
      TextEditingController(text: "${StorageProvider.user!.displayName}");
  //TODO: In zukünftiger Version: Benutzername nach Leerzeichen gesplittet und auswählbar machen, daran Custom Text anpassen
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text("Anzeigenamen anpassen"),
          content: Column(children: [
            TextField(controller: controller, keyboardType: TextInputType.name),
            const Divider(
              color: Colors.transparent,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: () async {
                StorageProvider.user!.displayName = controller.text;
                await StorageProvider.saveUser().then((value) {
                  notify.notify("main");
                  Navigator.of(context).pop();
                });
              },
              child: const Text("Speichern"),
            )
          ]),
        );
      });
}

Widget colors(BuildContext context, double buttonSizeFactorSmall) {
  List<Widget> faecher = [
    const Align(
      alignment: Alignment.center,
      child: Text("Farbwahl für deine Fächer",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
    )
  ];
  for (Subject subject in StorageProvider.isar.subjects.where().findAllSync()) {
    if (buttonSizeFactorSmall > 40) {
      faecher.add(const SizedBox(height: 8));
    }

    faecher.add(ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FachFarbe(subject: subject)));
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(subject.color),
            minimumSize: Size.fromHeight(buttonSizeFactorSmall)),
        child: SizedBox(
          width: double.infinity,
          height: 32,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${subject.subjectName} (${subject.subject})",
                      style: const TextStyle(color: Colors.black))),
              const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.arrow_forward, color: Colors.black)),
            ],
          ),
        )));
  }
  if (faecher.length == 1) {
    faecher.add(const Align(
      alignment: Alignment.center,
      child: Text(
          "Um die Farben für deine Fächer anpassen zu können, musst du diese zuerst in deinen Stundenplan eintragen.",
          style: TextStyle(fontSize: 16)),
    ));
  }
  faecher.add(const Divider(height: 32, thickness: 3));
  return Column(
    children: faecher,
  );
}
