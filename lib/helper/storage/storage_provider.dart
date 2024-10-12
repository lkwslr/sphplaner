import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sphplaner/helper/defaults.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/homework.dart';
import 'package:sphplaner/helper/storage/lehrkraft.dart';
import 'package:sphplaner/helper/storage/lerngruppe.dart';
import 'package:sphplaner/helper/storage/log.dart';
import 'package:sphplaner/helper/storage/schulstunde.dart';
import 'package:sphplaner/helper/storage/settings_provider.dart';
import 'package:sphplaner/helper/storage/vertretung.dart';

import 'leistungskontrolle.dart';

class StorageProvider {
  static Isar? _isar;
  static SharedPreferences? _prefs;
  static const FlutterSecureStorage _secure = FlutterSecureStorage();
  static SettingsProvider settings = SettingsProvider();
  static bool didAutoUpdate = false;

  static Future<void> initializeStorage() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar ??= await Isar.open([
      HomeworkSchema,
      VertretungSchema,
      LogSchema,
      LerngruppeSchema,
      LehrkraftSchema,
      LeistungskontrolleSchema,
      SchulstundeSchema
    ], name: "sphplaner", directory: dir.path);

    _prefs ??= await SharedPreferences.getInstance();
    settings.initializeSettings(_isar!, _prefs!);
    settings.updateLockText = "";
  }

  static getSharedPrefs(String key) {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    return _prefs!.getString(key) ?? "";
  }

  static setSharedPrefs(String key, String value) {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    _prefs!.setString(key, value);
  }

  static Isar get isar {
    assert(_isar != null, 'Isar has not been initialized');
    return _isar!;
  }

  static void resetSecureStorage() {
    _secure.deleteAll();
  }

  static set username(String username) {
    _secure.write(key: "username", value: username);
  }

  static Future<String> getUsername() async {
    return await _secure.read(key: "username") ?? "UNKNOWN";
  }

  static set password(String password) {
    _secure.write(key: "password", value: password);
  }

  static Future<String> getPassword() async {
    return await _secure.read(key: "password") ?? "UNKNOWN";
  }

  static set school(int school) {
    _secure.write(key: "school", value: "$school");
  }


  static Future<int> getSchool() async {
    return int.tryParse(await _secure.read(key: "school") ?? "0") ?? 0;
  }

  static String get schoolName {
    return _prefs?.getString("schoolName") ?? "Schule";
  }

  static set schoolName(String schoolName) {
    _prefs?.setString("schoolName", schoolName);
  }

  static String get firstName {
    return _prefs?.getString("firstName") ?? "Vorname";
  }

  static set firstName(String firstName) {
    _prefs?.setString("firstName", firstName);
  }

  static String get lastName {
    return _prefs?.getString("lastName") ?? "Nachname";
  }

  static set lastName(String lastName) {
    _prefs?.setString("lastName", lastName);
  }

  static String get displayName {
    return _prefs?.getString("displayName") ?? firstName;
  }

  static set displayName(String displayName) {
    _prefs?.setString("displayName", displayName);
  }

  static String get email {
    return _prefs?.getString("email") ?? "E-Mail-Adresse";
  }

  static set email(String email) {
    _prefs?.setString("email", email);
  }

  static String get birthDate {
    return _prefs?.getString("birthDate") ?? "01.01.1970";
  }

  static set birthDate(String birthDate) {
    _prefs?.setString("birthDate", birthDate);
  }

  static String get profileImage {
    return _prefs?.getString("profileImage") ?? getDefaultImage();
  }

  static set profileImage(String profileImage) {
    _prefs?.setString("profileImage", profileImage);
  }

  static String get grade {
    return _prefs?.getString("grade") ?? "00";
  }

  static set grade(String grade) {
    _prefs?.setString("grade", grade);
  }

  static String get course {
    return _prefs?.getString("course") ?? "a";
  }

  static set course(String course) {
    _prefs?.setString("course", course);
  }

  static bool get autoUpdate {
    return _prefs?.getBool("autoUpdate") ?? true;
  }

  static set autoUpdate(bool autoUpdate) {
    _prefs?.setBool("autoUpdate", autoUpdate);
  }

  static ThemeMode get theme {
    switch (_prefs?.getString("theme")) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  static set theme(ThemeMode theme) {
    switch (theme) {
      case ThemeMode.light:
        _prefs?.setString("theme", "light");
        break;
      case ThemeMode.dark:
        _prefs?.setString("theme", "dark");
        break;
      default:
        _prefs?.setString("theme", "system");
    }
  }

  static bool get debugLog {
    return _prefs?.getBool("debugLog") ?? false;
  }

  static set debugLog(bool debugLog) {
    _prefs!.setBool("debugLog", debugLog);
  }

  static bool get advancedDisabled {
    return _prefs?.getBool("advancedDisabled") ?? true;
  }

  static set advancedDisabled(bool advancedDisabled) {
    _prefs!.setBool("advancedDisabled", advancedDisabled);
  }

  static bool get loggedIn {
    try {
      return _prefs?.getBool("loggedIn") ?? false;
    } catch (error) {
      _prefs?.remove("loggedIn");
      _prefs?.setBool("loggedIn", true);
      return true;
    }
  }

  static set loggedIn(bool value) {
    _prefs?.setBool("loggedIn", value);
  }

  static bool get showHomeworkInfo {
    return _prefs?.getBool("showHomeworkInfo") ?? false;
  }

  static set showHomeworkInfo(bool showHomeworkInfo) {
    _prefs?.setBool("showHomeworkInfo", showHomeworkInfo);
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
    _prefs!.setStringList("timelist", value);
  }

  static List<String> get vertretungsDate {
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
    SPH.clear();
    return;
  }
}
