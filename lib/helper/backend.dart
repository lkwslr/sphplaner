import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sphplaner/helper/sph.dart';
import 'package:path_provider/path_provider.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'defaults.dart';

class Backend extends PropertyChangeNotifier<String> {
  late SharedPreferences _prefs;
  final FlutterSecureStorage _secure = const FlutterSecureStorage();
  late Directory _dir;
  bool init = false;
  bool _sphLogin = false;
  String userDir = "";

  String _status = "Aktualisiere Vertretung...";
  Map _stundenplan = getDefaultTable();
  late Map _stundenplanVertr;
  Map _vertretungsplan = getDefaultVertretung();
  bool _updateLock = false;
  late SPH sph;

  bool get sphLogin => _sphLogin;

  bool get hideToday => _prefs.getBool("hideToday") ?? true;

  String get schoolId => _prefs.getString("schoolId") ?? "";

  set hideToday(bool value) {
    _prefs.setBool("hideToday", value);
    notifyListeners("planerView");
  }

  set sphLogin(bool value) {
    _sphLogin = value;
    notifyListeners('online');
  }

  set schoolId(String value) {
    _prefs.setString("schoolId", value);
  }

  Future<void> initBackend() async {
    _prefs = await SharedPreferences.getInstance();
    _dir = await getApplicationDocumentsDirectory();
  }

  Future<void> initApp() async {
    sph = SPH(await username, await password, schoolId);
    status = "Letztes Update: $lastUpdate";
    userDir =
        "${_dir.path}/KRSApp/${base64.encode(utf8.encode(await username))}";
    _vertretungsplan =
        jsonDecode(File("$userDir/vertretungsplan.json").readAsStringSync());
    _stundenplan =
        jsonDecode(File("$userDir/stundenplan.json").readAsStringSync());
    _stundenplanVertr = jsonDecode(jsonEncode(_stundenplan));
    _buildStundenplan();
    notifyListeners('init');
  }

  Future<String> initSPH() async {
    updateLock = true;
    status = "Anmeldung beim SPH...";
    String login = await sph.login();

    if (login == "Wrong password") {
      isLoggedIn = false;
    } else if (login != "") {
      sphLogin = false;
      return login;
    }

    Timer.periodic(const Duration(minutes: 5), (timer) async {
      String login = await sph.login();
      if (login != "") {
        sphLogin = false;
      }
    });

    sphLogin = true;
    status = "Letztes Update: $lastUpdate";
    updateLock = false;
    notifyListeners("online");
    return "";
  }

  Future<void> initUser() async {
    userDir =
        "${_dir.path}/KRSApp/${base64.encode(utf8.encode(await username))}";
    await Directory(userDir).create(recursive: true);
    _stundenplan = getDefaultTable();
    File("$userDir/stundenplan.json")
        .writeAsStringSync(jsonEncode(_stundenplan));
    _vertretungsplan = getDefaultVertretung();
    File("$userDir/vertretungsplan.json")
        .writeAsStringSync(jsonEncode(_vertretungsplan));
  }

  Future<void> deleteUser() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();

    for (String key in _prefs.getKeys()) {
      _prefs.remove(key);
    }

    secureStorage.deleteAll();

    Directory(userDir).deleteSync(recursive: true);

    _status = "Aktualisiere Vertretung...";
    userDir = "";

