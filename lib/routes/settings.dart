import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sphplaner/helper/backend.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:sphplaner/main.dart';
import 'package:sphplaner/routes/fach_farbe.dart';
import 'package:sphplaner/routes/settings_email.dart';
import 'package:sphplaner/routes/settings_password.dart';
import 'package:sphplaner/routes/settings_profilbild.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  String klasse = "Klasse";
  String information = "";
  ValueNotifier<bool> loading = ValueNotifier(false);
  String result = "";
  late Backend backend;
  late Size logicalScreenSize;
  double buttonSizeFactorLarge = 0;
  double buttonSizeFactorSmall = 0;
  double buttonSizeFactorXSmall = 0;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, _) {
      return PropertyChangeConsumer<Backend, String>(
          builder: (context, backend, child) {
        logicalScreenSize = View.of(context).physicalSize / View.of(context).devicePixelRatio;
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
        this.backend = backend!;
        return Scaffold(
            appBar: AppBar(title: const Text('Settings')),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (!backend.sphLogin) _offlineMode(),
                _userSettings(),
                _plan(),
                _theme(),
                _autoUpdate(),
                if (backend.faecher.isNotEmpty) _colors(),
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
        backend.deleteUser();

        if (mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SPHPlaner()),
              ModalRoute.withName('/'));
        }
      },
      child: const Text("Abmelden"),
    );
  }

  Widget _plan() {
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
  }

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
            groupValue: backend.themeModeByString,
            onChanged: (String? value) {
              backend.themeModeByString = "system";
            }),
        RadioListTile(
            title: const Text('Hell'),
            value: "light",
            groupValue: backend.themeModeByString,
            onChanged: (String? value) {
              backend.themeModeByString = "light";
            }),
        RadioListTile(
            title: const Text('Dunkel'),
            value: "dark",
            groupValue: backend.themeModeByString,
            onChanged: (String? value) {
              backend.themeModeByString = "dark";
            }),
        const Divider(height: 32, thickness: 3)
      ],
    );
  }

  Widget _colors() {
    List<Widget> faecher = [
      const Align(
        alignment: Alignment.center,
        child: Text("Farbwahl für deine Fächer",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      )
    ];
    for (String fach
        in PropertyChangeProvider.of<Backend, String>(context, listen: false)!
            .value
            .faecher) {
      String fachId = fach;
      RegExp reg = RegExp(
        r"[A-Z]+-[GLT]\d",
        caseSensitive: false,
        multiLine: false,
      );
      if (fachId.startsWith("W")) {
        fachId = fachId.split("_")[2];
      }
      if (reg.hasMatch(fach)) {
        fachId = fach.split("-")[0];
      }

      if (buttonSizeFactorSmall > 40) {
        faecher.add(const SizedBox(height: 8));
      }

      faecher.add(ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FachFarbe(fach: fachId)));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(PropertyChangeProvider.of<Backend, String>(
                          context,
                          listen: true)!
                      .value
                      .colors[fachId] ??
                  Colors.white.value),
              minimumSize: Size.fromHeight(buttonSizeFactorSmall)),
          child: SizedBox(
            width: double.infinity,
            height: 32,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${getFach(fachId)} ($fach)",
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
              value: backend.autoUpdate,
              onChanged: (changed) {
                backend.autoUpdate = changed;
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
        Divider(height: buttonSizeFactorSmall > 40 ? 24 : 8, color: Colors.transparent),
        _forceUpdate(),
        const Divider(height: 32, thickness: 3)
      ],
    );
  }

  Widget _forceUpdate() {
    return PropertyChangeConsumer<Backend, String>(
        properties: const ['status'],
        builder: (context, backend, child) {
          String localStatus = backend!.status;
          if (localStatus.startsWith("Letztes Update:")) {
            localStatus = "Alle Daten aktualisieren";
          }
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(buttonSizeFactorSmall),
            ),
            onPressed: !localStatus.startsWith("Alle") || !backend.sphLogin
                ? null
                : () async {
                    backend.updateData(force: true);
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
        anzeigeNameDialog(backend, context);
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
      onPressed: backend.sphLogin
          ? () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Email()));
            }
          : null,
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
      onPressed: backend.sphLogin
          ? () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Password()));
            }
          : null,
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
      onPressed: backend.sphLogin
          ? () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Profilbild()));
            }
          : null,
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

  Widget _offlineMode() {
    return ValueListenableBuilder<bool>(
        valueListenable: loading,
        builder: (BuildContext context, bool value, Widget? child) {
          return Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text("Offline-Modus",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              const Text("Aktuell befindet sich die App im Offline-Modus, "
                  "weswegen einige Funktionen nicht zur Verfügung stehen."),
              Text(result),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(buttonSizeFactorXSmall),
                  ),
                  onPressed: () async {
                    loading.value = true;
                    result = await backend.initSPH();
                    loading.value = false;
                  },
                  child: loading.value
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text("In den Online-Modus wechseln")),
              const Divider(height: 32, thickness: 3)
            ],
          );
        });
  }

  Widget _imexport() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text("Stundenplan",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      String base64Stundenplan = base64Encode(
                        utf8.encode(jsonEncode(backend.stundenplan))
                      );

                      return AlertDialog(
                        title: const Text("Stundenplan exportieren"),
                        content: Text(base64Stundenplan, maxLines: 10, overflow: TextOverflow.ellipsis,),
                        actions: [
                          TextButton(onPressed: () {
                            Clipboard.setData(ClipboardData(text: base64Stundenplan));
                            Navigator.of(context).pop();
                          }, child: const Text("Alles kopieren"))
                        ],
                      );
                    });
              }, child: const Text("Export")),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(onPressed: () {
                TextEditingController input = TextEditingController();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {

                      return AlertDialog(
                        scrollable: true,
                        title: const Text("Stundenplan importieren"),
                        content: TextField(
                          controller: input,
                          maxLines: 5,
                        ),
                        actions: [
                          TextButton(onPressed: () {
                            Clipboard.getData(Clipboard.kTextPlain).then((value){
                              input.text = value!.text ?? "";
                            });
                          }, child: const Text("Einfügen aus Zwischenablage")),
                          TextButton(onPressed: () {
                            try {
                              Map stundenplan = jsonDecode(utf8.decode(base64.decode(input.text)));
                              backend.stundenplan = stundenplan;
                              Navigator.of(context).pop();
                            } catch (error) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      title: const Text("Es ist ein Fehler aufgetreten"),
                                      content: Text(error.toString()),
                                      actions: [
                                        TextButton(onPressed: (){
                                          Navigator.of(context).pop();
                                        }, child: const Text("OK"))
                                      ],
                                    );
                                  });
                            }

                          }, child: const Text("Speichern"))
                        ],
                      );
                    });
              }, child: const Text("Import")),
            )
          ],
        ),
        const Divider(height: 32, thickness: 3)
      ],
    );
  }
}

Future anzeigeNameDialog(Backend backend, BuildContext context) {
  List<Widget> children = [];
  Map userNames = backend.userNames;
  for (String word in backend.name.split(" ")) {
    if (userNames[word] == null) {
      userNames[word] = true;
    }
    ValueNotifier<bool> userNamesNotifier = ValueNotifier(userNames[word]);

    children.add(ValueListenableBuilder<bool>(
        valueListenable: userNamesNotifier,
        builder: (BuildContext context, bool value, Widget? child) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: userNamesNotifier.value,
            onChanged: (bool? value) {
              userNamesNotifier.value = !userNamesNotifier.value;
              userNames[word] = userNamesNotifier.value;
            },
            title: Text(word),
          );
        }));
  }

  children.add(ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(40),
    ),
    onPressed: () async {
      backend.userNames = userNames;
      Navigator.of(context).pop();
    },
    child: const Text("Speichern"),
  ));

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text("Anzeigenamen anpassen"),
          content: Column(children: children),
        );
      });
}
