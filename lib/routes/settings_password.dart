import 'package:flutter/material.dart';
import 'package:sphplaner/helper/networking/sph_settings.dart';

import '../helper/storage/storage_provider.dart';

class Password extends StatefulWidget {
  const Password({Key? key}) : super(key: key);

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool _loading = false;
  bool? change;
  List obscure = [true, true, true];
  String changedText = "";
  RegExp upperCase = RegExp(r'[A-Z]');
  RegExp lowerCase = RegExp(r'[a-z]');
  RegExp digits = RegExp(r'\d');
  RegExp specialCase = RegExp(r'[!@#$%^&*()§\\\-_=|+?°{};:,<.>\[\]]');
  String password = "";
  String passwordRepeat = "";
  String currentPW = "";
  bool current = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Passwort ändern')),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  _info(),
                  const Divider(height: 32, thickness: 3),
                  _change()
                ],
              ),
            )
          ],
        ));
  }

  Widget _info() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text("Hinweis",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: <TextSpan>[
                  const TextSpan(
                    text: "Das Passwort muss aus ",
                  ),
                  TextSpan(
                    text: 'mindestens 10 Zeichen',
                    style: TextStyle(
                      color: password.length >= 10 ? Colors.green : Colors.red,
                    ),
                  ),
                  const TextSpan(
                    text: ',',
                  ),
                  TextSpan(
                    text: ' groß',
                    style: TextStyle(
                      color: upperCase.hasMatch(password)
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  const TextSpan(
                    text: ' und',
                  ),
                  TextSpan(
                    text: ' klein',
                    style: TextStyle(
                      color: lowerCase.hasMatch(password)
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  const TextSpan(text: " geschriebenen Buchstaben sowie"),
                  TextSpan(
                    text: ' mindestens einer Zahl',
                    style: TextStyle(
                      color:
                          digits.hasMatch(password) ? Colors.green : Colors.red,
                    ),
                  ),
                  const TextSpan(text: " und"),
                  TextSpan(
                    text: ' einem Sonderzeichen',
                    style: TextStyle(
                      color: specialCase.hasMatch(password)
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  const TextSpan(text: " bestehen!"),
                ],
              ),
            )),
        if (change != null)
          Text("\n$changedText",
              style: TextStyle(color: change! ? Colors.green : Colors.red)),
      ],
    );
  }

  Widget _change() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(10, 32, 10, 10),
          child: TextField(
            obscureText: obscure[0],
            autocorrect: false,
            onChanged: (value) async {
              if (currentPW == "") {
                currentPW =
                    await StorageProvider.getPassword(StorageProvider.loggedIn);
              }
              setState(() {
                current = value == currentPW;
              });
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: current ? Colors.green : Colors.red, width: 2)),
                labelText: 'Aktuelles Passwort',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscure[0] = !obscure[0];
                    });
                  },
                  child: Icon(Icons.remove_red_eye,
                      color: obscure[0]
                          ? null
                          : Theme.of(context).colorScheme.primary),
                )),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 32, 10, 10),
          child: TextField(
            obscureText: obscure[1],
            autocorrect: false,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Neues Passwort',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscure[1] = !obscure[1];
                    });
                  },
                  child: Icon(Icons.remove_red_eye,
                      color: obscure[1]
                          ? null
                          : Theme.of(context).colorScheme.primary),
                )),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(10, 16, 10, 32),
          child: TextField(
            obscureText: obscure[2],
            autocorrect: false,
            onChanged: (value) {
              setState(() {
                passwordRepeat = value;
              });
            },
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: password == passwordRepeat && password.isNotEmpty
                            ? Colors.green
                            : Colors.red,
                        width: 2)),
                labelText: 'Wiederholung des neuen Passwortes',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscure[2] = !obscure[2];
                    });
                  },
                  child: Icon(Icons.remove_red_eye,
                      color: obscure[2]
                          ? null
                          : Theme.of(context).colorScheme.primary),
                )),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () async {
            if (!_loading && current) {
              setState(() {
                _loading = true;
              });
              if (upperCase.hasMatch(password) &&
                  lowerCase.hasMatch(password) &&
                  digits.hasMatch(password) &&
                  specialCase.hasMatch(password)) {
                if (password == currentPW) {
                  setState(() {
                    change = false;
                    changedText =
                        "Das neue Passwort darf nicht bereits verwendet werden.";
                  });
                } else if (passwordRepeat == password) {
                  try {
                    bool result =
                        await SPHSettings.changePassword(currentPW, password);
                    if (result) {
                      changedText = "Das Passwort wurde geändert.";
                    } else {
                      changedText =
                          "Die Passwort konnte nicht geändert werden.";
                    }
                    setState(() {
                      change = result;
                    });
                  } catch (_) {
                    setState(() {
                      change = false;
                      changedText = "Das Passwort konnte nicht geändert werden";
                    });
                  }
                } else {
                  setState(() {
                    change = false;
                    changedText = "Die Passwörter stimmen nicht überein";
                  });
                }
              } else {
                setState(() {
                  change = false;
                  changedText = "Das Passwort erfüllt nicht alle Kriterien.";
                });
              }
              setState(() {
                _loading = false;
              });
            }
          },
          child: SizedBox(
              width: double.infinity,
              height: 32,
              child: Align(
                  alignment: Alignment.center,
                  child: _loading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text('Speichern'))),
        )
      ],
    );
  }
}