    _stundenplan = {};
    _stundenplanVertr = {};
    _vertretungsplan = {};
    _updateLock = false;
    name = "";
  }

  bool get isLoggedIn => _prefs.getBool("loggedIn") ?? false;

  set isLoggedIn(bool value) {
    _prefs.setBool('loggedIn', true);
    notifyListeners('loggedIn');
  }

  set login(Map value) {
    for (String key in value.keys) {
      _secure.write(key: key, value: value[key]);
    }
  }

  Future<String> get username async {
    return await _secure.read(key: 'username') ?? "";
  }

  Future<String> get password async {
    return await _secure.read(key: 'password') ?? "";
  }

  Future<void> updateData({bool force = false}) async {
    updateLock = true;
    List errors = [];
    bool benutzerResult;
    try {
      benutzerResult = await updateUser(force: force);
    } catch (_) {
      benutzerResult = false;
    }
    if (!benutzerResult) {
      errors.add("Benutzer-Update fehlgeschlagen!");
    }

    bool vertretungResult;
    try {
      vertretungResult = await updateVertretungsplan(force: force);
    } catch (_) {
      vertretungResult = false;
    }
    if (!vertretungResult) {
      errors.add("Vertretungsplan-Update fehlgeschlagen!");
    }
    bool stundenplanResult;
    try {
      stundenplanResult = await updateStundenplan(force: force);
    } catch (_) {
      stundenplanResult = false;
    }
    if (!stundenplanResult) {
      errors.add("Stundenplan-Update fehlgeschlagen!");
    }

    if (errors.isEmpty) {
      lastUpdate = DateFormat('dd.MM.y HH:mm').format(DateTime.now());
    }

    String emailResult;
    emailResult = await checkEMail();
    try {
      emailResult = await checkEMail();
    } catch (_) {
      emailResult = "E-Mail-Verifikationsprüfung fehlgeschlagen!";
    }
    if (emailResult != "") {
      errors.add(emailResult);
    }

    updateLock = false;

    for (String error in errors) {
      if (!updateLock) {
        if (error.contains("E-Mail")) {
          status = error;
          await Future.delayed(const Duration(seconds: 5));
        } else {
          status = error;
          await Future.delayed(const Duration(seconds: 2));
        }
      }
    }
    if (!updateLock) {
      status = "Letztes Update: $lastUpdate";
    }
  }

  Future<bool> updateUser({bool force = false}) async {
    if (force ||
        DateTime.now().millisecondsSinceEpoch >= lastUserUpdate + 604800000) {
      status = "Aktualisiere Benutzerdaten...";

      http.Response benutzerInfo =
          await sph.get("/benutzerverwaltung.php?a=userData");
      dom.Document page = parse(benutzerInfo.body);

      name =
          "${page.getElementsByTagName('table')[0].getElementsByTagName('td')[5].text} ${page.getElementsByTagName('table')[0].getElementsByTagName('td')[3].text}";

      if (userNames.isEmpty) {
        Map userNames = {};
        for (String singleName in name.split(" ")) {
          userNames[singleName] = false;
        }
        userNames[name.split(" ")[0]] = true;
        this.userNames = userNames;
      }

      geburtsdatum = page
          .getElementsByTagName('table')[0]
          .getElementsByTagName('td')[7]
          .text;
      klasse = page
          .getElementsByTagName('table')[0]
          .getElementsByTagName('td')[11]
          .text;
      stufe = page
          .getElementsByTagName('table')[0]
          .getElementsByTagName('td')[9]
          .text;

      http.Response benutzerMail =
          await sph.get("/benutzerverwaltung.php?a=userMail");

      dom.Document mailPage = parse(benutzerMail.body);

      email = mailPage.getElementById('mail')!.attributes['value'] ??
          "Keine E-Mail-Adresse angegeben";

      http.Response userImage =
          await sph.get("/benutzerverwaltung.php?a=userFoto&b=show");

      final file = File('$userDir/image.png');
      file.writeAsBytesSync(userImage.bodyBytes);
      pictureChange = DateTime.now().add(const Duration(days: 10)).millisecondsSinceEpoch;
      lastUserUpdate = DateTime.now().millisecondsSinceEpoch;
    } else if (DateTime.now().millisecondsSinceEpoch >= pictureChange + 900000) {
      http.Response userImage =
      await sph.get("/benutzerverwaltung.php?a=userFoto&b=show");

      final file = File('$userDir/image.png');
      file.writeAsBytesSync(userImage.bodyBytes);
      pictureChange = DateTime.now().add(const Duration(days: 10)).millisecondsSinceEpoch;
    }
    return true;
  }

  Future<bool> updateVertretungsplan({bool force = false}) async {
    status = "Aktualisiere Vertretung...";

    Map newVertretung = getDefaultVertretung();

    http.Response vertretungsplanResponse = await sph.get("/vertretungsplan.php");

    if (vertretungsplanResponse.statusCode == 419) {
      return false;
    }

    List<dom.Element> panels = parse(vertretungsplanResponse.body).getElementsByClassName("panel");

    for (int i=1;i<=2;i++) {
      dom.Element panel = panels[i];
      String heading = panel.getElementsByClassName("panel-heading")[0].text.trim();
      newVertretung[i==1 ? "heute" : "morgen"]["day"] = heading.split(",")[0];
      newVertretung[i==1 ? "heute" : "morgen"]["date"] = heading.split(" ")[2];
      List vertretungen =  [];

      for (dom.Element tr in panel.getElementsByTagName("tbody")[0].getElementsByTagName("tr")) {
        List<dom.Element> td = tr.getElementsByTagName("td");
        if (td.length != 1 && !td[0].text.startsWith("Keine Einträge!")) {
          String fach = td[3].text.trim();
          String raum = td[4].text.trim();
          String art = "";
          String information = td[5].text.trim();
          String fachAlt = "";
          if (td[5].text.trim() == "fällt aus") {
            fachAlt = fach;
            fach = "---";
            raum = "---";
            art = "Entfall";
            information = "";
          }

          if (raum.trim() == "") {
            raum = "---";
          }


          Map vertretung = {
            "klasse": klasse,
            "stunde": td[1].text.trim(),
            "fach": fach,
            "raum": raum,
            "art": art,
            "informationen": information,
            "altesFach": fachAlt
          };
          vertretungen.add(vertretung);
        }

      }
      newVertretung[i==1 ? "heute" : "morgen"]['vertretung'] = vertretungen;
    }



    newVertretung['last'] =
    "${DateFormat("dd.MM.yy").format(DateTime.now())} ${DateFormat("HH:mm").format(DateTime.now())}";
    _vertretungsplan = newVertretung;
    _buildStundenplan();
    File("$userDir/vertretungsplan.json")
        .writeAsStringSync(jsonEncode(newVertretung));
    notifyListeners("vertretungsplan");
    return true;
  }

  Future<bool> updateStundenplan({force = false}) async {
    if (DateTime.now().millisecondsSinceEpoch >=
            lastStundenplanUpdate + 604800000 ||
        force) {
      try {
        status = "Aktualisiere Stundenplan...";

        Map newtable = getDefaultTable();

        http.Response stundenplanResponse = await sph.get("/stundenplan.php");

        if (stundenplanResponse.statusCode == 419) {
          return false;
        }

        List days = ["montag", "dienstag", "mittwoch", "donnerstag", "freitag"];
        dom.Element own = parse(stundenplanResponse.body)
            .getElementById("own")!
            .getElementsByTagName("tbody")[0];

        List<dom.Element> rows = own.getElementsByTagName("tr");

        for (int i = 0; i < rows.length; i++) {
          List<dom.Element> columns = rows[i].getElementsByTagName("td");
          for (int j = 1; j < columns.length; j++) {
            dom.Element cell = columns[j];
            if (cell.getElementsByTagName("div").isNotEmpty) {
              int rowspan = int.parse(cell.attributes['rowspan']!) - 1;
              dom.Element stunde = cell.getElementsByTagName("div")[0];
              for (int k = 0; k <= rowspan; k++) {
                String fach = stunde.getElementsByTagName("b")[0].text.trim();
                String lehrkraft =
                stunde.getElementsByTagName("small")[0].text.trim();
                newtable[days[j - 1]]['${i + k + 1}']["R"] =
                    stunde.text.split(fach)[1].split(lehrkraft)[0].trim();
                if (fach.startsWith("Q")) {
                  fach.substring(2);
                  fach =
                  "${fach.substring(0, fach.length - 3)}-${fach.substring(fach.length - 2)}${int.parse(fach.substring(fach.length - 2))}";
                }

                newtable[days[j - 1]]['${i + k + 1}']["F"] = fach;

                newtable[days[j - 1]]['${i + k + 1}']["L"] = lehrkraft;
              }
            }
          }
        }
        stundenplan = newtable;
        lastStundenplanUpdate = DateTime.now().millisecondsSinceEpoch;
      } catch (error) {
        if (error == RangeError) {
          return true;
        }
      }
    }
    return true;
  }

  Future<bool> deleteEMail() async {
    http.Response response;
    try {
      response = await sph.post("/benutzerverwaltung.php",
          {'a': "userMail", 'pw': sph.encrypt(await password), 'del': "ja"});
    } catch (_) {
      return false;
    }

    if (response.body == "1") {
      email = "Keine E-Mail-Adresse angegeben";
      return true;
    }

    return false;
  }

  Future<bool> changeEMail(String email) async {
    http.Response benutzerMail =
        await sph.get("/benutzerverwaltung.php?a=userMail");

    dom.Document mailPage = parse(benutzerMail.body);
    String ikey = mailPage
            .getElementById('mailchange')
            ?.getElementsByTagName('input')[0]
            .attributes['value'] ??
        "";

    Map data = {'ikey': ikey, 'mail': email, 'pw': await password};
    http.Response response =
        await sph.post("/benutzerverwaltung.php?a=userMail", data);
    if (response.body.contains(
        "An Ihre E-Mail-Adresse wurde ein Bestätigungscode versandt.")) {
      emailChange = true;
      return true;
    }
    return false;
  }

  Future<void> requestEMailLink() async {
    await sph.post("/benutzerverwaltung.php", {
      'a': "userMail",
      'pw': sph.encrypt(await password),
      'neubest': 'ja',
      'mail': email
    });
  }

  Future<String> checkEMail() async {
    if (emailChange) {
      http.Response benutzerMail =
          await sph.get("/benutzerverwaltung.php?a=userMail");

      dom.Document mailPage = parse(benutzerMail.body);

      dom.Element? mailinfo = mailPage.getElementById("mailinfo");
      if (mailinfo != null) {
        String classes =
            mailinfo.getElementsByTagName("span")[0].attributes['class']!;
        if (classes.contains("label-success")) {
          email = mailinfo.getElementsByTagName("input")[0].attributes['value']!;
          emailChange = false;
          return "";
        } else if (classes.contains("label-warning")) {
          String verifyPending = mailinfo.getElementsByTagName("span")[0].text;
          String pendingTime = verifyPending
              .split("E-Mail-Adresse noch nicht bestätigt. Sie haben noch ")[1]
              .split(" ")[0];

          return "Neue E-Mail-Adresse innnerhalb von $pendingTime Minuten bestätigen!";
        } else if (classes.contains("label-danger")) {
          return "E-Mail-Verifikationslink abgelaufen. Bitte erneut anfordern!";
        }
      }

      return "E-Mail-Verifikationsprüfung fehlgeschlagen!";
    }
    return "";
  }

  Future<bool> changePassword(String newPassword) async {
    Map data = {
      'ikey': sph.ikey,
      'isPupil': "1",
      'stufe': stufe,
      'inst': schoolId,
      'success': 'false',
      'passwortSicher': 'ja',
      'passwortWiederholung': 'ja',
      'ownpw': sph.encrypt(await password),
      'pw': sph.encrypt(newPassword),
      'pw2': sph.encrypt(newPassword),
      'save': ""
    };

    http.Response response =
        await sph.post("/benutzerverwaltung.php?a=userChangePassword", data);
    if (response.body.contains("Das Passwort wurde erfolgreich geändert!")) {
      login = {'password': newPassword};
      return true;
    }
    return false;
  }

  Future<bool> changeImage(String path) async {
    Uint8List bytes = await File(path).readAsBytes();
    String imageAsString = "data:image/png;base64,${base64.encode(bytes)}";

    Map data = {
      "a": "userFoto",
      "b": "newData",
      "data": imageAsString,
      "pw": sph.encrypt(await password)
    };
    http.Response response;

    try {
      response = await sph.post("/benutzerverwaltung.php", data);
    } catch (_) {
      return false;
    }

    if (!response.body.startsWith("-")) {
      final file = File('$userDir/image.png');
      file.writeAsBytesSync(File(path).readAsBytesSync());
      notifyListeners('image');
      return true;
    }
    return false;
  }

  Future<bool> deleteImage() async {
    Map data = {
      "a": "userFoto",
      "b": "delete",
      "pw": sph.encrypt(await password)
    };

    http.Response response = await sph.post("/benutzerverwaltung.php", data);

    if (!response.body.startsWith("-")) {
      ByteData defaultImage = await rootBundle.load("assets/default.png");

      final file = File('$userDir/image.png');
      file.writeAsBytesSync(defaultImage.buffer.asUint64List());
      file.writeAsBytesSync(defaultImage.buffer
          .asUint8List(defaultImage.offsetInBytes, defaultImage.lengthInBytes));
      notifyListeners('image');
      return true;
    }
    return false;
  }

  String get email =>
      _prefs.getString("email") ?? "Keine E-Mail-Adresse angegeben";

  set email(String value) {
    _prefs.setString("email", value);
  }

  bool get emailChange => _prefs.getBool("emailChange") ?? false;

  set emailChange(bool value) {
    _prefs.setBool('emailChange', value);
  }

  int get pictureChange => _prefs.getInt("pictureChange") ?? 999999999999999;

  set pictureChange(int value) {
    _prefs.setInt('pictureChange', value);
  }

  String get stufe => _prefs.getString("stufe") ?? "";

  set stufe(String value) {
    _prefs.setString("stufe", value);
  }

  String get status => _status;

  set status(String value) {
    if (value.startsWith("ERROR")) {
      _status = value.split("=")[1];
      notifyListeners('status');
       Future.delayed(const Duration(seconds: 3)).then((value) {
        _status = "Letztes Update: $lastUpdate";
        notifyListeners('status');
      });
    } else {
      _status = value;
      notifyListeners('status');
    }
  }

  bool get updateLock {
    return _updateLock;
  }

  set updateLock(bool value) {
    _updateLock = value;
    notifyListeners('updateLock');
  }

  bool get autoUpdate => _prefs.getBool("autoUpdate") ?? true;

  set autoUpdate(bool value) {
    _prefs.setBool("autoUpdate", value);
    notifyListeners("settings");
  }

  String get name => _prefs.getString('name') ?? "";

  set name(String value) {
    _prefs.setString('name', value);
  }

  int get lastUserUpdate => _prefs.getInt('lastUserUpdate') ?? 0;

  set lastUserUpdate(int value) {
    _prefs.setInt('lastUserUpdate', value);
  }

  int get lastStundenplanUpdate => _prefs.getInt('lastStundenplanUpdate') ?? 0;

  set lastStundenplanUpdate(int value) {
    _prefs.setInt("lastStundenplanUpdate", value);
  }

  Map get userNames => jsonDecode(_prefs.getString('userNames') ?? "{}");

  set userNames(Map value) {
    _prefs.setString("userNames", jsonEncode(value));
    notifyListeners('userNames');
  }

  String get geburtsdatum => _prefs.getString('geburtsdatum') ?? "";

  set geburtsdatum(String value) {
    _prefs.setString('geburtsdatum', value);
  }

  String get klasse => _prefs.getString("klasse") ?? "";

  set klasse(String value) {
    _prefs.setString('klasse', value);
    notifyListeners('klasse');
  }

  bool get backgroundUpdate => _prefs.getBool("backgroundUpdate") ?? true;

  set backgroundUpdate(bool value) {
    _prefs.setBool("backgroundUpdate", value);
  }

  Directory get dir => _dir;

  String get viewMode => _prefs.getString("viewMode") ?? "plan";

  String get title {
    if (!isLoggedIn) {
      return "SPH Planer";
    }
    switch (viewMode) {
      case "plan":
        return "Stundenplan";
      case "web":
        return "Webseite";
      case "hausaufgaben":
        return "Hausaufgaben";
      case "vertretung":
        return "Vertretungsplan";
      default:
        return "SPH Planer";
    }
  }

  set viewMode(String value) {
    _prefs.setString("viewMode", value);

    notifyListeners("viewMode");
  }

  Map get colors {
    return jsonDecode(_prefs.getString("colors") ?? getDefaultColors());
  }

  set colors(Map value) {
    _prefs.setString("colors", jsonEncode(value));
    notifyListeners("colors");
  }

  String get planerView => _prefs.getString("planerView") ?? "woche";

  set planerView(String view) {
    _prefs.setString("planerView", view);
    notifyListeners("planerView");
  }

  ThemeMode get themeMode {
    switch (_prefs.getString("theme")) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
    }
    return ThemeMode.system;
  }

  set themeModeByString(String mode) {
    _prefs.setString("theme", mode);
    notifyListeners("themeMode");
  }

  String get themeModeByString => _prefs.getString("theme") ?? "system";

  bool get materialYou => _prefs.getBool("m3") ?? false;

  set materialYou(bool value) {
    _prefs.setBool("m3", value);
    notifyListeners("themeMode");
  }

  String get lastUpdate => _prefs.getString("lastUpdate") ?? "0";

  set lastUpdate(String update) {
    _prefs.setString("lastUpdate", update);
  }

  List<String> get faecher => _prefs.getStringList("faecher") ?? [];

  Map get stundenplan => _stundenplan;

  set stundenplan(Map plan) {
    _stundenplan = plan;
    _stundenplanVertr = jsonDecode(jsonEncode(plan));
    _generateFaecher();
    _buildStundenplan();
    File("$userDir/stundenplan.json").writeAsStringSync(jsonEncode(plan));
    notifyListeners("stundenplan");
  }

  Map get stundenplanVertr => _stundenplanVertr;

  Map get vertretungsplan => _vertretungsplan;

  void _buildStundenplan() {
    _stundenplanVertr = jsonDecode(jsonEncode(_stundenplan));
    Map meineVertretung = {};

    for (String day in ['heute', 'morgen']) {
      meineVertretung[day] = {
        "day": _vertretungsplan[day]['day'],
        "date": _vertretungsplan[day]['date'],
        "vertretung": []
      };
      String customKlasse = klasse;
      if (customKlasse.startsWith("Q")) {
        customKlasse[1] == '1' || customKlasse[1] == '2'
            ? customKlasse = "Q12"
            : customKlasse = "Q34";
      }
      for (Map vertretungs in _vertretungsplan[day]['vertretung']) {
        bool correctClass = false;
        for (int char = 0; char < customKlasse.length; char++) {
          String vertretungKlasse = vertretungs['klasse'];
          if (vertretungKlasse.contains(customKlasse[char])) {
            correctClass = true;
          } else {
            correctClass = false;
            break;
          }
        }

        if (correctClass) {
          List stunden = vertretungs['stunde'].toString().split("-");
          for (int stunde = int.parse(stunden[0]);
              stunde <= int.parse(stunden[stunden.length - 1]);
              stunde++) {
            String altesFach =
                vertretungs['altesFach'].toString().toUpperCase();
            String fachNormal = vertretungs['fach'].toString().toUpperCase();

            if ((faecher.contains(altesFach) ||
                    faecher.contains(fachNormal)) &&
                ((_stundenplan[meineVertretung[day]['day'].toLowerCase()]
                                ['$stunde']["F"] ==
                            fachNormal ||
                        _stundenplan[meineVertretung[day]['day'].toLowerCase()]
                                ['$stunde']["F"] ==
                            altesFach) ||
                    vertretungs['art'].toString().contains("Sondereins"))) {
              if (!_stundenplanVertr[meineVertretung[day]['day'].toLowerCase()]
                      ['$stunde']["A"]
                  .toString()
                  .contains("Sondereins")) {
                _stundenplanVertr[meineVertretung[day]['day'].toLowerCase()]
                    ['$stunde']["R"] = vertretungs['raum'];
                _stundenplanVertr[meineVertretung[day]['day'].toLowerCase()]
                    ['$stunde']["F"] = vertretungs['fach'];
                _stundenplanVertr[meineVertretung[day]['day'].toLowerCase()]
                    ['$stunde']["I"] = vertretungs['informationen'];
                _stundenplanVertr[meineVertretung[day]['day'].toLowerCase()]
                    ['$stunde']["A"] = vertretungs['art'];
              }
            }
          }
        }
      }
      RegExp reg = RegExp(
        r"Unterrichtsfrei.*(\d+)-(\d+).*",
        caseSensitive: false,
        multiLine: false,
      );
      RegExpMatch? match = reg.firstMatch(_vertretungsplan[day]['information']);

      if (match != null) {
        int first = int.parse(match.group(1) ?? "0");
        int last = int.parse(match.group(2) ?? "0");

        for (int stunde = first; stunde <= last; stunde++) {
          if (_stundenplan[meineVertretung[day]['day'].toLowerCase()]['$stunde']
                  ['F'] !=
              "") {
            _stundenplanVertr[meineVertretung[day]['day'].toLowerCase()]
                ['$stunde']['F'] = "---";
            _stundenplanVertr[meineVertretung[day]['day'].toLowerCase()]
                ['$stunde']['R'] = "---";
            _stundenplanVertr[meineVertretung[day]['day'].toLowerCase()]
                ['$stunde']['L'] = "---";
          }
        }
      }
    }
  }

  void _generateFaecher() {
    List<String> faecher = [];
    for (String day in _stundenplan.keys) {
      for (String stunde in _stundenplan[day].keys) {
        String fach = _stundenplan[day][stunde]["F"];

        if (!faecher.contains(fach) && fach != "") {
          faecher.add(fach);
        }
      }
    }
    faecher.sort();
    _prefs.setStringList("faecher", faecher);
  }

  List get homework => _prefs.getStringList("homework") ?? [];

  Future<void> saveHomework(Map ha) async {
    List<String> homework = _prefs.getStringList("homework") ?? [];
    homework.add(json.encode(ha));

    homework.sort((a, b) {
      Map haA = json.decode(a);
      Map haB = json.decode(b);

      return haA["due"] - haB["due"];
    });

    _prefs.setStringList("homework", homework);
    notifyListeners("homework");
  }

  Future<void> removeHomework(int index) async {
    List<String> homework = _prefs.getStringList("homework") ?? [];
    if (homework.isNotEmpty && homework.length > index) {
      homework.removeAt(index);
    }
    _prefs.setStringList("homework", homework);
  }
}