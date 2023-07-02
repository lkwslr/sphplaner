import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

import '../helper/backend.dart';
import '../helper/school.dart';
import '../helper/sph.dart';
import '../main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Backend? backend;
  String schooldId = "";
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _wrongData = false;
  bool obscure = true;
  String _username = "";
  String _password = "";
  String info = "Anmelden";
  List<School>? schoolOptions;

  @override
  Widget build(BuildContext context) {
    backend ??=
        PropertyChangeProvider.of<Backend, String>(context, listen: false)!
            .value;
    schoolOptions ??= backend!.schools;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Anmelden beim SPH"),
      ),
      body: OrientationBuilder(builder: (context, _) {
        Size logicalScreenSize =
            View.of(context).physicalSize / View.of(context).devicePixelRatio;

        if (logicalScreenSize.height > logicalScreenSize.width) {
          return ListView(children: [
            const Image(image: AssetImage('assets/sph_wide.png')),
            const Divider(height: 32, color: Colors.transparent),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: getForm(double.infinity, 40.0, false))
          ]);
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
              SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: SizedBox(
                          width: logicalScreenSize.width / 2,
                          child: getForm(
                              logicalScreenSize.width / 2,
                              min(max(40.0, logicalScreenSize.height / 12),
                                  64.0),
                              true),
                        ),
                      )))
            ],
          );
        }
      }),
    );
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
                        hintText: "Tippe, um deine Schule auszuwählen.",
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: schooldId != ""
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
                          schooldId = value;
                        });
                      } else {
                        setState(() {
                          schooldId = "";
                        });
                      }
                    },
                  );
                },
                onSelected: (School school) {
                  setState(() {
                    schooldId = school.id;
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
                          _wrongData = false;
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _loading = true;
                              obscure = true;
                            });
                            _formKey.currentState!.save();

                            if (_username == "TESTUSER" &&
                                _password == "TESTPASSWORT") {
                              await testLogin();
                            }
                            _wrongData = !await sphLogin(schooldId);
                            if (!_wrongData) {
                              backend!.initApp().then((_) {
                                backend!.isLoggedIn = true;
                                Navigator.of(context)
                                    .pushReplacement(_createRoute());
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
                  child: Text(
                    info,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  )),
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
    backend!.lastUpdate = DateFormat('dd.MM.y HH:mm').format(DateTime.now());
    backend!.status = "Lettres Update: ${backend!.lastUpdate}";
    backend!.updateLock = false;
    backend!.isLoggedIn = true;
    return true;
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SPHPlaner(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
