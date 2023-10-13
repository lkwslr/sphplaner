import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/homework.dart';
import 'package:sphplaner/helper/storage/lesson.dart';
import 'package:sphplaner/helper/storage/log.dart';
import 'package:sphplaner/helper/storage/settings_provider.dart';
import 'package:sphplaner/helper/storage/subject.dart';
import 'package:sphplaner/helper/storage/teacher.dart';
import 'package:sphplaner/helper/storage/user.dart';
import 'package:sphplaner/helper/storage/vertretung.dart';

class StorageProvider {
  static Isar? _isar;
  static SharedPreferences? _prefs;
  static const FlutterSecureStorage _secure = FlutterSecureStorage();
  static SettingsProvider settings = SettingsProvider();
  static User? _user;

  static Future<void> initializeStorage() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar ??= await Isar.open([
      UserSchema,
      SubjectSchema,
      TeacherSchema,
      LessonSchema,
      HomeworkSchema,
      VertretungSchema,
      LogSchema
    ], name: "sphplaner", directory: dir.path);

    _prefs ??= await SharedPreferences.getInstance();
    settings.initializeSettings(_isar!, _prefs!);
    settings.updateLockText = "";
  }

  static Isar get isar {
    assert(_isar != null, 'Isar has not been initialized');
    return _isar!;
  }

  static User get user {
    _user ??= isar.users.getByUsernameSync(getSharedPrefs("loggedIn"));
    return _user ?? User();
  }

  static String saveCredentials(String username, String password) {
    String userID = base64Encode(utf8.encode(username));

    _secure.write(key: "${userID}_username", value: username);
    _secure.write(key: "${userID}_password", value: password);

    return userID;
  }

  static savePassword(String userID, String password) {
    _secure.write(key: "${userID}_password", value: password);
    SPH.setCredetialsFor(userID);
  }

  static Future<void> saveUser() async {
    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
  }

  static Future<String> getUsername(String userID) async {
    return await _secure.read(key: "${userID}_username") ?? "";
  }

  static Future<String> getPassword(String userID) async {
    return await _secure.read(key: "${userID}_password") ?? "";
  }

  static getSharedPrefs(String key) {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    return _prefs!.getString(key) ?? "";
  }

  static setSharedPrefs(String key, String value) {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    _prefs!.setString(key, value);
  }

  static String get loggedIn {
    String userID = getSharedPrefs("loggedIn");
    _user = isar.users.getByUsernameSync(userID); //TODO: web
    return userID;
  }

  static set loggedIn(String userID) {
    setSharedPrefs("loggedIn", userID);
  }

  static bool wrongPassword = false;
  static bool dialog = false;
  static String emailCheck = "";

  static String get status {
    return getSharedPrefs("status");
  }

  static set status(String value) {
    setSharedPrefs("status", value);
  }

  static set lastUpdate(String value) {
    setSharedPrefs("lastUpdate", value);
    setSharedPrefs("status", "Letztes Update: $value");
  }

  static List<String> get timelist {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    return _prefs!.getStringList("timelist") ??
        [" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " "];
  }

  static set timelist(List<String> value) {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    _prefs!.setStringList("timelist", value);
  }

  static List<String> get vertretungsDate {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    List<String> dates = _prefs!.getStringList("vertretungsDate") ?? [];
    for (int i = dates.length; i < 2; i++) {
      dates.add(" ");
    }
    return dates;
  }

  static set vertretungsDate(List<String> value) {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    _prefs!.setStringList("vertretungsDate", value);
  }

  static String get emailChange {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    return _prefs!.getString("emailChange") ?? "";
  }

  static set emailChange(String value) {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    _prefs!.setString("emailChange", value);
  }

  static Future<void> deleteAll() async {
    await isar.writeTxn(() async {
      await isar.clear();
    });
    if (isar.isOpen) {
      await isar.close();
    }

    await _prefs!.clear();
    await _secure.deleteAll();

    _isar = null;
    _prefs = null;
    settings = SettingsProvider();
    _user = null;
    SPH.clear();
    return;
  }
}
