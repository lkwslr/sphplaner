import 'package:isar/isar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sphplaner/helper/app_info.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';

// Für runtime-Einstellungen
class SettingsProvider {
  Isar? _isar;
  SharedPreferences? _prefs;
  String viewMode = "stundenplan";

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
    switch (viewMode) {
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

  bool get updateLock => (_getSharedPrefs("updateLock") ?? "") != "";

  set updateLockText(String value) => _setSharedPrefs("updateLock", value);

  String get updateLockText => _getSharedPrefs("updateLock") ?? "";

  bool get update {
    return (_prefs?.getInt("version") ?? -1) <
        (int.tryParse(buildNumber ?? "") ?? 0);
  }

  set update(bool value) {
    _prefs?.setInt("version", int.tryParse(buildNumber ?? "") ?? 0);
  }

  bool get showVertretung => _prefs?.getBool("showVertretung") ?? true;

  set showVertretung(bool value) => _prefs?.setBool("showVertretung", value);

  bool get loadAllVertretung => _prefs?.getBool("loadAllVertretung") ?? false;

  set loadAllVertretung(bool value) =>
      _prefs?.setBool("loadAllVertretung", value);

  bool get logging => _prefs?.getBool("logging") ?? true;

  set logging(bool value) => _prefs?.setBool("logging", value);
}
