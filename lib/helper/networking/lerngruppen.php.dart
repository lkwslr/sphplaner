import 'package:isar/isar.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/lehrkraft.dart';
import 'package:sphplaner/helper/storage/lerngruppe.dart';
import 'package:sphplaner/helper/storage/leistungskontrolle.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;


downloadLerngruppen() async {
  http.Response response = await SPH.get("/lerngruppen.php");
  if (response.statusCode == 200) {
    dom.Document page = parse(response.body);
    if (response.body.contains("Fehler")) {
      StorageProvider.settings.lerngruppen = false;
    } else if (page.getElementById("kurse") != null) {
      await saveLerngruppen(page.getElementById("kurse")!);
    }
  }
}

saveLerngruppen(dom.Element kurse) async {
  dom.Element tbody = kurse.getElementsByTagName("tbody")[0];

  List<dom.Element> kursListe = tbody.getElementsByTagName("tr");

  if (kursListe.isNotEmpty) {
    await StorageProvider.isar.writeTxn(() async {
      await StorageProvider.isar.lehrkrafts.filter().syncedEqualTo(true).deleteAll();
      await StorageProvider.isar.lerngruppes.filter().syncedEqualTo(true).editedEqualTo(false).deleteAll();
      await StorageProvider.isar.leistungskontrolles.filter().syncedEqualTo(true).deleteAll();
    });
  }

  for (dom.Element kurs in kursListe){
    List<dom.Element> kursEigenschaften = kurs.getElementsByTagName("td");

    String halbjahr = kursEigenschaften[0].text.trim();
    String fullName = kursEigenschaften[1].text.trim();
    String gruppenDefinition = kursEigenschaften[1].getElementsByTagName("small")[0].text.trim();
    String gruppenId = gruppenDefinition.split(" - ")[0].replaceAll("(", "").trim();
    String name = fullName.replaceAll(gruppenDefinition, "").trim();

    String zweig = gruppenDefinition.split(" - ")[1].trim().replaceAll(")", "");
    String fullLehrkraft = kursEigenschaften[2].text.trim();
    String lehrkraftKuerzel = fullLehrkraft.split("(")[1].replaceAll(")", "").trim();
    String lehrkraftName = fullLehrkraft.split("(")[0].trim();

    Lehrkraft? lehrkraft = await StorageProvider.isar.lehrkrafts.getByKuerzel(lehrkraftKuerzel);
    lehrkraft ??= Lehrkraft()
        ..kuerzel = lehrkraftKuerzel
        ..name = lehrkraftName
        ..fullLehrkraft = fullLehrkraft;

    Lerngruppe? lerngruppe = await StorageProvider.isar.lerngruppes.getByGruppenId(gruppenId);
    if (lerngruppe != null) {
            if (lerngruppe.lehrkraft.value != null) {
        lehrkraft = lerngruppe.lehrkraft.value;
      }
      lerngruppe
        ..fullName = fullName
        ..name = name
        ..halbjahr = halbjahr
        ..zweig = zweig
        ..lehrkraft.value = lehrkraft;
    } else {
      lerngruppe = Lerngruppe()
        ..gruppenId = gruppenId
        ..fullName = fullName
        ..generatedName = getDefaultName(gruppenId)
        ..name = name
        ..halbjahr = halbjahr
        ..zweig = zweig
        ..farbe = getDefaultColor(gruppenId) ?? 4294967295
        ..lehrkraft.value = lehrkraft;
    }

    lehrkraft?.lerngruppen.add(lerngruppe);

    List<Leistungskontrolle> leistungskontrollen = [];

    for (String klausur in kursEigenschaften[3].text.trim().split("\n")) {
        klausur = klausur.trim();
        if (klausur.isNotEmpty) {
          String datum = klausur.split(" ")[0];
          String jahr = datum.split(".")[2];
          String monat = datum.split(".")[1];
          String tag = datum.split(".")[0];
          DateTime date = DateTime.parse("$jahr-$monat-$tag");

          String art = klausur.split(" ")[1].substring(0, klausur.split(" ")[1].length -1);

          List<int> stunden = [];
          if (klausur.split(" ").length > 2) {
            String zeit = klausur.split(" ")[2];
            int stundeAnfang = 0;
            int stundeEnde = 0;
            if (zeit.contains("-")) {
              stundeAnfang = int.parse(zeit.split("-")[0].replaceAll(".", ""));
              stundeEnde = int.parse(zeit.split("-")[1].replaceAll(".", ""));
            } else {
              try {
                stundeAnfang = int.parse(zeit.split(" ")[0].replaceAll(".", ""));
                stundeEnde = int.parse(zeit.split(" ")[zeit.split(" ").length-2].replaceAll(".", ""));
              } catch (_) {}
            }


            for (int i=stundeAnfang;i<=stundeEnde; i++) {
              stunden.add(i);
            }
          }

          Leistungskontrolle leistungskontrolle = Leistungskontrolle()
            ..datum = date
            ..art = art
            ..stunden = stunden
            ..lerngruppe.value = lerngruppe;

          leistungskontrollen.add(leistungskontrolle);
        }
    }

    lerngruppe.leistungskontrollen.addAll(leistungskontrollen);

    await StorageProvider.isar.writeTxn(() async {
      await StorageProvider.isar.lehrkrafts.putByKuerzel(lehrkraft!);
      await StorageProvider.isar.lerngruppes.putByGruppenId(lerngruppe!);
      await StorageProvider.isar.leistungskontrolles.putAll(leistungskontrollen);
      await lerngruppe.lehrkraft.save();
      await lerngruppe.leistungskontrollen.save();
      await lehrkraft.lerngruppen.save();
      for (Leistungskontrolle leistungskontrolle in leistungskontrollen) {
        leistungskontrolle.lerngruppe.save();
      }
    });
  }
}