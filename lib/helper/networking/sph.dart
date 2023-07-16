import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:sphplaner/helper/crypto.dart';
import 'package:sphplaner/helper/networking/cookie.dart';
import 'package:sphplaner/helper/networking/timetable.dart';
import 'package:sphplaner/helper/networking/vertretungsplan.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/helper/storage/user.dart';

import '../school.dart';

class SPH {
  static List<School> schools = [];
  static String? _username;
  static String? _password;
  static int? _school;
  static const String _baseURL = "https://start.schulportal.hessen.de";
  static const int _timeout = 30;
  static String _sid = "";
  static int _lastSid = 0;
  static String _sessionKey = "";
  static final AESCrypto aes = AESCrypto();
  static RSACrypto? rsa;

  static setCredetials(String username, String password, int school) {
    _username = username;
    _password = password;
    _school = school;
  }

  static Future<void> setCredetialsFor(String userID) async {
    _username = await StorageProvider.getUsername(userID);
    _password = await StorageProvider.getPassword(userID);
    _school = (await StorageProvider.isar.users.getByUsername(userID))?.school ?? 0;
  }

  static Future<String> getSID() async {
    assert(_username != null, "Username not set");
    assert(_password != null, "Password not set");
    assert(_school != null, "School not set");

    if (_lastSid  + 15 * 60 * 1000 < DateTime.now().millisecondsSinceEpoch) {
      CookieStore.clearCookies();
      http.Response loginResponse =
          await post("https://login.schulportal.hessen.de", {
        "value":
            "user=$_school.$_username&password=${Uri.encodeComponent("$_password").replaceAll("!", "%21").replaceAll(")", "%29").replaceAll("(", "%28")}"
      });

      if (loginResponse.statusCode == 302 &&
          loginResponse.headers['location'] != null) {
        http.Response sidResponse =
            await get(loginResponse.headers['location']!);
        if (sidResponse.statusCode == 444) {
          _sid = "";
          return _sid;
        }

        if (sidResponse.body.contains("SPH-Login")) {
          _sid = CookieStore.getSID();
          _lastSid = DateTime.now().millisecondsSinceEpoch;
        }
      } else {
        _sid = "";
        return _sid;
      }
    }
    return _sid;
  }

  static Future<String> cryptoLogin() async {
    if (_sessionKey == "") {
      String uuid = _generateUUID();
      _sessionKey = aes.encrypt(uuid, uuid);

      http.Response response = await get("/ajax.php?f=rsaPublicKey");
      if (response.statusCode == 200 && response.body.contains("publickey")) {
        rsa = RSACrypto(jsonDecode(response.body)['publickey']);

        String encryptedSessionKey = rsa!.encrypt(_sessionKey);
        Map data = {'key': encryptedSessionKey};
        int s = Random().nextInt(1999);

        response = await post("/ajax.php?f=rsaHandshake&s=$s", data);

        if (response.statusCode == 200 && response.body.contains("challenge")) {
          String decryptChallenge =
              aes.decrypt(jsonDecode(response.body)['challenge'], _sessionKey);
          if (_sessionKey != decryptChallenge) {
            _sessionKey = "";
          }
        }
      }
    }
    return _sessionKey;
  }

  static Future<List<School>> downloadSchoolInfo() async {
    try {
      http.Response response = await http
          .get(Uri.parse("https://start.schulportal.hessen.de"))
          .timeout(const Duration(seconds: 3), onTimeout: () {
        throw TimeoutException;
      });

      dom.Document startpage = parse(response.body);

      dom.Element schoolList = startpage.getElementById("accordion")!;

      for (dom.Element school
          in schoolList.getElementsByClassName("list-group-item")) {
        String schoolInfo = school.innerHtml
            .replaceAll(" <small>", ";(")
            .replaceAll("</small>", ")");
        String schoolName = schoolInfo.split(";")[0];
        String schoolCity = schoolInfo.split(";")[1];
        String schoolId = school.attributes['data-id'] ?? "";
        schools.add(School(name: schoolName, city: schoolCity, id: schoolId));
      }
    } catch (_) {}
    return schools;
  }

