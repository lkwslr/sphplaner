import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/homework.dart';

class HomeWork {
  static downloadHomework() async {
    Isar isar = StorageProvider.isar;

    http.Response response = await SPH.get("/meinunterricht.php");
    if (response.statusCode == 200 && !response.body.contains("Fehler")) {
      dom.Document page = parse(response.body);

      dom.Element table = page.getElementById("aktuellTable")!;

      List<dom.Element> stunden = table.getElementsByClassName("printable");

      for (dom.Element stunde in stunden) {
        if (stunde.innerHtml.contains('class="homework"')) {

          String fach = stunde.getElementsByClassName("name")[0].text;
          String title = "Hausaufgaben in $fach";
          String description = stunde.getElementsByClassName("realHomework")[0].text;
          String stundenThema = stunde.getElementsByClassName("thema")[0].text;

          String onlineIdentifier = "$fach$title$description$stundenThema";

          Homework? homework = await StorageProvider.isar.homeworks.getByOnlineIdentifier(onlineIdentifier);

          if (homework == null) {
            homework = Homework()
              ..user.value = StorageProvider.user
              ..title = title
              ..description = description
              ..online = true
              ..onlineIdentifier = onlineIdentifier;

            await isar.writeTxn(() async {
              await isar.homeworks.putByOnlineIdentifier(homework!);
              await homework.user.save();
            });
          }
        }
      }

    }
  }
}