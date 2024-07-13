//TODO: wenn stundenplan geupdatet wird überprüfen, ob die fächer immer noch die gleichen sind, wenn sich fächer im Stundenplan geändert haben erneut Bildschim vom Login-Flow anzeigen

//TODO: user update, checked nach email change

//TODO: settings (email, password, photo)

//TODO: mehr logging

//TODO: log anzeige ansicht

//TODO: settings toggle für i's an Fächern

//TODO: pop up zur weiterempfehlung

//TODO: github CD

//TODO: Notifier-Options
/*
      theme -> läd ab Beginn neu, da design änderung
      main -> läd Ansicht neu, z.B. appbar, status oder offener Tab
      settings -> läd Settings neu
      homework -> läd Homework neu


      LOG-LEVEL:
        SHOUT: Standard User Notification for Information
        SEVERE: User Notification for Errors (sent with error and stacktrace for easy email reporting)
        WARNING: Detailede Information from Errors from level SEVERE for Log
        INFO: DEBUG Information, only Log
     */

import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/app_info.dart' as app_info;
import 'package:sphplaner/helper/drawer.dart';
import 'package:sphplaner/helper/networking/cookie.dart';
import 'package:sphplaner/helper/networking/sph.dart';
import 'package:sphplaner/helper/storage/log.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/helper/theme.dart';
import 'package:sphplaner/routes/hausaufgaben.dart';
import 'package:sphplaner/routes/settings.dart';
import 'package:sphplaner/routes/stundenplan.dart';
import 'package:sphplaner/routes/vertretungsviewer.dart';
import 'package:sphplaner/routes/welcome/login.dart';
import 'package:sphplaner/routes/welcome/welcome.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  initializeDateFormatting();
  Intl.defaultLocale = "de_DE";
  app_info.init();
  await StorageProvider.initializeStorage();
  Logger.root.level = StorageProvider.debugLog ? Level.ALL : Level.WARNING;

  Logger.root.onLevelChanged.listen((event) {
    Fluttertoast.showToast(
        msg: event?.name == "ALL"
            ? "Debug Modus aktiviert"
            : "Debug Modus deaktiviert",
        toastLength: Toast.LENGTH_SHORT);
  });

  Logger.root.onRecord.listen((record) async {
    if (kDebugMode) {
      print(
          '${record.loggerName} - ${record.level.name} - ${record.time}: ${record.message} - stacktrace: ${record.stackTrace}');
      if (record.level.value >= 1000) {
        print(getAppState());
      }
    }
    if (StorageProvider.debugLog || record.level.value >= 1000) {
      String message =
          "MESSAGE${record.message}ENDMESSAGE.APPSTATE${getAppState()}ENDAPPSTATE";
      await StorageProvider.isar.writeTxn(() async {
        await StorageProvider.isar.logs.put(Log()
          ..name = record.loggerName
          ..level = record.level.name
          ..time = record.time.millisecondsSinceEpoch
          ..message = message);
      });
    }
  });

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
  bool popUpBuilder = false;
  ValueNotifier<bool> loading = ValueNotifier(false);
  String result = "Klicken, um in den Online-Modus zu wechseln";
  int selectedIndex = 1;
  final log = Logger('SPHPlaner');
  bool credentialError = false;

  @override
  void initState() {
    super.initState();
    StorageProvider.initializeStorage().then((value) {
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
          return DynamicColorBuilder(
              builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            ColorScheme lightColorScheme;
            ColorScheme darkColorScheme;

            if (lightDynamic != null && darkDynamic != null) {
              lightColorScheme = lightDynamic.harmonized();

              darkColorScheme = darkDynamic.harmonized();
              /*lightColorScheme = lightColorScheme.copyWith(
                primary: sphBlue,
                onPrimary: const Color(0xffdde3ee),
                primaryContainer: sphBlue,
              );
              darkColorScheme = darkColorScheme.copyWith(
                primary: sphBlue,
                onPrimary: const Color(0xffdde3ee),
                primaryContainer: sphBlue,
              );*/
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
              debugShowCheckedModeBanner: false,
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
              themeMode: StorageProvider.theme,
              home: PropertyChangeConsumer<StorageNotifier, String>(
                  properties: const ['main'],
                  builder: (context, notify, child) {
                    switch (StorageProvider.settings.viewMode) {
                      case "vertretung":
                        selectedIndex = 0;
                        break;
                      case "hausaufgaben":
                        selectedIndex = 2;
                        break;
                      default:
                        selectedIndex = 1;
                    }
                    if (!popUpBuilder) {
                      Future.delayed(Duration.zero, () => showPopUp(context));
                      popUpBuilder = true;
                    }

                    if (credentialError) {
                      return Login(skipUpdate: credentialError);
                    } else if (StorageProvider.loggedIn) {
                      if (StorageProvider.autoUpdate &&
                          !StorageProvider.didAutoUpdate) {
                        StorageProvider.didAutoUpdate = true;
                        SPH.update(notify!);
                      }
                      return Scaffold(
                        appBar: AppBar(
                          title: Text(StorageProvider.settings.title),
                          bottom: bottomAppBar(context),
                          actions: buildActions(
                              StorageProvider.settings.viewMode, context),
                        ),
                        drawer: getDrawer(),
                        bottomNavigationBar: NavigationBar(
                          onDestinationSelected: (int index) {
                            switch (index) {
                              case 0:
                                {
                                  StorageProvider.settings.viewMode =
                                      "vertretung";

                                  break;
                                }
                              case 1:
                                {
                                  StorageProvider.settings.viewMode =
                                      "stundenplan";
                                  break;
                                }
                              case 2:
                                {
                                  StorageProvider.settings.viewMode =
                                      "hausaufgaben";
                                  break;
                                }
                            }
                            notify!.notify("main");
                          },
                          indicatorColor: Theme.of(context).colorScheme.primary,
                          selectedIndex: selectedIndex,
                          destinations: <Widget>[
                            NavigationDestination(
                              selectedIcon: Icon(Icons.calendar_view_day,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              icon:
                                  const Icon(Icons.calendar_view_day_outlined),
                              label: 'Vertretungsplan',
                            ),
                            NavigationDestination(
                              selectedIcon: Icon(
                                Icons.calendar_month,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              icon: const Icon(Icons.calendar_month_outlined),
                              label: 'Stundenplan',
                            ),
                            NavigationDestination(
                              selectedIcon: Icon(
                                Icons.book,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              icon: const Icon(Icons.book_outlined),
                              label: 'Hausaufgaben',
                            ),
                          ],
                        ),
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
    List<Widget> actions = [
      Padding(
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
          )),
      Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
              child: const Icon(Icons.settings))),
    ];

    return actions;
  }

  Future<void> showPopUp(BuildContext ctx) async {
    Stream<LogRecord> stream = Logger.root.onRecord;
    await for (LogRecord event in stream) {
      if (event.message == "password") {
        setState(() {
          credentialError = true;
        });
      } else if (event.level.name == "SHOUT") {
        await Future.delayed(
            const Duration(milliseconds: 500),
            () => showDialog(
                context: ctx,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text("Es ist ein Fehler aufgetreten."),
                    content: Text(event.message),
                    actions: [
                      TextButton(
                          onPressed: () {
                            StorageProvider.dialog = false;
                            return Navigator.of(context).pop();
                          },
                          child: const Text("OK")),
                    ],
                  );
                }));
      }
      if (StorageProvider.debugLog && event.level.name == "SEVERE") {
        await Future.delayed(
            const Duration(milliseconds: 360),
            () => showDialog(
                context: ctx,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text("Es ist ein Fehler aufgetreten."),
                    content: Text(event.message),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            String email =
                                Uri.encodeComponent("sphplaner@lkwslr.de");
                            String subject =
                                Uri.encodeComponent("SPH Planer Error Report");
                            String body = Uri.encodeComponent(
                                "Zeit: ${event.time}\nGruppe: ${event.loggerName}\nLevel: ${event.level.name}\nNachricht: ${event.message}\nFehler: ${event.error}\nStacktrace: ${event.stackTrace}");
                            Uri mail = Uri.parse(
                                "mailto:$email?subject=$subject&body=$body");
                            await launchUrl(mail).then((value) {
                              if (value) {
                                Fluttertoast.showToast(
                                    msg: "Vielen Dank für's Melden!",
                                    toastLength: Toast.LENGTH_LONG);
                              }
                              StorageProvider.dialog = false;
                              return Navigator.of(context).pop();
                            });
                          },
                          child: const Text("Fehler melden")),
                      TextButton(
                          onPressed: () {
                            StorageProvider.dialog = false;
                            return Navigator.of(context).pop();
                          },
                          child: const Text("OK")),
                    ],
                  );
                }));
      }
    }
  }
}

