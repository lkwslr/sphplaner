import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/lehrkraft.dart';
import 'package:sphplaner/helper/storage/lerngruppe.dart';
import 'package:sphplaner/helper/storage/schulstunde.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';

downloadStundenplan() async {
  http.Response response = await SPH.get("/stundenplan.php");
  if (response.statusCode == 200) {
    dom.Document page = parse(response.body);
    if (page.getElementById("all") != null) {
      await saveStundenplan(page.getElementById("all")!);
    }
  }
}

saveStundenplan(dom.Element gesamtplan) async {
  dom.Element tbody = gesamtplan.getElementsByTagName("tbody")[0];

  if (tbody.getElementsByClassName("stunde")[0].attributes['title']?.contains("bei der Klasse/Stufe/Lerngruppe") ?? false) {
    await StorageProvider.isar.writeTxn(() async {
      await StorageProvider.isar.schulstundes.filter().syncedEqualTo(true).deleteAll();
    });
  }

  List<dom.Element> stunden = tbody.getElementsByTagName("tr");
  if (stunden[0].text.trim().isEmpty) {
    stunden.removeAt(0); //entferne leere Zeile, falls vorhanden (Fehler im SPH)
  }

  List<String> stundenZeiten = [];

  //Notwendig, um verschiebung durch doppelstunden auszugleichen
  List<List<bool>> stundenplan = [];
  for (dom.Element _ in stunden) {
    List<bool> stundenplanZeile = [false, false, false, false, false];
    stundenplan.add(stundenplanZeile);
  }

  for (int iStunde = 0; iStunde < stunden.length; iStunde++) {
    dom.Element stunde = stunden[iStunde];

    List<dom.Element> tage = stunde.getElementsByTagName("td");

    String zeiten = tage[0].getElementsByClassName("VonBis")[0].text.trim();
    stundenZeiten.add(zeiten);

    tage.removeAt(0);

    int wochentagVerschiebung = 0;
    for (int iTag = 0; iTag < tage.length; iTag++) {
      dom.Element tag = tage[iTag];

      if (stundenplan[iStunde][iTag]) {
        wochentagVerschiebung++;
      }

      List<dom.Element> moeglicheFaecher = tag.getElementsByClassName("stunde");
      for (dom.Element moeglichesFach in moeglicheFaecher) {
        String fach = moeglichesFach.getElementsByTagName("b")[0].text.trim();
        String lehrkraft =
            moeglichesFach.getElementsByTagName("small")[0].text.trim();

        Lerngruppe? lerngruppe = await StorageProvider.isar.lerngruppes
            .filter()
            .generatedNameEqualTo(getDefaultName(fach))
            .lehrkraft((q) {
          return q.kuerzelContains(lehrkraft);
        }).findFirst();

        int rowspan = int.tryParse(tag.attributes['rowspan'] ?? "1") ?? 1;

        if (lerngruppe != null) {
          for (int iRowspan = 0; iRowspan < rowspan; iRowspan++) {
            String raum = moeglichesFach.text
                .replaceAll(fach, "")
                .replaceAll(lehrkraft, "")
                .trim();
            Schulstunde schulstunde = Schulstunde()
              ..wochentag = iTag + wochentagVerschiebung
              ..raum = raum
              ..stunde = iStunde + 1 + iRowspan
              ..fach.value = lerngruppe;

            stundenplan[iStunde + iRowspan][iTag + wochentagVerschiebung] = true;

            await StorageProvider.isar.writeTxn(() async {
              await StorageProvider.isar.schulstundes.putByWochentagStunde(schulstunde);
              await schulstunde.fach.save();
            });
          }
          break;
        }
      }
    }
  }
}
