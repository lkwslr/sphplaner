import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:logging/logging.dart';
import 'package:sphplaner/helper/crypto.dart';
import 'package:sphplaner/helper/networking/cookie.dart';
import 'package:sphplaner/helper/networking/homework.dart';
import 'package:sphplaner/helper/networking/sph_settings.dart';
import 'package:sphplaner/helper/networking/timetable.dart';
import 'package:sphplaner/helper/networking/vertretungsplan.dart';
import 'package:sphplaner/helper/storage/lesson.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/helper/storage/subject.dart';
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
  static String _sessionKey = "";
  static final AESCrypto aes = AESCrypto();
  static RSACrypto? rsa;
  static final logger = Logger("SPH Networking");
  static bool alive = false;

  static setCredetials(String username, String password, int school) {
    _username = username;
    _password = password;
    _school = school;
  }

  static Future<bool> setCredetialsFor(String userID) async {
    try {
      _username = await StorageProvider.getUsername(userID);
      _password = await StorageProvider.getPassword(userID);
      _school =
          (await StorageProvider.isar.users.getByUsername(userID))?.school ?? 0;
    } on PlatformException catch (_) {
      return false;
    }
    return true;
  }

  static Future<String> getSID(bool force, {StorageNotifier? notify}) async {
    assert(_username != null, "Username not set");
    assert(_password != null, "Password not set");
    assert(_school != null, "School not set");

    if ((_sid.isEmpty || force || !alive) && !alive) {
      if (notify != null) {
        StorageProvider.settings.updateLockText =
        "Starte Anmeldung beim Schulportal...";
        notify.notify("main");
      }
      http.Response loginResponse = http.Response("empty", 444);
      int retry = 0;
      logger.info("Anmelden bei Schulportal starten.");
      while (loginResponse.statusCode != 302 && retry < 5) {
        retry++;
        if (notify != null && StorageProvider.debugLog) {
          StorageProvider.settings.updateLockText =
          "Anmeldung - Versuch $retry von 5";
          notify.notify("main");
        }
        CookieStore.clearCookies();
        loginResponse = await post(
            "https://login.schulportal.hessen.de/?url=aHR0cHM6Ly9jb25uZWN0LnNjaHVscG9ydGFsLmhlc3Nlbi5kZS8%3D&skin=sp&i=$_school",
            {
              "value":
              "url=aHR0cHM6Ly9jb25uZWN0LnNjaHVscG9ydGFsLmhlc3Nlbi5kZS8%3D&timezone=1&skin=sp&user2=$_username&user=$_school.$_username&password=${Uri.encodeComponent("$_password").replaceAll("!", "%21").replaceAll(")", "%29").replaceAll("(", "%28")}"
            });
        logger.info("Versuch: $retry - StatusCode: ${loginResponse.statusCode}");
      }

      if (loginResponse.statusCode == 302 &&
          loginResponse.headers['location'] != null) {
        if (notify != null && StorageProvider.debugLog) {
          StorageProvider.settings.updateLockText =
          "Anmeldung - Passwort korrekt - Weiterleitung wird gefolgt";
          notify.notify("main");
        }
        logger.info("Anmeldung - Passwort korrekt - Weiterleitung wird gefolgt");
        http.Response sidResponse =
            await get(loginResponse.headers['location']!); //302 Redirect wird bei GET direkt gefolgt
        if (sidResponse.statusCode == 444) {
          _sid = "";
          return _sid;
        }

        if (sidResponse.body.contains("SPH-Login")) {
          _sid = CookieStore.getSID();
        }
        if (notify != null && StorageProvider.debugLog) {
          StorageProvider.settings.updateLockText =
          "Login erfolgreich - Keeping Alive";
          notify.notify("main");
        }
        alive = true;
        keepAlive();
      } else {
        _sid = "";
        throw Exception(
            "SIDERROR=Der Benutzername oder das Passwort sind falsch.");
      }
    } else {
      logger.info("Überspringe Anmelden, da keepAlive");
    }
    return _sid;
  }

  static Future<void> keepAlive() async {
    if (alive == false) {
      return;
    }
    http.Response keepAliveResponse = await post(
        "https://start.schulportal.hessen.de/ajax_login.php",
        {
          "value":
          "name=${CookieStore.getSID()}"
        });
    logger.info("Keeping Alive: ${keepAliveResponse.body}");
    if (keepAliveResponse.body == "0") {
      alive = false;
    } else {
      Future.delayed(const Duration(seconds: 30), keepAlive);
    }

  }

  //todo funktion audrufen
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
      if (response.body.contains("Wartungsarbeiten")) {
        logger.shout(
            "Das Schulportal befindet sich aktuell leider in Wartungsarbeiten. Bitte versuche es später erneut.");
        return http.Response.bytes([], 567);
      } else if ((response.body.contains("<h1>Fehler</h1>") || response.body.contains("Die Funktion ist für diesen Account nicht freigeschaltet.")) && !url.contains("meinunterricht.php")) {
        logger.severe(
            "Beim Abruf der Daten vom Schulportal ist ein Fehler aufgetreten.\n"
                "Falls dieser Fehler öfters auftreten sollte, schalte bitte den Debug-Modus ein. "
                "Dadurch wird ein ausführlicher Log generiert, welcher helfen kann, die Ursache des Fehlers zu finden und diesen zu beheben.\n"
                "Folgende Seite ist betroffen: $url",
            "ERRORTRACE${response.request?.method}METHOD.BODY${response.body}BODY.STATUSCODE${response.statusCode}STATUSCODE.HEADER${response.headers}HEADER.REASONPHRASE${response.reasonPhrase}REASONPHRASE.REDIRECT${response.isRedirect}REDIRECT.REQUESTHEADER${response.request?.headers}ERRORTRACE");
        return http.Response.bytes([], 567);
      }
    } catch (error, stackrace) {
      logger.severe(
          "Der Abruf der Daten vom Schulportal dauerte ungewöhnliche lange und wurde abgebrochen.\n"
          "Bitte überprüfe deine Internetverbindung."
          "Falls dieser Fehler öfters auftreten sollte, schalte bitte den Debug-Modus ein. "
          "Dadurch wird ein ausführlicher Log generiert, welcher helfen kann, die Ursache des Fehlers zu finden und diesen zu beheben.",
          error,
          stackrace);
      logger.warning("GET Got Catched", error, stackrace);
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
      if (response.body.contains("Wartungsarbeiten")) {
        logger.shout(
            "Das Schulportal befindet sich aktuell leider in Wartungsarbeiten. Bitte versuche es später erneut.");

        return http.Response.bytes([], 567);
      } else if (response.body.contains("<h1>Fehler</h1>") || response.body.contains("Die Funktion ist für diesen Account nicht freigeschaltet.") && !url.contains("meinunterricht.php")) {
        logger.severe(
            "Beim Abruf der Daten vom Schulportal ist ein Fehler aufgetreten.\n"
            "Falls dieser Fehler öfters auftreten sollte, schalte bitte den Debug-Modus ein. "
            "Dadurch wird ein ausführlicher Log generiert, welcher helfen kann, die Ursache des Fehlers zu finden und diesen zu beheben.\n"
            "Folgende Seite ist betroffen: $url", "METHOD${response.request?.method}METHOD.BODY${response.body}BODY.STATUSCODE${response.statusCode}STATUSCODE.HEADER${response.headers}HEADER.REASONPHRASE${response.reasonPhrase}REASONPHRASE.REDIRECT${response.isRedirect}REDIRECT.REQUEST${response.request?.headers}");
        return http.Response.bytes([], 567);
      }
    } catch (error, stackrace) {
      logger.severe(
          "Der Abruf der Daten vom Schulportal dauerte ungewöhnliche lange und wurde abgebrochen.\n"
          "Bitte überprüfe deine Internetverbindung."
          "Falls dieser Fehler öfters auftreten sollte, schalte bitte den Debug-Modus ein. "
          "Dadurch wird ein ausführlicher Log generiert, welcher helfen kann, die Ursache des Fehlers zu finden und diesen zu beheben.",
          error,
          stackrace);
      logger.warning("POST Got Catched", error, stackrace);
      return http.Response.bytes([], 444);
    }

    CookieStore.saveCookies(response);

    return response;
  }

  static String encrypt(String plaintext) {
    return aes.encrypt(plaintext, _sessionKey);
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

  static Future<void> update(StorageNotifier notify, {bool force = false}) async {
    try {
      await getSID(force, notify);
    } catch (error, stacktrace) {
      logger.severe("password", error, stacktrace);
      return;
    }
    if (force) {
      StorageProvider.isar.writeTxn(() async {
        StorageProvider.isar.lessons.clear();
        StorageProvider.isar.subjects.clear();
      });
    }
    List errors = [];
    try {
      StorageProvider.settings.updateLockText = "Aktualisiere Stundenplan...";
      notify.notify("main");
      await TimeTable.downloadTimetable();
      notify.notifyAll(["stundenplan"]);
    } catch (e, s) {
      logger.warning("Der Stundenplan konnte nicht aktualisiert werden.", e, s);
      errors.add({
        "type": "Der Stundenplan konnte nicht aktualisiert werden.",
        "error": e
      });
    }
    try {
      StorageProvider.settings.updateLockText =
          "Aktualisiere Vertretungsplan...";
      notify.notify("main");
      await Vertretungsplan.download();
      notify.notifyAll(["stundenplan", "vertretung"]);
    } catch (e, s) {
      logger.warning(
          "Der Vertretungsplan konnte nicht aktualisiert werden.", e, s);
      errors.add({
        "type": "Der Vertretungsplan konnte nicht aktualisiert werden.",
        "error": e
      });
    }

    try {
      StorageProvider.settings.updateLockText = "Aktualisiere Benutzerdaten...";
      notify.notify("main");
      await updateUser();
    } catch (e, s) {
      logger.warning(
          "Die Benutzerdaten konnten nicht aktualisiert werden.", e, s);
      errors.add({
        "type": "Die Benutzerdaten konnten nicht aktualisiert werden.",
        "error": e
      });
    }

    try {
      StorageProvider.settings.updateLockText = "Aktualisiere Hausaufgaben...";
      notify.notify("main");
      await HomeWork.downloadHomework();
      notify.notifyAll(["homework"]);
    } catch (e, s) {
      logger.warning(
          "Die Hausaufgaben konnten nicht aktualisiert werden.", e, s);
      errors.add({
        "type": "Die Hausaufgaben konnte nicht aktualisiert werden.",
        "error": e
      });
    }

    if (StorageProvider.emailChange != "") {
      await SPHSettings.checkEMail();
    }

    if (errors
        .where((element) => element["error"].toString().contains("SID"))
        .isNotEmpty) {
      logger.shout("password");
      StorageProvider.wrongPassword = true;
    }

    StorageProvider.settings.updateLockText = "";
    StorageProvider.settings.status =
        "Letztes Update: ${DateFormat('dd.MM.y HH:mm').format(DateTime.now())}";
    notify.notify("main");
  }

  static clear() {
    schools = <School>[];
    _username = null;
    _password = null;
    _sid = "";
    _sessionKey = "";
    rsa = null;
  }
}