  static Future<String> updateUser() async {
    await getSID();

    String userID = "";

    if (_sid != "") {
      Isar isar = StorageProvider.isar;

      String schoolID = "";
      String schoolName = "";
      String firstName = "";
      String lastName = "";
      String email = "";
      String birthDate = "";
      String image = "";
      String grade = "";
      String course = "";

      http.Response benutzerInfo =
          await get("/benutzerverwaltung.php?a=userData");
      if (benutzerInfo.statusCode == 200) {
        dom.Document page = parse(benutzerInfo.body);

        schoolName = page
                .getElementById("institutionsid")
                ?.attributes['data-bezeichnung'] ??
            "";
        schoolID = page.getElementById("institutionsid")?.text ?? "";

        firstName = page
            .getElementsByTagName('table')[0]
            .getElementsByTagName('td')[5]
            .text;
        lastName = page
            .getElementsByTagName('table')[0]
            .getElementsByTagName('td')[3]
            .text;
        birthDate = page
            .getElementsByTagName('table')[0]
            .getElementsByTagName('td')[7]
            .text;
        course = page
            .getElementsByTagName('table')[0]
            .getElementsByTagName('td')[11]
            .text;
        grade = page
            .getElementsByTagName('table')[0]
            .getElementsByTagName('td')[9]
            .text;
      }

      http.Response benutzerMail =
          await get("/benutzerverwaltung.php?a=userMail");

      if (benutzerMail.statusCode == 200) {
        dom.Document mailPage = parse(benutzerMail.body);

        email = mailPage.getElementById('mail')?.attributes['value'] ?? "";
      }

      http.Response userImage =
          await get("/benutzerverwaltung.php?a=userFoto&b=show");

      if (userImage.statusCode == 200) {
        image = base64Encode(userImage.bodyBytes);
      }

      userID = base64Encode(utf8.encode(_username!));

      final User user = await isar.users.getByUsername(userID) ?? User()
        ..username = userID;

      await isar.writeTxn(() async {
        user.autoUpdate ??= true;
        user.theme ??= "system";

        if (schoolID.isNotEmpty) {
          user.school = int.parse(schoolID);
        }

        if (schoolName.isNotEmpty) {
          user.schoolName = schoolName;
        }

        if (firstName.isNotEmpty) {
          user.firstName = firstName;
          user.displayName ??= firstName;
        }

        if (lastName.isNotEmpty) {
          user.lastName = lastName;
        }

        if (email.isNotEmpty) {
          user.email = email;
        }

        if (birthDate.isNotEmpty) {
          user.birthDate = birthDate;
        }

        if (image.isNotEmpty) {
          user.profileImage = image;
        }

        if (grade.isNotEmpty) {
          user.grade = grade;
        }

        if (course.isNotEmpty) {
          user.course = course;
        }

        await isar.users.put(user);
      });
    }
    return userID;
  }

  static get(String url) async {
    if (url.startsWith("/")) {
      url = "$_baseURL$url";
    }

    http.Response response;
    try {
      response = await http
          .get(Uri.parse(url),
              headers: CookieStore.getCookies().toString().isNotEmpty
                  ? {'Cookie': CookieStore.getCookies()}
                  : {})
          .timeout(const Duration(seconds: _timeout), onTimeout: () {
        throw TimeoutException;
      });
    } catch (_) {
      return http.Response.bytes([], 444);
    }

    CookieStore.saveCookies(response);

    return response;
  }

  static post(String url, Map data) async {
    if (url.startsWith("/")) {
      url = "$_baseURL$url";
    }

    dynamic finalData;
    if (data.containsKey("value")) {
      finalData = data["value"];
    } else {
      finalData = data;
    }

    http.Response response;
    try {
      response = await http.post(Uri.parse(url), body: finalData, headers: {
        if (CookieStore.getCookies().toString().isNotEmpty)
          'Cookie': CookieStore.getCookies(),
        'Content-Type': "application/x-www-form-urlencoded"
      }).timeout(const Duration(seconds: _timeout), onTimeout: () {
        throw TimeoutException;
      });
    } catch (_) {
      return http.Response.bytes([], 444);
    }

    CookieStore.saveCookies(response);

    return response;
  }

  static String _generateUUID() {
    const pattern = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx-xxxxxx3xx';
    var uuid = '';
    for (var i = 0; i < pattern.length; i++) {
      if (pattern[i] == 'x' || pattern[i] == 'y') {
        uuid += Random().nextInt(16).toRadixString(16);
      } else {
        uuid += pattern[i];
      }
    }
    return uuid;
  }

  static Future<void> update(StorageNotifier notify) async {
    StorageProvider.settings.updateLockText = "Update Stundenplan...";
    notify.notify("main");
    await TimeTable.downloadTimetable();
    StorageProvider.settings.updateLockText = "Update Vertretungsplan...";
    notify.notify("main");
    await Vertretungsplan.download();
    StorageProvider.settings.updateLockText = "Update Benutzerdaten...";
    notify.notify("main");
    await updateUser();
    StorageProvider.settings.updateLockText = "";
    StorageProvider.settings.status =
        "Letztes Update: ${DateFormat('dd.MM.y HH:mm').format(DateTime.now())}";
    notify.notify("main");
  }
}
