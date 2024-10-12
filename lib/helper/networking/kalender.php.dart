import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:sphplaner/helper/networking/sph.dart';


downloadKalender() async {
  await downloadKalenderColors();
  http.Response response = await SPH.post("/kalender.php", {"f":"iCalAbo"});
  if (response.statusCode == 200) {
    String url = response.body;

    http.Response iCalResponse = await SPH.get(url);
    String iCalString = iCalResponse.body;

    final dir = await getApplicationDocumentsDirectory();

    File iCal = File('${dir.path}/ical.ics');

    await iCal.writeAsString(iCalString);
  }
}

downloadKalenderColors() async {
  http.Response response = await SPH.get("/kalender.php");
  if (response.statusCode == 200) {
    dom.Document page = parse(response.body);
    dom.Element? content = page.getElementById("content");

    if (content != null) {
      List<dom.Element> scripts = content.getElementsByTagName("script");
      for (dom.Element script in scripts) {
        if (script.text.contains("var categories")) {
          List<String> categories = script.text.split("categories");

          Map<String, int> kategorien = {};
          for (String category in categories) {
            if (category.trim().startsWith(".push")) {
              String kategorieContent = category.trim().substring(6, category.trim().length - 3);
              kategorien[kategorieContent.split("'")[1].trim()] = Color(int.parse("0xFF${kategorieContent.split("'")[3].trim().replaceAll("#", "").toUpperCase()}")).value;
            }
          }

          final dir = await getApplicationDocumentsDirectory();

          File colors = File('${dir.path}/colors.json');

          await colors.writeAsString(jsonEncode(kategorien));
          break;
        }
      }
    }
  }
}