import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/lehrkraft.dart';
import 'package:sphplaner/helper/storage/lerngruppe.dart';
import 'package:sphplaner/helper/storage/schulstunde.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';

import '../storage/vertretung.dart';

downloadVertretungsplan() async {
  http.Response response = await SPH.get("/vertretungsplan.php");
  if (response.statusCode == 200) {
    dom.Document page = parse(response.body);
    if (page.getElementById("content") != null) {
      await saveVertretungsplan(page);
    }
  }
}

saveVertretungsplan(dom.Document page) async {
  dom.Element content = page.getElementById("content")!;
  List<dom.Element>? panels = content.getElementsByClassName("panel");

  StorageProvider.vertretungsDate = [];
  await StorageProvider.isar.writeTxn(() async {
    await StorageProvider.isar.vertretungs.clear();
  });

  if (content.text.replaceAll(" ", "").replaceAll("\n", "").contains(
      "KeineEinträge!AktuellliegenfürdieangemeldetePersonkeineMeldungenüberVertretungenvor!")) {
    if (DateTime.now().weekday <= 5) {
      String datum =  DateFormat("dd.MM.yyyy").format(DateTime.now());
      int wochentag = DateTime.now().weekday;
      await StorageProvider.isar.writeTxn(() async {
        await StorageProvider.isar.vertretungs.put(Vertretung()
          ..stunden = [0]
          ..wochentag = wochentag
          ..datum = datum
          ..placeholder = true);
      });
    }
  } else {
    for (dom.Element panel in panels) {
      if (panel.id.startsWith("tag")) {
        String date = panel.id.substring(3).replaceAll("_", ("."));
        int weekday = DateFormat("dd.MM.yyyy").parse(date).weekday;
        StorageProvider.vertretungsDate.add(date);

        dom.Element? table =
            page.getElementById(panel.id.replaceAll("tag", "vtable"));

        await StorageProvider.isar.writeTxn(() async {
          await StorageProvider.isar.vertretungs.put(Vertretung()
            ..stunden = [0]
            ..wochentag = weekday
            ..datum = date
            ..placeholder = true);
        });

        if (table != null && !table.text.contains("Keine Einträge!")) {
          dom.Element head = table.getElementsByTagName("thead")[0];
          Map<String, int> verfuegbareSpalten = {};
          List<dom.Element> ths = head.getElementsByTagName("th");
          for (int iThs = 0; iThs < ths.length; iThs++) {
            if (!(ths[iThs].attributes['data-field']?.startsWith("_") ??
                true)) {
              verfuegbareSpalten[(ths[iThs].attributes['data-field']!)] = iThs;
            }
          }

          dom.Element body = table.getElementsByTagName("tbody")[0];
          for (dom.Element tr in body.getElementsByTagName("tr")) {
            List<dom.Element> tds = tr.getElementsByTagName("td");
            Map content = {
              "Fach": "",
              "Fach_alt": "",
              "Stunde": "",
              "Raum": "",
              "Raum_alt": "",
              "Art": "",
              "Hinweis": "",
              "Hinweis2": "",
              "Vertreter": "",
              "Klasse": "",
              "Lehrer": ""
            };
            for (MapEntry entry in verfuegbareSpalten.entries) {
              content[entry.key] = tds[entry.value].text.trim();
            }

            List<int> hours = content['Stunde']
                .toString()
                .split('-')
                .map((e) => int.parse(e.trim()))
                .toList();

            String selector = content['Fach_alt'].isNotEmpty
                ? "Fach_alt"
                : content['Fach'].isNotEmpty
                ? "Fach"
                : "---";

            //TODO content['Lehrer'] = "DORN";

            Lerngruppe? subject = await StorageProvider.isar.lerngruppes
                .filter()
                .generatedNameEqualTo(
                getDefaultName(content[selector].toString().trim()))
                .lehrkraft((q) {
              return q.kuerzelContains(content['Lehrer'].toString().trim());
            }).findFirst();

            Vertretung vertretung = Vertretung()
              ..raum = content['Raum_alt'].toString().trim().isNotEmpty ? content['Raum_alt'].toString().trim() : ""
              ..vertretungsRaum = content['Raum'].toString().trim().isNotEmpty ? content['Raum'].toString().trim() : "---"
              ..lehrkraft = content['Lehrer'].toString().trim()
              ..vertretungsLehrkraft = content['Vertreter'].toString().trim()
              ..stunden = hours
              ..wochentag = weekday
              ..datum = date
              ..kurs = content["Klasse"]?.trim()
              ..hinweis = "${content['Hinweis'].toString().trim()}\n${content['Hinweis2'].toString().trim()}".trim()
              ..art = content['Art']?.trim()
              ..fach = getDefaultName(content['Fach_alt']?.trim())
              ..vertretungsFach = getDefaultName(content['Fach']?.trim())
              ..lerngruppe.value = subject;

            await StorageProvider.isar.writeTxn(() async {
              await StorageProvider.isar.vertretungs.put(vertretung);
              await vertretung.lerngruppe.save();
            });
          }
        }
      }
    }
  }
}
