import 'package:flutter/material.dart';
import 'package:sphplaner/helper/backend.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

class Vertretung extends StatefulWidget {
  const Vertretung({super.key});

  @override
  State<StatefulWidget> createState() => _Vertretungen();
}

class _Vertretungen extends State<Vertretung> {
  @override
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<Backend, String>(
      properties: const ['vertretung'],
      builder: (context, backend, child) {
        String today = backend!.vertretungsplan['heute']['day'] +
            " - " +
            backend.vertretungsplan['heute']['date'];
        String tomorrow = backend.vertretungsplan['morgen']['day'] +
            " - " +
            backend.vertretungsplan['morgen']['date'];

        int index = 0;

        List dateToday =
            backend.vertretungsplan['heute']['date'].toString().split(".");
        List dateTomorrow =
            backend.vertretungsplan['morgen']['date'].toString().split(".");
        if (dateToday.length > 1 && dateTomorrow.length > 1) {
          for (int i = 0; i <= 1; i++) {
            if (dateToday[i].toString().length == 1) {
              dateToday[i] = "0${dateToday[i]}";
            }
            if (dateTomorrow[i].toString().length == 1) {
              dateTomorrow[i] = "0${dateTomorrow[i]}";
            }
          }

          DateTime todayTime = DateTime.parse(
              '${dateToday[2]}-${dateToday[1]}-${dateToday[0]} 18:00:00');

          if (backend.viewMode == "18uhr") {
            if (DateTime.now().isAfter(todayTime)) {
              index = 1;
            }
          }
        }

        return DefaultTabController(
            length: 2,
            initialIndex: index,
            child: Scaffold(
                appBar: TabBar(
                  isScrollable: false,
                  tabs: [
                    for (final t in [today, tomorrow])
                      Tab(
                        text: t,
                      ),
                  ],
                ),
                body: TabBarView(
                  children: [_buildBody('heute'), _buildBody('morgen')],
                )));
      },
    );
  }

  Widget _buildBody(String day) {
    return PropertyChangeConsumer<Backend, String>(
      properties: const ['vertretungsplan', 'klasse', 'userNames'],
      builder: (context, backend, child) {
        String infos = backend!.vertretungsplan[day]['information'];

        List filterVertretung = [];

        String customKlasse = backend.klasse;
        if (customKlasse.startsWith("Q")) {
          customKlasse[1] == '1' || customKlasse[1] == '2'
              ? customKlasse = "Q12"
              : customKlasse = "Q34";
        }

        for (Map vertretungs in backend.vertretungsplan[day]['vertretung']) {
          bool correctClass = false;

          for (int char = 0; char < customKlasse.length; char++) {
            if (vertretungs['klasse'].contains(customKlasse[char])) {
              correctClass = true;
            } else {
              correctClass = false;
              break;
            }
          }

          if (correctClass) {
            if (backend.faecher.isEmpty ||
                backend.faecher.contains(vertretungs['altesFach']) ||
                backend.faecher.contains(vertretungs['fach'])) {
              filterVertretung.add(vertretungs);
            }
          }
        }

        Map userNames = backend.userNames;
        String name = "";

        for (String key in userNames.keys) {
          if (userNames[key]) {
            name += ' $key';
          }
        }

        return Padding(
            padding: const EdgeInsets.all(8),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: const Text(
                    'Informationen',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  subtitle: Text(infos == "" ? "Keine Informationen" : infos),
                ),
                const Divider(),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: Text(
                    name != "" ? "Vertretung für$name" : "Deine Vertretung",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                _buildRows(filterVertretung),
              ],
            ));
      },
    );
  }

  Widget _buildRows(List vertretung) {
    if (vertretung.isNotEmpty) {
      return ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: vertretung.length,
          itemBuilder: (context, i) {
            return _buildRow(vertretung[i]);
          });
    } else {
      return const ListTile(
        subtitle: Text(
          'Keine Vertretung',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  Widget _buildRow(Map vertretungsData) {
    String vertretungsText = vertretungsData['stunde'] +
        ". Std.: " +
        vertretungsData['fach'] +
        " in Raum " +
        vertretungsData['raum'] +
        " statt " +
        vertretungsData['altesFach'] +
        " (" +
        vertretungsData['art'] +
        ")";
    if (vertretungsData['informationen'].toString().trim().isNotEmpty) {
      vertretungsText += "\nInformationen: ${vertretungsData['informationen']}";
    }

    return ListTile(
      title: Text(vertretungsData['klasse']),
      subtitle: Text(vertretungsText),
    );
  }
}
