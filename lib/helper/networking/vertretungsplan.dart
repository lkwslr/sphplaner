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
      if (page.getElementById("content") != null &&
          page.getElementById("menue_tag") != null) {
        dom.Element tableHead = page.getElementById("menue_tag")!;
        List<String> dates = tableHead
            .getElementsByClassName("btn")
            .map((e) => e.attributes['data-tag']!.replaceAll("_", "."))
            .toList();

        List<Vertretung> vertretungs = [];

        for (String date in dates) {
          int weekday = DateFormat("dd.MM.yyyy").parse(date).weekday;
          dom.Element table =
              page.getElementById("vtable${date.replaceAll('.', '_')}")!;
          if (!table.text.contains("Keine Einträge!")) {
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
                  subject = Subject()
                    ..subject = content['Fach'].toString().trim()
                    ..subjectName = content['Fach'].toString().trim();
                  await isar.writeTxn(() async {
                    await isar.subjects.putBySubject(subject!);
                  });
                }

                if (content["Klasse"].toString().trim().isEmpty ||
                    content["Klasse"]
                        .toString()
                        .trim()
                        .contains(StorageProvider.user?.course ?? "")) {
                  vertretungs.add(Vertretung()
                    ..subject.value = subject
                    ..room = content['Raum'].toString().trim()
                    ..teacher = content['Vertreter'].toString().trim()
                    ..hour = hour
                    ..dayOfWeek = weekday
                    ..date = date
                    ..note = content['Hinweis'].toString().trim()
                    ..type = content['Art'].toString().trim());
                }
              }
            }
          }
        }

        StorageProvider.vertretungsDate = dates;
        if (vertretungs.isNotEmpty) {
          await isar.writeTxn(() async {
            await isar.vertretungs.putAll(vertretungs);
            for (Vertretung vertretung in vertretungs) {
              await vertretung.subject.save();
            }
          });
        }
      }
    }
  }
}
