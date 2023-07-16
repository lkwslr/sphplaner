import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/homework.dart';
import 'package:sphplaner/helper/storage/lesson.dart';
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
  static User? user;

  static Future<void> initializeStorage() async {
    if (_isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open([
        UserSchema,
        SubjectSchema,
        TeacherSchema,
        LessonSchema,
        HomeworkSchema,
        VertretungSchema
      ], name: "sphplaner", directory: dir.path);
    }

    _prefs ??= await SharedPreferences.getInstance();
    settings.initializeSettings(_isar!, _prefs!);
  }

  static Isar get isar {
    assert(_isar != null, 'Isar has not been initialized');
    return _isar!;
  }

  static String saveCredentials(String username, String password) {
    String userID = base64Encode(utf8.encode(username));

    _secure.write(key: "${userID}_username", value: username);
    _secure.write(key: "${userID}_password", value: password);

    return userID;
  }

  static Future<void> saveUser() async {
    if (user != null) {
      await isar.writeTxn(() async {
        await isar.users.put(user!);
      });
    }
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
    user = isar.users.getByUsernameSync(userID); //TODO: web
    return userID;
  }

  static set loggedIn(String userID) {
    setSharedPrefs("loggedIn", userID);
  }

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
    return _prefs!.getStringList("vertretungsDate") ?? [" ", " "];
  }

  static set vertretungsDate(List<String> value) {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    _prefs!.setStringList("vertretungsDate", value);
  }

  static Future<void> deleteAll() async {
    await isar.writeTxn(() async {
      await isar.clear();
    });
    await isar.close();
    await _prefs!.clear();
    await _secure.deleteAll();

    _isar = null;
    _prefs = null;
    settings = SettingsProvider();
    user = null;
    SPH.clear();
    return;
  }
}
