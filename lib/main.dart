//TODO: Funktionen für passwort change etc müssen check haben, dass SID da ist und ggf sessionKey. Siehe bei updateUser

//TODO: Login flow, bei dem Stundenplan geladen wird. Danach hat man die Option Fächer und Kurse auszuwählen, wenn es mehr als eine Option gibt.

//TODO: während/nach fach auswahl option, um die Farben der einzelnen Fächer anzupassen

//TODO: wenn stundenplan geupdatet wird überprüfen, ob die fächer immer noch die gleichen sind, wenn sich fächer im Stundenplan geändert haben erneut Bildschim vom Login-Flow anzeigen

//TODO: user update, checked nach email change

//TODO: settings (email, password, photo)

//TODO: Notifier-Options
/*
      theme -> läd ab Beginn neu, da design änderung
      main -> läd Ansicht neu, z.B. appbar, status oder offener Tab
      settings -> läd Settings neu
      homework -> läd Homework neu
     */

import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/intl.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/app_info.dart' as app_info;
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/helper/drawer.dart';
import 'package:sphplaner/helper/theme.dart';
import 'package:sphplaner/routes/hausaufgaben.dart';
import 'package:sphplaner/routes/settings.dart';
import 'package:sphplaner/routes/stundenplan.dart';
import 'package:sphplaner/routes/vertretungsviewer.dart';
import 'package:sphplaner/routes/welcome/welcome.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initializeDateFormatting();
  Intl.defaultLocale = "de_DE";
  app_info.init();

  runApp(PropertyChangeProvider<StorageNotifier, String>(
      value: StorageNotifier(), child: const SPHPlaner()));
}

class SPHPlaner extends StatefulWidget {
  const SPHPlaner({super.key});

  @override
  State<SPHPlaner> createState() => _SPHPlaner();
}

class _SPHPlaner extends State<SPHPlaner> {
  bool loaded = false;
  ValueNotifier<bool> loading = ValueNotifier(false);
  String result = "Klicken, um in den Online-Modus zu wechseln";

  @override
  void initState() {
    super.initState();
    StorageProvider.initializeStorage().then((value) {
      if (StorageProvider.settings.update) {
        StorageProvider.deleteAll().then((value) {
          StorageProvider.initializeStorage().then((value) => StorageProvider.settings.update = true);
        });
      }
      if (StorageProvider.settings.loggedIn) {
        SPH.setCredetialsFor(StorageProvider.loggedIn).then((value) {
          StorageProvider.settings.updateLockText = "";
          FlutterNativeSplash.remove();
        });
      }
      setState(() {
        loaded = true;
      });
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return OrientationBuilder(builder: (context, _) {
      return PropertyChangeConsumer<StorageNotifier, String>(
        properties: const ['theme'],
        builder: (context, notify, child) {
          /*bool autoUpdate = StorageProvider.user?.autoUpdate ?? true;
        if (autoUpdate) {
          SPH.update(notify!);
        }*/

          return DynamicColorBuilder(
              builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            ColorScheme lightColorScheme;
            ColorScheme darkColorScheme;

            if (lightDynamic != null && darkDynamic != null) {
              lightColorScheme = lightDynamic.harmonized();

              darkColorScheme = darkDynamic.harmonized();
              lightColorScheme = lightColorScheme.copyWith(
                primary: sphBlue,
                onPrimary: const Color(0xffdde3ee),
                primaryContainer: sphBlue,
              );
              darkColorScheme = darkColorScheme.copyWith(
                primary: sphBlue,
                onPrimary: const Color(0xffdde3ee),
                primaryContainer: sphBlue,
              );
            } else {
              lightColorScheme = defaultLightColorScheme;
              darkColorScheme = defaultDarkColorScheme;
            }

            InputDecorationTheme customLightInputTheme = InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: lightColorScheme.outline),
                    borderRadius: BorderRadius.circular(4)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: lightColorScheme.primary),
                    borderRadius: BorderRadius.circular(4)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: lightColorScheme.error),
                    borderRadius: BorderRadius.circular(4)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: lightColorScheme.error),
                    borderRadius: BorderRadius.circular(4)));

            InputDecorationTheme customDarkInputTheme = InputDecorationTheme(
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: darkColorScheme.outline),
                    borderRadius: BorderRadius.circular(4)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: darkColorScheme.primary),
                    borderRadius: BorderRadius.circular(4)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 1, color: darkColorScheme.error),
                    borderRadius: BorderRadius.circular(4)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: darkColorScheme.error),
                    borderRadius: BorderRadius.circular(4)));

            return MaterialApp(
              title: 'SPH Planer',
              theme: ThemeData(
                colorScheme: lightColorScheme,
                useMaterial3: true,
                inputDecorationTheme: customLightInputTheme,
              ),
              darkTheme: ThemeData(
                colorScheme: darkColorScheme,
                useMaterial3: true,
                inputDecorationTheme: customDarkInputTheme,
              ),
              themeMode: StorageProvider.settings.theme,
              home: PropertyChangeConsumer<StorageNotifier, String>(
                  properties: const ['main'],
                  builder: (context, notify, child) {
                    if (StorageProvider.loggedIn.isNotEmpty) {
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(StorageProvider.settings.title),
                          bottom: !StorageProvider.settings.viewMode
                                  .contains(RegExp(r"hausaufgaben"))
                              ? bottomAppBar(context)
                              : null,
                          actions: buildActions(
                              StorageProvider.settings.viewMode, context),
                        ),
                        drawer: getDrawer(),
                        body: buildApp(StorageProvider.settings.viewMode),
                      );
                    } else {
                      return const WelcomeScreen();
                    }
                  }),
            );
          });
        },
      );
    });
  }

  Widget buildApp(String view) {
    switch (view) {
      case "vertretung":
        return const VertretungsViewer();
      case "hausaufgaben":
        return const HomeWork();
      default:
        return const Stundenplan();
    }
  }

  PreferredSize? bottomAppBar(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(16),
        child: Container(
          height: 20,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Center(
              child: Text(StorageProvider.settings.updateLock
                  ? StorageProvider.settings.updateLockText
                  : StorageProvider.settings.status)),
        ));
  }

  List<Widget>? buildActions(String view, BuildContext context) {
    List<Widget> actions = [];

    if (view == "stundenplan" || view == "vertretung") {
      actions.add(Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: PropertyChangeConsumer<StorageNotifier, String>(
            properties: const ['updateLock'],
            builder: (context, notify, child) {
              return GestureDetector(
                onTap: () async {
                  if (!StorageProvider.settings.updateLock) {
                    await SPH.update(notify!);
                  }
                },
                child: StorageProvider.settings.updateLock
                    ? Center(
                        child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ))
                    : const Icon(
                        Icons.refresh,
                      ),
              );
            },
          )));
    }

    actions.add(Padding(
        padding: const EdgeInsets.only(right: 10, left: 10),
        child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
            child: const Icon(Icons.settings))));

    return actions;
  }
}
