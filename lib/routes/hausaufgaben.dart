import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/storage/homework.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/helper/storage/subject.dart';

class HomeWork extends StatefulWidget {
  const HomeWork({Key? key}) : super(key: key);

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
                        await StorageProvider.isar.writeTxn(() async {
                          await StorageProvider.isar.homeworks
                              .delete(homework.id);
                        }).then((value) {
                          notify!.notify("homework");
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              clipBehavior: Clip.none,
                              behavior: SnackBarBehavior.floating,
                              action: SnackBarAction(
                                  label: "Rückgängig",
                                  onPressed: () async {
                                    await StorageProvider.isar
                                        .writeTxn(() async {
                                      await StorageProvider.isar.homeworks
                                          .put(homework);

                                    });
                                    notify.notify("homework");
                                  }),
                              content:
                                  Text('${homework.title} wurde entfernt.')));
                        });
                      },
                      background: Container(color: Colors.red),
                      child: ListTile(
                        isThreeLine: true,
                        title: Text(
                          homework.title ?? "???",
                          style: TextStyle(
                              color: DateTime.now().isAfter(
                                      DateTime.fromMillisecondsSinceEpoch(
                                          homework.due ?? 0))
                                  ? Colors.red
                                  : Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color),
                        ),
                        leading: Container(
                          height: double.infinity,
                          width: 16,
                          color: Color(homework.subject.value?.color ??
                              Colors.white.value),
                          child: RotatedBox(
                              quarterTurns: -1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                    homework.subject.value?.subject ?? "???",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 12)),
                              )),
                        ),
                        minLeadingWidth: 8,
                        trailing: Column(
                          children: [
                            Text("Erledigen bis",
                                style: TextStyle(
                                    color: DateTime.now().isAfter(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                homework.due ?? 0))
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
                                      homework.due ?? 0)),
                              style: TextStyle(
                                  color: DateTime.now().isAfter(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              homework.due ?? 0))
                                      ? Colors.red
                                      : Theme.of(context).colorScheme.secondary,
                                  fontSize: 24),
                            )
                          ],
                        ),
                        subtitle: Text(homework.description ?? "???",
                            style: TextStyle(
                                color: DateTime.now().isAfter(
                                        DateTime.fromMillisecondsSinceEpoch(
                                            homework.due ?? 0))
                                    ? Colors.red
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color),
                            maxLines: 3,
                            overflow: TextOverflow.fade),
                        onTap: () {
                          if ((homework.description ?? "???").isNotEmpty) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(16),
                                      title: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child:
                                                Text(homework.title ?? "???"),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(DateFormat("dd.MM.")
                                                .format(DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        homework.due ?? 0))),
                                          )
                                        ],
                                      ),
                                      content: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                              homework.description ?? "???")));
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
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
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
  Subject? subject;
  DateTime date = DateTime.now();
  bool error = false;
  TextEditingController titel = TextEditingController();
  TextEditingController beschreibung = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<StorageNotifier, String>(
        properties: const ["homework"],
        builder: (context, notify, child) {
          List<Subject> subjects =
              StorageProvider.isar.subjects.where().findAllSync();

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
          subject ??= subjects.first;
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
                        backgroundColor: Color(subject!.color)),
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
                                            backgroundColor: Color(e.color)),
                                        onPressed: () {
                                          Navigator.of(context).pop(e);
                                        },
                                        child: Text(
                                          e.subjectName ?? "???",
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
                    child: Text(subject!.subjectName ?? "???",
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
              onPressed: () async {
                if (titel.text.isNotEmpty) {
                  Homework homework = Homework()
                    ..user.value = StorageProvider.user
                    ..subject.value = subject
                    ..title = titel.text
                    ..description = beschreibung.text
                    ..due = date.millisecondsSinceEpoch;

                  await StorageProvider.isar.writeTxn(() async {
                    await StorageProvider.isar.homeworks.put(homework);
                    await homework.subject.save();
                    await homework.user.save();
                    notify!.notify("homework");
                  }).then((value) => Navigator.of(context).pop());
                } else {
                  setState(() {
                    error = true;
                  });
                }
              },
              child: Icon(
                Icons.save_outlined,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          );
        });
  }
}
