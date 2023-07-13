import 'package:flutter/material.dart';

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  bool _loading = false;

  //bool _loadingPending = false;
  bool loadedPending = false;
  bool result = false;
  String pendingText = "";
  bool? change;
  String changedText = "";
  RegExp mailRegex = RegExp(r"[a-zA-Z\d_.+-]+@[a-zA-Z\d-]+\.[a-zA-Z\d-.]+");
  String email = "";
  String current = "";
  String currentPW = "";
  String warning = "";
  bool currentPWCorrect = false;
  bool obscure = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (current == "") {
      //current = backend.email;
    }

    return Scaffold(
        appBar: AppBar(title: const Text('E-Mail-Adresse ändern')),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  _info(),
                  const Divider(height: 32, thickness: 3),
                  //TODO: if (backend.emailChange) _changePending(),
                  //if (backend.emailChange)
                  const Divider(height: 32, thickness: 3),
                  if (current.contains("@")) _delete(),
                  if (current.contains("@"))
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
        Text(
            'Die hier hinterlegte E-Mail-Adresse wird für die "Passwort vergessen"-Funktion genutzt.\n'
            'Die Schule hat keinen Zugriff auf diese E-Mail-Adresse.\n'
            'Aktuelle E-Mail-Adresse: $current$warning'),
      ],
    );
  }

  Widget _delete() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text("E-Mail-Adresse löschen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () async {
            showDialog(
                context: context,
                builder: (builder) {
                  return AlertDialog(
                    title: const Text("E-Mail-Adresse löschen?"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop("0");
                          },
                          child: const Text("Nein")),
                      TextButton(
                          onPressed: () async {
                            /*await backend.deleteEMail().then((value) {
                              if (value) {
                                Navigator.of(context).pop("1");
                              } else {
                                Navigator.of(context).pop("0");
                              }
                            });*/
                          },
                          child: const Text("Ja")),
                    ],
                  );
                }).then((value) {
              if (value == "1") {
                warning = "";
                setState(() {
                  current = "Keine E-Mail-Adresse angegeben";
                });
              } else {
                setState(() {
                  warning = "\n\nE-Mail-Adresse konnte nicht gelöscht werden.";
                });
              }
            });
          },
          child: const SizedBox(
              width: double.infinity,
              height: 32,
              child:
                  Align(alignment: Alignment.center, child: Text("Löschen"))),
        )
      ],
    );
  }

  Widget _change() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text("E-Mail-Adresse ändern",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                autofillHints: const [AutofillHints.email],
                decoration:
                    const InputDecoration(labelText: 'neue E-Mail-Adresse'),
                readOnly: _loading,
                validator: (value) {
                  if (!mailRegex.hasMatch(value!)) {
                    return 'Bitte gebe eine gültige E-Mail-Adresse an.';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                autofillHints: const [AutofillHints.password],
                decoration: InputDecoration(
                    labelText: 'Aktuelles Passwort',
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
                readOnly: _loading,
                obscureText: obscure,
                validator: (value) {
                  if (value != currentPW) {
                    return 'Das Passwort stimmt nicht mit deinem aktuellen überein.';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(40),
                  ),
                  onPressed: _loading
                      ? null
                      : () async {
                          if (currentPW == "") {
                            //currentPW = await backend.password;
                          }
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            _formKey.currentState!.save();

                            /*try {
                              bool result = await backend.changeEMail(email);
                              if (result) {
                                current = backend.email;
                                changedText =
                                "Es wurde ein Bestätigungslink an ${backend.email} gesendet.\n"
                                    "Bitte rufe Deine E-Mails ab und schaue auch ggf. im Spam-Ordner nach. "
                                    "In der zugesandten E-Mail findest Du einen Link, den Du zur Bestätigung der E-Mail-Adresse aufrufen musst. "
                                    "Dieser ist nur für die nächsten zwei Stunden gültig.\n"
                                    "Nach Bestätigung wird die neue E-Mail-Adresse übernommen.";
                                change = result;
                              } else {
                                changedText =
                                "Die E-Mail-Adresse konnte nicht geändert werden.\n"
                                    "Bitte überprüfe die eingegebene Adresse.";
                              }
                            } catch (_) {

                              changedText = "\n\nE-Mail-Adresse konnte nicht geändert werden.";
                            }*/
                          }
                          warning = "";
                          setState(() {
                            _loading = false;
                          });
                        },
                  child: const Text("Speichern")),
            ),
            if (change != null)
              Text(changedText,
                  style: TextStyle(color: change! ? Colors.green : Colors.red)),
          ],
        ));
  }

/*Widget _changePending() {
    if (pendingText == "") {
      _loadPending();
    }

    return Column(
      children: [
        const Align(
          alignment: Alignment.center,
          child: Text("E-Mail-Verifikation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        !loadedPending
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : Column(
                children: [
                  Text(
                    pendingText,
                    style: TextStyle(color: result ? Colors.green : Colors.red),
                  ),
                  if (!result)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                      ),
                      onPressed: () async {
                        if (!_loadingPending) {
                          setState(() {
                            _loadingPending = true;
                          });

                          //TODO: await backend.requestEMailLink();

                          setState(() {
                            pendingText = "";
                            _loadingPending = false;
                          });
                        }
                      },
                      child: SizedBox(
                          width: double.infinity,
                          height: 32,
                          child: Align(
                              alignment: Alignment.center,
                              child: _loadingPending
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Text('Verifikationslink senden'))),
                    )
                ],
              )
      ],
    );
  }*/

/*Future<void> _loadPending() async {
    //pendingText = await backend.checkEMail();
    if (pendingText == "") {
      pendingText = "E-Mail-Adresse wurde erfolgreich verifiziert";
      result = true;
    } else if (pendingText.contains("bestätigen")) {
      result = false;
      String minuten = pendingText.split(" ")[4];
      pendingText =
          "Die E-Mail-Adresse wurde noch nicht verifziert. Bitte innerhalb der nächsten $minuten Minuten bestätigen.";
    } else if (pendingText.contains("abgelaufen")) {
      result = false;
      pendingText =
          "Die E-Mail-Adresse wurde noch nicht verifziert, der Verifikationslink ist jedoch abgelaufen. Bitte erneut anfordern.";
    }
    setState(() {
      loadedPending = true;
    });
  }*/
}
