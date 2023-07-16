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
      if (page.getElementById("content") != null) {
        dom.Element tableHead = page.getElementById("menue_tag")!;
        List dates = tableHead
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
            Map availableColumns = {} ;
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
              "Vertreter": ""
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
                if (subject != null) {
                  vertretungs.add(Vertretung()
                    ..subject.value = subject
                    ..room = content['Raum']
                    ..teacher = content['Vertreter']
                    ..hour = hour
                    ..dayOfWeek = weekday
                    ..date = date
                    ..note = content['Hinweis']
                    ..type = content['Art']);
                }
              }
            }
          }
        }

        if (vertretungs.isNotEmpty) {
          await isar.writeTxn(() async {
            await isar.vertretungs.where().deleteAll();
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
