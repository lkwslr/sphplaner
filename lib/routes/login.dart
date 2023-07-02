import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sphplaner/helper/backend.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

import '../helper/sph.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  Backend? backend;
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _wrongData = false;
  bool obscure = true;
  String _username = "";
  String _password = "";
  String info = "Anmelden";

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, _) {
      backend ??=
          PropertyChangeProvider.of<Backend, String>(context, listen: false)!
              .value;
      Size logicalScreenSize = View.of(context).physicalSize / View.of(context).devicePixelRatio;

      if (logicalScreenSize.height > logicalScreenSize.width) {
        return ListView(
          children: [
            const Image(image: AssetImage('assets/sph_wide.png')),
            const Divider(height: 32, color: Colors.transparent),
            Padding(padding: const EdgeInsets.all(16.0),
              child: getForm(double.infinity, 40.0, true))
          ],
        );
      } else {
        return Stack(
          fit: StackFit.expand,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Image.asset(
                'assets/sph_extra-wide.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.background.withOpacity(1),
                    Theme.of(context).colorScheme.background.withOpacity(.5),
                    Theme.of(context).colorScheme.background.withOpacity(.5),
                    Theme.of(context).colorScheme.background.withOpacity(.5)
                  ], begin: Alignment.topCenter, end: const Alignment(0, 1))),
            ),
            Center(
              child: getForm(logicalScreenSize.width / 2, min(max(40.0, logicalScreenSize.height/12), 64.0), false),
            )

          ],
        );
      }
    });
   }

   Form getForm(width, buttonHeight, bool landscape) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Bitte gib deine Zugangsdaten vom Schulportal Hessen an, um dich anzumelden.",
                  style: TextStyle(fontSize: 16),
                ),
                const Divider(height: 16, color: Colors.transparent),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    autofillHints: const [AutofillHints.username],
                    decoration: const InputDecoration(labelText: 'Benutzername'),
                    readOnly: _loading,
                    validator: (value) {
                      if (value!.isEmpty || _wrongData) {
                        return 'Bitte gib einen Benutzernamen an.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value!;
                    },
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Passwort',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                          child: Icon(Icons.remove_red_eye, color: obscure ? null : Theme.of(context).colorScheme.primary),
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
                    onSaved: (value) {
                      _password = value!;
                    },

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                      onPressed: _loading
                          ? null
                          : () async {
                        String schoolId = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              final TextEditingController schoolIdController =
                              TextEditingController();

                              return AlertDialog(
                                title: const Text("Gib die Nummer deiner Schule ein. Um diese herauszufinden, gehe auf die Schulauswahlseite vom SPH und wähle deine Schule aus."
                                    "Sobald du auf der Anmeldeseite für deine Schule bist, siehst du am Ende der URL eine vierstellige Nummer. Dies ist deine Schulnummer."),
                                content: Column(
                                  children: [
                                    const Text("z.B.: 1111"),
                                    TextField(
                                      controller: schoolIdController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Schulnummer',
                                      ),
                                    )
                                  ],
                                ),
                                scrollable: true,
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(schoolIdController.text);
                                      },
                                      child: const Text("Speichern"))
                                ],
                              );
                            }) ?? "";
                        _wrongData = false;
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                            obscure = true;
                          });
                          _formKey.currentState!.save();

                          if (_username == "TESTUSER" && _password == "TESTPASSWORT") {
                            await testLogin();
                          }

                          _wrongData = !await sphLogin(schoolId);

                          if (!_wrongData) {
                            backend!.initApp().then((_) {
                              backend!.isLoggedIn = true;
                            });
                          } else {
                            _formKey.currentState!.validate();
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
                      child: Text(info, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)),
                ),
              ],
            ),
          )),
    );
   }

  Future<bool> sphLogin(String schoolId) async {
    setState(() {
      info = "Überprüfe Zugangsdaten...";
    });

    String login = "";

    if (_username.split(".").length != 2) {
      login = "invalid username";
    } else {
      backend!.sph = SPH(_username, _password, schoolId);
      login = await backend!.initSPH();
    }

    if (login == "") {
      backend!.schoolId = schoolId;
      try {
        backend!.login = {'username': _username, 'password': _password};
        setState(() {
          info = "Lade Benutzerinformation...";
        });
        await backend!.initUser();
        await backend!.updateUser(force: true);

        setState(() {
          info = "Lade Vertretungsplan...";
        });
        await backend!.updateVertretungsplan(force: true);

        setState(() {
          info = "Lade Stundenplan...";
        });
        await backend!.updateStundenplan(force: true).then((_) {
          backend!.lastUpdate =
              DateFormat('dd.MM.y HH:mm').format(DateTime.now());
          backend!.status = "Letztes Update: ${backend!.lastUpdate}";
          backend!.updateLock = false;
        });
      } catch (_) {
        return false;
      }
      return true;
    }
    return false;
  }

  Future<bool> testLogin() async {
    backend!.login = {'username': _username, 'password': _password};
    await backend!.initUser();
    backend!.lastUpdate =
        DateFormat('dd.MM.y HH:mm').format(DateTime.now());
    backend!.status = "Letztes Update: ${backend!.lastUpdate}";
    backend!.updateLock = false;
    backend!.isLoggedIn = true;
    return true;
  }
}
