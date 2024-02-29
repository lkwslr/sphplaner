import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/helper/school.dart';
import 'package:sphplaner/main.dart';
import 'package:sphplaner/routes/welcome/login_settings.dart';

class Login extends StatefulWidget {
  const Login({super.key, this.skipUpdate});

  final bool? skipUpdate;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String schoolId = "";
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _wrongData = false;
  bool obscure = true;
  String username = "";
  String password = "";
  String info = "Anmelden";
  String errormessage = "";
  List<School>? schoolOptions;
  String hinweisText = "Bitte gib deine Zugangsdaten vom Schulportal Hessen an, um dich anzumelden.";

  @override
  Widget build(BuildContext context) {
    schoolOptions ??= SPH.schools;

    return Scaffold(
        appBar: AppBar(
          title: const Text("SPH Planer"),
        ),
        body: PropertyChangeConsumer<StorageNotifier, String>(
            properties: const ['main'],
            builder: (context, notify, _) {
              return OrientationBuilder(builder: (context, _) {
                Size logicalScreenSize = View.of(context).physicalSize /
                    View.of(context).devicePixelRatio;

                if (logicalScreenSize.height > logicalScreenSize.width) {
                  return ListView(children: [
                    Image.asset('assets/sph_wide.png', color: Theme.of(context).colorScheme.primary,),
                    const Divider(height: 32, color: Colors.transparent),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: getForm(double.infinity, 40.0, false, notify!))
                  ]);
                } else {
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                        child: Image.asset(
                          'assets/sph_extra-wide.png',
                          color: Theme.of(context).colorScheme.primary,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Theme.of(context)
                                  .colorScheme
                                  .background
                                  .withOpacity(1),
                              Theme.of(context)
                                  .colorScheme
                                  .background
                                  .withOpacity(.5),
                              Theme.of(context)
                                  .colorScheme
                                  .background
                                  .withOpacity(.5),
                              Theme.of(context)
                                  .colorScheme
                                  .background
                                  .withOpacity(.5)
                            ],
                                begin: Alignment.topCenter,
                                end: const Alignment(0, 1))),
                      ),
                      SingleChildScrollView(
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: SizedBox(
                                  width: logicalScreenSize.width / 2,
                                  child: getForm(
                                      logicalScreenSize.width / 2,
                                      min(
                                          max(40.0,
                                              logicalScreenSize.height / 12),
                                          64.0),
                                      true,
                                      notify!),
                                ),
                              )))
                    ],
                  );
                }
              });
            }));
  }

  Form getForm(width, buttonHeight, bool landscape, StorageNotifier notify) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.skipUpdate ?? false)
            const Text(
              "Durch ein Update o.ä. wurden deine Zugangsdaten aus dem App-Speicher entfernt, "
                  "weswegen du diese jetzt erneut angeben musst.",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.left,
            ),
            if (widget.skipUpdate ?? false)
              const Text(
                "Alle anderen Daten, wie Einstellungen und Hausaufgaben, bleiben erhalten!",
                style: TextStyle(fontSize: 20, color: Colors.red),
                textAlign: TextAlign.left,
              ),
            if (!(widget.skipUpdate ?? false))
              const Text(
                "Bitte gib deine Zugangsdaten vom Schulportal Hessen an, um dich anzumelden.",
                style: TextStyle(fontSize: 23),
                textAlign: TextAlign.center,
              ),
            const Divider(height: 16, color: Colors.transparent),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Autocomplete<School>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<School>.empty();
                  } else if (textEditingValue.text.length >= 3) {
                    return schoolOptions!.where((School school) {
                      String compareSchool = "$school".toLowerCase();
                      bool contains = true;
                      for (String word
                          in textEditingValue.text.toLowerCase().split(" ")) {
                        if (!compareSchool.contains(word)) {
                          contains = false;
                        }
                      }
                      return contains;
                    }).toList();
                  } else {
                    return schoolOptions!
                        .where((School school) => school.name
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase()))
                        .toList();
                  }
                },
                displayStringForOption: (School option) => "$option",
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextFormField(
                    controller: textEditingController,
                    readOnly: _loading,
                    scrollPadding: const EdgeInsets.all(500),
                    decoration: InputDecoration(
                        labelText: 'Schule',
                        hintText:
                            "Schreibe etwas, um deine Schule auszuwählen.",
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: schoolId != ""
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.primary,
                                width: 2))),
                    focusNode: focusNode,
                    onFieldSubmitted: (String value) {
                      onFieldSubmitted();
                    },
                    onChanged: (String value) {
                      if ((value.length == 4 || value.length == 5) &&
                          int.tryParse(value) != null) {
                        setState(() {
                          schoolId = value;
                        });
                      } else {
                        setState(() {
                          schoolId = "";
                        });
                      }
                    },
                  );
                },
                onSelected: (School school) {
                  setState(() {
                    schoolId = school.id;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                autofillHints: const [AutofillHints.username],
                decoration: const InputDecoration(labelText: 'Benutzername'),
                readOnly: _loading,
                validator: (value) {
                  if (value!.isEmpty || _wrongData) {
                    return 'Bitte gib einen gültigen Benutzernamen an.';
                  }
                  return null;
                },
                onChanged: (value) {
                  username = value;
                },
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Passwort',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscure = !obscure;
                        });
                      },
                      child: Icon(Icons.remove_red_eye,
                          color: obscure
                              ? null
                              : Theme.of(context).colorScheme.primary),
                    )),
                keyboardType: TextInputType.text,
                autofillHints: const [AutofillHints.password],
                obscureText: obscure,
                readOnly: _loading,
                validator: (value) {
                  if (value!.isEmpty || _wrongData) {
                    return 'Bitte gib ein gültiges Passwort an.';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            Text(errormessage),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                  onPressed: _loading
                      ? null
                      : () async {
                          _wrongData = false;
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _loading = true;
                              obscure = true;
                            });
                            _formKey.currentState!.save();

                            if (username == "TESTUSER") {
                              await testLogin();
                            } else {
                              if (int.tryParse(schoolId) == null) {
                                setState(() {
                                  info = "Anmelden";
                                  errormessage =
                                      "Bitte gib eine Schule an. Dies kannst du entweder durch Klicken auf die Schule in der Schulauswahl oder durch Eingeben der meist vierstelligen Schulnummer tun.";
                                  _loading = false;
                                });
                                return;
                              }

                              setState(() {
                                info = "Überprüfe Zugangsdaten...";
                              });

                              StorageProvider.resetSecureStorage();
                              StorageProvider.school = int.parse(schoolId);
                              StorageProvider.username = username;
                              StorageProvider.password = password;

                              try {
                                await SPH.getSID(true).then((value) async {
                                  if (widget.skipUpdate ?? false) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const SPHPlaner()));
                                  } else {
                                    try {
                                      StorageProvider.loggedIn = true;
                                      await SPH.update(notify).then((value) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const LoginSettings()));
                                      });
                                    } catch (_) {
                                      errormessage =
                                      "Es ist ein unerwarteter Fehler aufgetreten";
                                    }
                                  }
                                });
                              } catch (error) {
                                errormessage =
                                    error.toString().split("SIDERROR=")[1];
                              }

                              setState(() {
                                info = "Anmelden";
                                _loading = false;
                              });
                            }
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(buttonHeight),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    StorageProvider.settings.updateLock
                        ? StorageProvider.settings.updateLockText
                        : info,
                    style: TextStyle(
                        color: _loading
                            ? Theme.of(context).colorScheme.onPrimaryContainer
                            : Theme.of(context).colorScheme.onPrimary),
                  )),
            ),
          ],
        ),
      )),
    );
  }

  Future<bool> testLogin() async {
    StorageProvider.username = "TESTUSER";
    StorageProvider.loggedIn = true;

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SPHPlaner()));
    return true;
  }
}
