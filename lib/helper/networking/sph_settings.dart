import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:sphplaner/helper/storage/user.dart';

class SPHSettings {
  static changePassword(String oldPassword, String newPassword) async {
    await SPH.getSID();
    Isar isar = StorageProvider.isar;

    http.Response response =
        await SPH.get("/benutzerverwaltung.php?a=userChangePassword");
    if (response.statusCode == 200) {
      String ikey = parse(response.body)
              .getElementsByTagName("input")
              .firstWhere((element) => element.attributes['name'] == "ikey")
              .attributes['value'] ??
          "";

      if (ikey != "") {
        User? user = await isar.users.get(0);

        if (user != null) {
          Map data = {
            'ikey': ikey,
            'isPupil': "1",
            'stufe': user.grade,
            'inst': user.school,
            'success': 'false',
            'passwortSicher': 'ja',
            'passwortWiederholung': 'ja',
            'ownpw': SPH.encrypt(oldPassword),
            'pw': SPH.encrypt(newPassword),
            'pw2': SPH.encrypt(newPassword),
            'save': ""
          };

          http.Response response = await SPH.post(
              "/benutzerverwaltung.php?a=userChangePassword", data);
          if (response.statusCode == 200 && response.body
              .contains("Das Passwort wurde erfolgreich geändert!")) {
            StorageProvider.savePassword(user.username ?? "", newPassword);
            return true;
          }
          return false;
        }
      }
    }
  }
}
