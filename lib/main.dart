import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sphplaner/helper/app_info.dart' as app_info;
import 'package:sphplaner/helper/backend.dart';
import 'package:sphplaner/helper/drawer.dart';
import 'package:sphplaner/routes/hausaufgaben.dart';
import 'package:sphplaner/routes/login.dart';
import 'package:sphplaner/routes/settings.dart';
import 'package:sphplaner/routes/stundenplan.dart';
import 'package:sphplaner/routes/vertretung.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

import 'helper/theme.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  app_info.init();

  runApp(PropertyChangeProvider<Backend, String>(
      value: Backend(), child: const SPHPlaner()));
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
    Backend backend =
        PropertyChangeProvider.of<Backend, String>(context, listen: false)!
            .value;
    backend.initBackend().then((_) {
      if (backend.isLoggedIn) {
        backend.initApp().then((_) {
          setState(() {
            loaded = true;
          });
          if (backend.autoUpdate) {
            backend.sphLogin = true;
          }
          FlutterNativeSplash.remove();
          if (backend.autoUpdate) {
            backend.initSPH().then((_) => backend.updateData());
          }
        });
      } else {
        setState(() {
          loaded = true;
        });
        FlutterNativeSplash.remove();
      }
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
      return PropertyChangeConsumer<Backend, String>(
        properties: const ['themeMode'],
        builder: (context, backend, child) {
          return DynamicColorBuilder(
              builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
                ColorScheme lightColorScheme;
                ColorScheme darkColorScheme;

                if (lightDynamic != null && darkDynamic != null) {
                  lightColorScheme = lightDynamic.harmonized();

                  darkColorScheme = darkDynamic.harmonized();
                  if (!backend!.materialYou) {
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
                  }
                } else {
                  lightColorScheme = defaultLightColorScheme;
                  darkColorScheme = defaultDarkColorScheme;
                }

                InputDecorationTheme customLightInputTheme = InputDecorationTheme(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: lightColorScheme.outline),
                        borderRadius: BorderRadius.circular(4)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: lightColorScheme.primary),
                        borderRadius: BorderRadius.circular(4)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: lightColorScheme.error),
                        borderRadius: BorderRadius.circular(4)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: lightColorScheme.error),
                        borderRadius: BorderRadius.circular(4)));

                InputDecorationTheme customDarkInputTheme = InputDecorationTheme(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: darkColorScheme.outline),
                        borderRadius: BorderRadius.circular(4)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: darkColorScheme.primary),
                        borderRadius: BorderRadius.circular(4)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1, color: darkColorScheme.error),
                        borderRadius: BorderRadius.circular(4)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: darkColorScheme.error),
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
                  themeMode: backend!.themeMode,
                  home: PropertyChangeConsumer<Backend, String>(
                      properties: const ['loggedIn', 'viewMode'],
                      builder: (context, backend, child) {
                        return Scaffold(
                          appBar: AppBar(
                            title: Text(backend!.title),
                            bottom: backend.isLoggedIn &&
                                !backend.viewMode
                                    .contains(RegExp(r"hausaufgaben"))
                                ? bottomAppBar(context)
                                : null,
                            actions: backend.isLoggedIn
                                ? buildActions(backend.viewMode, context, false)
                                : null,
                          ),
                          drawer: backend.isLoggedIn ? getDrawer() : null,
                          body: backend.isLoggedIn
                              ? buildApp(backend.viewMode)
                              : const Login(),
                        );
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
        return const Vertretung();
      case "hausaufgaben":
        return const HomeWork();
      default:
        return const Stundenplan();
    }
  }

  PreferredSize? bottomAppBar(BuildContext context) {
    Backend backend = PropertyChangeProvider.of<Backend, String>(context,
            listen: true, properties: const ['status', 'online'])!
        .value;

    return PreferredSize(
        preferredSize:
            Size.fromHeight(backend.sphLogin ? 32 : 64),
        child: ValueListenableBuilder(
            valueListenable: loading,
            builder: (BuildContext context, bool value, Widget? child) {
              if (backend.sphLogin) {
                return Container(
                  height: 32,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Center(child: Text(backend.status)),
                );
              } else {
                return GestureDetector(
                  onTap: () async {
                    loading.value = true;
                    await backend.initSPH().then((value) {
                      loading.value = false;
                      backend.status = value;
                      if (value.isEmpty) {
                        backend.updateData();
                      }
                    });

                  },
                  child: loading.value
                      ? SizedBox(
                          width: double.infinity,
                          height: 64,
                          child: Center(
                            child: SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                  "Offline-Modus - Manche Funktionen sind nicht verfügbar"),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(result),
                            ),
                            Container(
                              height: 32,
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Center(child: Text(backend.status)),
                            )
                          ],
                        ),
                );
              }
            }));
  }

  List<Widget>? buildActions(String view, BuildContext context, bool dsbLogin) {
    List<Widget> actions = [];

    if (view == "plan" || view == "vertretung") {
      actions.add(Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: PropertyChangeConsumer<Backend, String>(
            properties: const ['updateLock'],
            builder: (context, backend, child) {
              return GestureDetector(
                onTap: () {
                  if (!backend!.updateLock &&
                      (backend.sphLogin)) {
                    backend.updateData();
                  }
                },
                child: backend!.updateLock &&
                        (backend.sphLogin)
                    ? Center(
                        child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ))
                    : Icon(
                        Icons.refresh,
                        color: backend.sphLogin
                            ? null
                            : Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(.5),
                      ),
              );
            },
          )));

      if (dsbLogin) {
        actions.add(Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: PropertyChangeConsumer<Backend, String>(
              properties: const ['viewMode'],
              builder: (context, backend, child) {
                return GestureDetector(
                  onTap: () async {
                    if (backend!.viewMode == "plan") {
                      backend.viewMode = "vertretung";
                    } else {
                      backend.viewMode = "plan";
                    }
                  },
                  child: backend!.viewMode == "plan"
                      ? const Icon(Icons.calendar_month_outlined)
                      : const Icon(Icons.list),
                );
              },
            )));
      }
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