String getAppState() {
  String state = "";
  state += "vertretungsDate: ${StorageProvider.vertretungsDate}\n";
  state += "timelist: ${StorageProvider.timelist}\n";
  state += "status: ${StorageProvider.status}\n";
  state += "loggedIn: ${StorageProvider.loggedIn}\n";
  state += "emailChange: ${StorageProvider.emailChange}\n";
  state += "emailCheck: ${StorageProvider.emailCheck}\n";
  state += "dialog: ${StorageProvider.dialog}\n";
  state += "debugLog: ${StorageProvider.debugLog}\n";
  state += "advancedDisabled: ${StorageProvider.advancedDisabled}\n";
  state += "isar.name: ${StorageProvider.isar.name}\n";
  state += "isar.directory: ${StorageProvider.isar.directory}\n";
  state += "settings.title: ${StorageProvider.settings.title}\n";
  state +=
      "settings.loadAllVertretung: ${StorageProvider.settings.loadAllVertretung}\n";
  state += "settings.logging: ${StorageProvider.settings.logging}\n";
  state +=
      "settings.showVertretung: ${StorageProvider.settings.showVertretung}\n";
  state += "settings.theme: ${StorageProvider.theme}\n";
  state += "settings.updateLock: ${StorageProvider.settings.updateLock}\n";
  state +=
      "settings.updateLockText: ${StorageProvider.settings.updateLockText}\n";
  state += "CookieStore.getCookies(): ${CookieStore.getCookies()}\n";
  state += "CookieStore.getSID(): ${CookieStore.getSID()}\n";
  return state;
}
