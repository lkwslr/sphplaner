import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

import '../helper/backend.dart';

class HomeWork extends StatefulWidget {
  const HomeWork({Key? key}) : super(key: key);

  @override
  State<HomeWork> createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PropertyChangeConsumer<Backend, String>(
          properties: const ["homework", "colors", "stundenplan"],
          builder: (context, backend, child) {
            List ha = backend!.homework;
            if (ha.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: ha.length,
                itemBuilder: (context, index) {
                  Map homework = json.decode(ha[index]);

                  String fachId = homework['fach'];
                  RegExp reg = RegExp(
                    r"[A-Z]+-[GLT]\d",
                    caseSensitive: false,
                    multiLine: false,
                  );
                  if (fachId.startsWith("W")) {
                    fachId = fachId.split("_")[2];
                  }
                  if (reg.hasMatch(fachId)) {
                    fachId = fachId.split("-")[0];
                  }

                  return Dismissible(
                      key: Key(
                          "${homework['titel']}${homework['fach']}${homework['beschreibung']}"),
                      onDismissed: (direction) {
                        setState(() {
                          ha.removeAt(index);
                        });
                        backend.removeHomework(index);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          clipBehavior: Clip.none,
                            behavior: SnackBarBehavior.floating,
                            action: SnackBarAction(
                                label: "Rückgängig",
                                onPressed: () {
                                  backend.saveHomework(homework);
                                }),
                            content: Text(
                                '${homework['titel'].toString()} wurde entfernt.')));
                      },
                      background: Container(color: Colors.red),
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                          homework['titel'],
                          style: TextStyle(
                              color: DateTime.now().isAfter(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          homework['due']))
                                  ? Colors.red
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color),
                        ),
                        leading: Container(
                          height: double.infinity,
                          width: 16,
                          color: Color(backend.colors[fachId]),
                          child: RotatedBox(
                              quarterTurns: -1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(fachId,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15)),
                              )),
                        ),
                        minLeadingWidth: 8,
                        trailing: Column(
                          children: [
                            Text("Erledigen bis",
                                style: TextStyle(
                                    color: DateTime.now().isAfter(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                homework['due']))
                                        ? Colors.red
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color)),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              DateFormat("dd.MM.").format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      homework["due"])),
                              style: TextStyle(
                                  color: DateTime.now().isAfter(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              homework['due']))
                                      ? Colors.red
                                      : Theme.of(context).colorScheme.secondary,
                                  fontSize: 24),
                            )
                          ],
                        ),
                        subtitle: Text(homework['beschreibung'],
                            style: TextStyle(
                                color: DateTime.now().isAfter(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            homework['due']))
                                    ? Colors.red
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color),
                            maxLines: 3,
                            overflow: TextOverflow.fade),
                        onTap: () {
                          if (homework['beschreibung'].toString().isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(16),
                                      title: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(homework['titel']),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(DateFormat("dd.MM.").format(
                                                DateTime.fromMillisecondsSinceEpoch(
                                                    homework["due"]))),
                                          )
                                        ],
                                      ),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8),
                                          child: Text(homework['beschreibung'])));
                                });
                          }
                        },
                      ));
                },
              );
            } else {
              return const Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Keine Hausaufgaben",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreateHA()));
        },
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary,),
      ),
    );
  }
}

class CreateHA extends StatefulWidget {
  const CreateHA({Key? key}) : super(key: key);

  @override
  State<CreateHA> createState() => _CreateHAState();
}

class _CreateHAState extends State<CreateHA> {
  String fach = "";
  DateTime date = DateTime.now();
  bool error = false;
  TextEditingController titel = TextEditingController();
  TextEditingController beschreibung = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<Backend, String>(
        properties: const [],
        builder: (context, backend, child) {
          if (backend!.faecher.isEmpty) {
            return Scaffold(
                appBar: AppBar(title: const Text('Hausaufgabe erstellen')),
                body: const Padding(
                  padding: EdgeInsets.all(64.0),
                  child: Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                          "Bitte gib zuerst deinen Stundenplan an.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ),
                ));
          } else if (fach == "") {
            fach = backend.faecher.first;
          }
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
          return Scaffold(
            appBar: AppBar(title: const Text('Hausaufgabe erstellen')),
            body: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ListTile(
                  title: const Align(
                    alignment: Alignment.center,
                    child: Text("Fach",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  subtitle: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(backend.colors[fachId] ?? Theme.of(context).colorScheme.error.value)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              contentPadding: const EdgeInsets.all(8),
                              scrollable: true,
                              title: const Text("Fach auswählen"),
                              content: Column(
                                  children: backend.faecher.map<Widget>((e) {
                                String eId = e;
                                if (eId.startsWith("W")) {
                                  eId = eId.split("_")[2];
                                }
                                if (reg.hasMatch(e)) {
                                  eId = e.split("-")[0];
                                }

                                return Container(
                                  padding: const EdgeInsets.all(4),
                                  width: double.infinity,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color(backend.colors[eId] ?? Theme.of(context).colorScheme.error.value)),
                                    onPressed: () {
                                      Navigator.of(context).pop(e);
                                    },
                                    child: Text(
                                      getFach(eId),
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }).toList()),
                            );
                          }).then((value) {
                        if (value != null) {
                          setState(() {
                            fach = value;
                          });
                        }
                      });
                    },
                    child: Text(getFach(fachId),
                        style: const TextStyle(color: Colors.black)),
                  ),
                ),
                const Divider(),
                ListTile(
                    title: const Align(
                      alignment: Alignment.center,
                      child: Text("Erledigen bis",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    subtitle: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return DatePickerDialog(
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)));
                              }).then((value) {
                            setState(() {
                              date = value;
                            });
                          });
                        },
                        child: Text(DateFormat("EEE, dd. MMMM").format(date)))),
                const Divider(),
                ListTile(
                    title: Align(
                      alignment: Alignment.center,
                      child: Text("Titel",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: error ? Colors.red : null)),
                    ),
                    subtitle: TextField(
                      controller: titel,
                      maxLength: 16,
                    )),
                const Divider(),
                ListTile(
                    title: const Align(
                      alignment: Alignment.center,
                      child: Text("Beschreibung",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    subtitle: TextField(
                      controller: beschreibung,
                      maxLines: 8,
                    )),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (titel.text.isNotEmpty) {
                  Map ha = {
                    "fach": fach,
                    "due": date.millisecondsSinceEpoch,
                    "titel": titel.text,
                    "beschreibung": beschreibung.text
                  };
                  backend.saveHomework(ha).then((value) {
                    Navigator.of(context).pop();
                  });
                } else {
                  setState(() {
                    error = true;
                  });
                }
              },
              child: Icon(Icons.save_outlined, color: Theme.of(context).colorScheme.onPrimary,),
            ),
          );
        });
  }
}
