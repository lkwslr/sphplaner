import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/helper/school.dart';
import 'package:sphplaner/helper/storage/user.dart';
import 'package:sphplaner/main.dart';
import 'package:sphplaner/routes/welcome/login_settings.dart';

class Login extends StatefulWidget {
  const Login({super.key, this.secureStorageError});

  final bool? secureStorageError;

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
  bool secureStorageError = false;
  String hinweisText = "Bitte gib deine Zugangsdaten vom Schulportal Hessen an, um dich anzumelden.";

  @override
  Widget build(BuildContext context) {
    schoolOptions ??= SPH.schools;
    secureStorageError = widget.secureStorageError ?? false;

    if (secureStorageError) {
      schoolId = "${StorageProvider.user.school}";
      hinweisText = "Aufgrund eines unerwarteten Fehlers kann die App nicht mehr auf die gespeicherten Zugangsdaten zugreifen.\n"
          "Bitte gib diese erneut an, alle gespeicherten Daten bleiben erhalten.";
    }

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
                        child: getForm(double.infinity, 40.0, false, notify!, hinweisText, secureStorageError))
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
                                      notify!, hinweisText, secureStorageError),
                                ),
                              )))
                    ],
                  );
                }
              });
            }));
  }

  Form getForm(width, buttonHeight, bool landscape, StorageNotifier notify, String hinweisText, bool secureError) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hinweisText,
              style: TextStyle(fontSize: hinweisText.startsWith("Bitte") ? 23 : 20),
              textAlign: TextAlign.center,
            ),
            const Divider(height: 16, color: Colors.transparent),
            if (!secureError)
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
                onSaved: (value) {
                  username = value!;
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
                  password = value!;
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
                              if (int.tryParse(schoolId) == null && !secureError) {
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

                              SPH.setCredentials(
                                  username, password, int.parse(schoolId));

                              try {
                                await SPH.getSID(true).then((value) async {
                                  StorageProvider.resetSecureStorage();
                                  StorageProvider.saveCredentials(
                                      username, password);
                                  if (secureError) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const SPHPlaner()));
                                  } else {
                                    String userID = "";
                                    try {
                                      userID = await SPH.updateUser();
                                    } catch (_) {
                                      errormessage =
                                      "Es ist ein unerwarteter Fehler aufgetreten";
                                    }

                                    if (userID != "") {
                                      StorageProvider.loggedIn = userID;
                                      await SPH.update(notify).then((value) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const LoginSettings()));
                                      });
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
    // TODO: needs to be renewed

    StorageProvider.loggedIn = "TEST";

    final User user = User()
      ..username = "TEST"
      ..autoUpdate = true
      ..theme = "system"
      ..school = 0
      ..schoolName = "TEST"
      ..firstName = "TEST"
      ..lastName = "USER"
      ..displayName = "Test - User"
      ..email = "test@example.com"
      ..birthDate = "01.01.1970"
      ..profileImage = profileImage
      ..grade = "0"
      ..course = "a";

    await StorageProvider.isar.writeTxn(() async {
      await StorageProvider.isar.users.put(user);
    }).then((value) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const SPHPlaner())));
    return true;
  }

  String profileImage =
      "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";
}
