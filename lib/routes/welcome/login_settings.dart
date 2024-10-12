import 'dart:math';

import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/main.dart';
import 'package:sphplaner/routes/settings.dart';

import '../suppport.dart';

class LoginSettings extends StatefulWidget {
  const LoginSettings({super.key});

  @override
  State<LoginSettings> createState() => _LoginSettings();
}

class _LoginSettings extends State<LoginSettings> {
  StorageNotifier? notify;
  double buttonSizeFactorSmall = 0;
  double buttonSizeFactorXSmall = 0;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, _) {
      return PropertyChangeConsumer<StorageNotifier, String>(
          properties: const ['settings', 'main'],
          builder: (context, notify, child) {
            this.notify ??= notify;

            Size logicalScreenSize = View.of(context).physicalSize /
                View.of(context).devicePixelRatio;
            if (logicalScreenSize.height < logicalScreenSize.width) {
              buttonSizeFactorSmall =
                  min(max(40.0, logicalScreenSize.height / 12), 56.0);
              buttonSizeFactorXSmall =
                  min(max(40.0, logicalScreenSize.height / 12), 52.0);
            } else {
              buttonSizeFactorSmall = 40;
              buttonSizeFactorXSmall = 40;
            }
            return Scaffold(
                appBar: AppBar(title: const Text('SPH Planer')),
                body: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Column(
                      children: [
                        const Image(
                            image: AssetImage('assets/sph_extra-wide.png')),
                        const Divider(height: 32, color: Colors.transparent),
                        const Align(
                          alignment: Alignment.center,
                          child: Text("Fast geschafft!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                              "Die App wurde leider aus dem AppStore entfernt, "
                              "da das jährliche Abonnement für meinen Developer Account abgelaufen ist.\n"
                              "Falls du dabei unterstützen möchtest, dass die App wieder im AppStore verfübar ist, würde ich mich über eine kleine Geldspende freuen. :)"),
                        ),
                        const Divider(height: 16, color: Colors.transparent),
                        ElevatedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Support())),
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size.fromHeight(buttonSizeFactorSmall),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: Text(
                              "Jetzt unterstützen",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            )),
                        const Divider(height: 32, color: Colors.transparent),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                              "Bitte achte darauf, dass es vereinzelt zu Problemen kommen kann, "
                              "die dafür sorgen, dass der Vertretungs- oder Stundenplan nicht richtig angezeigt wird. \n"
                              "Einige Einstellungen sind deshalb deaktiviert, lassen sich jedoch auch aktivieren.\n"
                              "Die Namen und Farben werden automatisch zugeteilt, weshalb es zu Fehlern kommen kann."
                              "Falls es dabei zu Fehlern kommt oder kein Name zugeteilt werden konnte, kannst du eine Email an sphplaner@lkwslr.de schreiben. "
                              "Nenne in der Email den Namen des Fachs und die Abkürzung im Stundenplan, das Fach wird im nächsten Update hinzugefügt."
                              "\nDu kannst jetzt direkt einige Einstellungen anpassen: "),
                        ),
                        const Divider(height: 32, color: Colors.transparent),
                        anzeigeName(context, buttonSizeFactorXSmall),
                        const Divider(height: 32, thickness: 3)
                      ],
                    ),
                    plan(notify!),
                    //theme(notify),
                    //_autoUpdate(),
                    ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Support())),
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                          Size.fromHeight(buttonSizeFactorSmall),
                          backgroundColor:
                          Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          "Jetzt unterstützen",
                          style: TextStyle(
                              color:
                              Theme.of(context).colorScheme.onPrimary),
                        )),
                    ElevatedButton(
                        onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SPHPlaner())),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(buttonSizeFactorSmall),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          "Weiter",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ))
                  ],
                ));
          });
    });
  }
}
