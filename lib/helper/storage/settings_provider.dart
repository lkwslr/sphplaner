import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sphplaner/helper/storage/user.dart';

// Für runtime Einstellungen
class SettingsProvider {
  Isar? _isar;
  SharedPreferences? _prefs;

  initializeSettings(Isar isar, SharedPreferences prefs) {
    _isar ??= isar;
    _prefs ??= prefs;
  }

  _getSharedPrefs(String key) {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    return _prefs!.getString(key);
  }

  _setSharedPrefs(String key, String value) {
    assert(_prefs != null, 'SharedPreferences have not been initialized');
    _prefs!.setString(key, value);
  }

  get loggedIn {
    return _isar?.users.get(1) != null;
  }

  //TODO: alle themes müssen zu storage_provider und nicht in settings_provider

  get theme {
    switch (_getSharedPrefs("theme")) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String get themeByString {
    return _getSharedPrefs("theme") ?? "system";
  }

  set themeByString(String value) => _setSharedPrefs("theme", value);

  String get status {
    return _getSharedPrefs("status") ?? "";
  }

  set status(String value) {
    _setSharedPrefs("status", value);
  }

  set lastUpdate(String value) {
    _setSharedPrefs("lastUpdate", value);
    _setSharedPrefs("status", "Letztes Update: $value");
  }

  String get title {
    switch (_getSharedPrefs("viewMode") ?? "") {
      case "vertretung":
        return "Vertretung";
      case "stundenplan":
        return "Stundenplan";
      case "hausaufgaben":
        return "Hausaufgaben";
      default:
        return "SPH Planer";
    }
  }

  set title(String value) => _setSharedPrefs("title", value);

  String get viewMode => _getSharedPrefs("viewMode") ?? "";

  set viewMode(String value) => _setSharedPrefs("viewMode", value);

  bool get updateLock => _getSharedPrefs("updateLock") ?? "" != "";

  set updateLockText(String value) => _setSharedPrefs("updateLock", value);

  String get updateLockText => _getSharedPrefs("updateLock") ?? "";
}
