//TODO: Login flow, bei dem Stundenplan geladen wird. Danach hat man die Option Fächer und Kurse auszuwählen, wenn es mehr als eine Option gibt.

//TODO: wenn stundenplan geupdatet wird überprüfen, ob die fächer immer noch die gleichen sind, wenn sich fächer im Stundenplan geändert haben erneut Bildschim vom Login-Flow anzeigen

//TODO: user update, checked nach email change

//TODO: settings (email, password, photo)

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
import 'package:home_widget/home_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/app_info.dart' as app_info;
import 'package:sphplaner/helper/drawer.dart';
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

import 'helper/storage/homework.dart';

const String appGroupId = 'group.hausaufgabenwidget';
const String iOSWidgetName = 'Hausaufgaben';
const String androidWidgetName = 'Hausaufgaben';

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
          '${record.loggerName} - ${record.level.name}: ${record.time}: ${record.message}');
    }
    if (StorageProvider.debugLog || record.level.value >= 1000) {
      await StorageProvider.isar.writeTxn(() async {
        await StorageProvider.isar.logs.put(Log()
          ..name = record.loggerName
          ..level = record.level.name
          ..time = record.time.millisecondsSinceEpoch
          ..message = record.message);
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

updateHandler(String action) {
  switch (action) {
    case "reset":
      {
        return StorageProvider.deleteAll().then((value) {
          StorageProvider.initializeStorage()
              .then((value) => StorageProvider.settings.update = true);
        });
      }
    case "ignore":
      return;
    default:
      return;
  }
}
void updateHomework(List<Homework> homeworks) {
  homeworks.sort((a, b) => a.due?.compareTo(b.due ?? 0) ?? 0);
  List<String> widgetHomework = homeworks.map((element) {
    return element.toString();
  }).toList();
  HomeWidget.saveWidgetData<List<String>>('homeworks', widgetHomework);
  HomeWidget.updateWidget(
    iOSName: iOSWidgetName,
    androidName: androidWidgetName,
  );
}

class _SPHPlaner extends State<SPHPlaner> {
  bool loaded = false;
  bool popUpBuilder = false;
  ValueNotifier<bool> loading = ValueNotifier(false);
  String result = "Klicken, um in den Online-Modus zu wechseln";
  int selectedIndex = 1;
  final log = Logger('SPHPlaner');
  bool secureError = false;

  @override
  void initState() {
    super.initState();
    HomeWidget.setAppGroupId(appGroupId);
    StorageProvider.initializeStorage().then((value) {
      if (StorageProvider.settings.update) {
        updateHandler("ignore");
      }
      if (StorageProvider.settings.loggedIn) {
        try {
          SPH.setCredetialsFor(StorageProvider.loggedIn).then((value) {
            if (value) {
              StorageProvider.settings.updateLockText = "";
            } else {
              log.shout("secureStorageError");
              setState(() {
                secureError = true;
              });
            }
          });
        } on PlatformException catch (_) {
          log.shout("secureStorageError");
        }
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
              themeMode: StorageProvider.settings.theme,
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
                    print(StorageProvider.vertretungsDate);
                    if (secureError) {
                      return Login(
                        secureStorageError: secureError,
                      );
                    } else if (StorageProvider.loggedIn.isNotEmpty) {
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
        await Future.delayed(
            const Duration(milliseconds: 500),
            () => showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  ValueNotifier<bool> obscure = ValueNotifier<bool>(true);

                  TextEditingController input = TextEditingController();

                  return AlertDialog(
                    scrollable: true,
                    title: const Text("Passwort"),
                    content: Column(
                      children: [
                        const Text(
                            "Anscheinend hast du dein Passwort außerhalb der App geändert. Damit die App weiterhin funktioniert, gib bitte das neue Passwort ein!"),
                        const SizedBox(
                          height: 8,
                        ),
                        ValueListenableBuilder(
                          valueListenable: obscure,
                          builder: (context, bool value, _) {
                            return TextField(
                              controller: input,
                              obscureText: value,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Aktuelles Passwort',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      obscure.value = !value;
                                    },
                                    child: Icon(Icons.remove_red_eye,
                                        color: value
                                            ? null
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary),
                                  )),
                            );
                          },
                        )
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            StorageProvider.dialog = false;
                            StorageProvider.wrongPassword = false;
                            StorageProvider.deleteAll().then((value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const SPHPlaner()),
                                  ModalRoute.withName('/'));
                            });
                          },
                          child: const Text("Abmelden")),
                      ElevatedButton(
                          onPressed: () {
                            StorageProvider.savePassword(
                                StorageProvider.loggedIn, input.text);
                            StorageProvider.wrongPassword = false;
                            Navigator.of(context).pop();
                          },
                          child: const Text("Speichern")),
                    ],
                  );
                }));
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
