import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/storage/homework.dart';
import 'package:sphplaner/helper/storage/lerngruppe.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';

class HomeWork extends StatefulWidget {
  const HomeWork({super.key});

  @override
  State<HomeWork> createState() => _HomeWorkState();
}

class _HomeWorkState extends State<HomeWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PropertyChangeConsumer<StorageNotifier, String>(
          properties: const ["homework"],
          builder: (context, notify, child) {
            List<Homework> homeworks = StorageProvider.isar.homeworks
                .filter()
                .finishedEqualTo(false)
                .sortByDue()
                .findAllSync();
            if (homeworks.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: homeworks.length,
                itemBuilder: (context, index) {
                  Homework homework = homeworks[index];

                  return Dismissible(
                      key: Key("${homework.id}"),
                      onDismissed: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          homework.finished = true;
                          await StorageProvider.isar.writeTxn(() async {
                            await StorageProvider.isar.homeworks.put(homework);
                          }).then((value) {
                            notify?.notify("homework");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                clipBehavior: Clip.none,
                                behavior: SnackBarBehavior.floating,
                                action: SnackBarAction(
                                    label: "Rückgängig",
                                    onPressed: () async {
                                      homework.finished = false;
                                      await StorageProvider.isar
                                          .writeTxn(() async {
                                        await StorageProvider.isar.homeworks
                                            .put(homework);
                                      });
                                      notify?.notify("homework");
                                    }),
                                content: Text(
                                    '${homework.title} wurde als erledigt markiert.')));
                          });
                        } else {
                          await StorageProvider.isar.writeTxn(() async {
                            await StorageProvider.isar.homeworks
                                .delete(homework.id);
                          }).then((value) {
                            notify?.notify("homework");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                clipBehavior: Clip.none,
                                behavior: SnackBarBehavior.floating,
                                action: SnackBarAction(
                                    label: "Rückgängig",
                                    onPressed: () async {
                                      Homework restored = Homework()
                                        ..lerngruppe.value = homework.lerngruppe.value
                                        ..finished = homework.finished
                                        ..description = homework.description
                                        ..title = homework.title
                                        ..onlineIdentifier =
                                            homework.onlineIdentifier
                                        ..online = homework.online
                                        ..due = homework.due;
                                      await StorageProvider.isar
                                          .writeTxn(() async {
                                        await StorageProvider.isar.homeworks
                                            .put(restored);
                                        await restored.lerngruppe.save();
                                      }).then((value) =>
                                              notify?.notify("homework"));
                                    }),
                                content:
                                    Text('${homework.title} wurde entfernt.')));
                          });
                        }
                      },
                      background: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green,
                        ),
                      ),
                      secondaryBackground: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red,
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .secondaryContainer
                              .withOpacity(.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  homework.lerngruppe.value?.generatedName ?? homework.fach ?? "???",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23),
                                )),
                                Expanded(
                                  child: Text(
                                    DateFormat("dd.MM.yy").format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            homework.due ?? 0)),
                                    overflow: TextOverflow.fade,
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                        color: DateTime.now().isAfter(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    homework.due ?? 0))
                                            ? Colors.red
                                            : null),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: Text(
                                  homework.title ?? " ",
                                  style: const TextStyle(fontSize: 23),
                                  textAlign: TextAlign.left,
                                )),
                            SizedBox(
                                width: double.infinity,
                                child: Text(
                                  homework.description ?? " ",
                                  textAlign: TextAlign.left,
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () async {
                                    homework.finished = true;
                                    await StorageProvider.isar
                                        .writeTxn(() async {
                                      await StorageProvider.isar.homeworks
                                          .put(homework);
                                    }).then((value) {
                                      notify?.notify("homework");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              clipBehavior: Clip.none,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              action: SnackBarAction(
                                                  label: "Rückgängig",
                                                  onPressed: () async {
                                                    homework.finished = false;
                                                    await StorageProvider.isar
                                                        .writeTxn(() async {
                                                      await StorageProvider
                                                          .isar.homeworks
                                                          .put(homework);
                                                    });
                                                    notify?.notify("homework");
                                                  }),
                                              content: Text(
                                                  '${homework.title} wurde als erledigt markiert.')));
                                    });
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(right: 10, left: 10),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                  ),
                                )),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CreateHA(
                                                  homework: homework,
                                                )));
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(right: 10, left: 10),
                                    child: Icon(Icons.edit),
                                  ),
                                )),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () async {
                                    await StorageProvider.isar
                                        .writeTxn(() async {
                                      await StorageProvider.isar.homeworks
                                          .delete(homework.id);
                                    }).then((value) {
                                      notify?.notify("homework");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              clipBehavior: Clip.none,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              action: SnackBarAction(
                                                  label: "Rückgängig",
                                                  onPressed: () async {
                                                    Homework restored =
                                                        Homework()
                                                          ..lerngruppe.value =
                                                              homework
                                                                  .lerngruppe.value
                                                          ..finished =
                                                              homework.finished
                                                          ..description =
                                                              homework
                                                                  .description
                                                          ..title =
                                                              homework.title
                                                          ..onlineIdentifier =
                                                              homework
                                                                  .onlineIdentifier
                                                          ..online =
                                                              homework.online
                                                          ..due = homework.due;
                                                    await StorageProvider.isar
                                                        .writeTxn(() async {
                                                      await StorageProvider
                                                          .isar.homeworks
                                                          .put(restored);
                                                      await restored.lerngruppe
                                                          .save();
                                                    }).then((value) =>
                                                            notify?.notify(
                                                                "homework"));
                                                  }),
                                              content: Text(
                                                  '${homework.title} wurde entfernt.')));
                                    });
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(right: 10, left: 10),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateHA(
                        homework: Homework(),
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateHA extends StatefulWidget {
  const CreateHA({super.key, required this.homework});

  final Homework homework;

  @override
  State<CreateHA> createState() => _CreateHAState();
}

class _CreateHAState extends State<CreateHA> {
  Lerngruppe? subject;
  DateTime? date;
  bool error = false;
  TextEditingController? titel;
  TextEditingController? beschreibung;
  Homework? homework;

  @override
  Widget build(BuildContext context) {
    homework ??= widget.homework;
    date ??= DateTime.fromMillisecondsSinceEpoch(
        homework?.due ?? DateTime.now().millisecondsSinceEpoch);
    titel ??= TextEditingController(text: homework?.title);
    beschreibung ??= TextEditingController(text: homework?.description);

    return PropertyChangeConsumer<StorageNotifier, String>(
        properties: const ["homework"],
        builder: (context, notify, child) {
          List<Lerngruppe> subjects =
              StorageProvider.isar.lerngruppes.where().findAllSync();

          if (subjects.isEmpty) {
            return Scaffold(
                appBar: AppBar(title: const Text('Hausaufgabe erstellen')),
                body: const Padding(
                  padding: EdgeInsets.all(64.0),
                  child: Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Bitte gib zuerst deinen Stundenplan an.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                  ),
                ));
          }
          subject ??= homework?.lerngruppe.value ?? subjects.first;
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
                        backgroundColor: Color(subject!.farbe)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                contentPadding: const EdgeInsets.all(8),
                                scrollable: true,
                                title: const Text("Fach auswählen"),
                                content: Column(
                                  children: subjects.map<Widget>((e) {
                                    return Container(
                                      padding: const EdgeInsets.all(4),
                                      width: double.infinity,
                                      height: 40,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(e.farbe)),
                                        onPressed: () {
                                          Navigator.of(context).pop(e);
                                        },
                                        child: Text(
                                          e.generatedName ??  "???",
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ));
                          }).then((value) {
                        if (value != null) {
                          setState(() {
                            subject = value;
                          });
                        }
                      });
                    },
                    child: Text(subject!.generatedName ?? "???",
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
                                    initialDate: date ?? DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 365)));
                              }).then((value) {
                            setState(() {
                              date = value;
                            });
                          });
                        },
                        child:
                            Text(DateFormat("EEE, dd. MMMM").format(date!)))),
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
                    subtitle: TextField(controller: titel)),
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
              onPressed: () async {
                if (titel!.text.isNotEmpty) {
                  homework
                    ?..lerngruppe.value = subject
                    ..title = titel?.text
                    ..description = beschreibung?.text
                    ..due = date?.millisecondsSinceEpoch
                    ..onlineIdentifier =
                        "OFFLINEID=${DateTime.now().microsecondsSinceEpoch}";

                  await StorageProvider.isar.writeTxn(() async {
                    await StorageProvider.isar.homeworks.put(homework!);
                    await homework?.lerngruppe.save();
                  }).then((value) {
                    notify!.notify("homework");
                    Navigator.of(context).pop();
                  });
                } else {
                  setState(() {
                    error = true;
                  });
                }
              },
              child: const Icon(Icons.save_outlined),
            ),
          );
        });
  }
}
