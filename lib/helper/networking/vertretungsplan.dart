import 'package:intl/intl.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/subject.dart';
import 'package:sphplaner/helper/storage/vertretung.dart';

class Vertretungsplan {
  static download() async {
    await SPH.getSID();
    Isar isar = StorageProvider.isar;

    http.Response response = await SPH.get("/vertretungsplan.php");
    if (response.statusCode == 200) {
      dom.Document page = parse(response.body);

      dom.Element? content = page.getElementById("content");

      if (content != null) {
        List<dom.Element> panels = content.getElementsByClassName("panel");
        List<String> dates = [];
        List<Vertretung> vertretungs = [];

        for (dom.Element panel in panels) {
          if (panel.id.startsWith("tag")) {
            String date = panel.id.substring(3).replaceAll("_", ("."));
            dates.add(date);
            int weekday = DateFormat("dd.MM.yyyy").parse(date).weekday;

            dom.Element? table =
                page.getElementById(panel.id.replaceAll("tag", "vtable"));

            if (table != null && !table.text.contains("Keine Einträge!")) {
              dom.Element head = table.getElementsByTagName("thead")[0];
              Map availableColumns = {};
              for (int index = 0;
                  index < head.getElementsByTagName("th").length;
                  index++) {
                if (head
                        .getElementsByTagName("th")[index]
                        .attributes['data-field'] !=
                    null) {
                  availableColumns[head
                      .getElementsByTagName("th")[index]
                      .attributes['data-field']!] = index;
                }
              }
              dom.Element body = table.getElementsByTagName("tbody")[0];
              Map content = {
                "Fach": "",
                "Stunde": "",
                "Raum": "",
                "Art": "",
                "Hinweis": "",
                "Vertreter": "",
                "Klasse": ""
              };
              for (dom.Element row in body.getElementsByTagName("tr")) {
                for (MapEntry entry in availableColumns.entries) {
                  content[entry.key] =
                      row.getElementsByTagName("td")[entry.value].text.trim();
                }
                List<int> hours = content['Stunde']
                    .toString()
                    .split('-')
                    .map((e) => int.parse(e.trim()))
                    .toList();

                for (int hour in hours) {
                  Subject? subject = StorageProvider.isar.subjects
                      .getBySubjectSync(content['Fach'].toString().trim());

                  if (subject == null) {
                    vertretungs.add(Vertretung()
                      ..vertrSubject = content['Fach'].toString().trim()
                      ..room = content['Raum'].toString().trim()
                      ..teacher = content['Vertreter'].toString().trim()
                      ..hour = hour
                      ..dayOfWeek = weekday
                      ..date = date
                      ..classes = content["Klasse"].toString().trim()
                      ..note = content['Hinweis'].toString().trim()
                      ..type = content['Art'].toString().trim());
                  } else {
                    vertretungs.add(Vertretung()
                      ..subject.value = subject
                      ..room = content['Raum'].toString().trim()
                      ..teacher = content['Vertreter'].toString().trim()
                      ..hour = hour
                      ..dayOfWeek = weekday
                      ..date = date
                      ..classes = content["Klasse"].toString().trim()
                      ..note = content['Hinweis'].toString().trim()
                      ..type = content['Art'].toString().trim());
                  }
                }
              }
            }
          }
        }
        StorageProvider.vertretungsDate = dates;
        if (vertretungs.isNotEmpty) {
          for (Vertretung vertretung in vertretungs) {
            if ((vertretung.classes?.trim() ?? "").isEmpty ||
                StorageProvider.settings.loadAllVertretung ||
                (vertretung.classes?.trim().toLowerCase() ?? "").contains(
                    StorageProvider.user.course?.toLowerCase() ?? "")) {
              Vertretung? test = await isar.vertretungs
                  .where()
                  .dateDayOfWeekHourEqualTo(
                      vertretung.date, vertretung.dayOfWeek, vertretung.hour)
                  .findFirst();
              if (test == null || test.subject.value != null) {
                await isar.writeTxn(() async {
                  await isar.vertretungs.put(vertretung);
                  await vertretung.subject.save();
                });
              }
            }
          }
        }
      }
    }
  }
}
