import 'dart:convert';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sphplaner/helper/app_info.dart' as app_info;
import 'package:property_change_notifier/property_change_notifier.dart';
import 'package:sphplaner/helper/storage/storage_notifier.dart';
import 'package:sphplaner/helper/storage/storage_provider.dart';
import 'package:sphplaner/routes/suppport.dart';
import 'package:url_launcher/url_launcher.dart';

import '../routes/easteregg.dart';
import '../routes/settings.dart';

const IconData handHoldingHeart =
    IconData(0xf4be, fontFamily: "sphplaner", fontPackage: null);

Widget getDrawer() {
  return PropertyChangeConsumer<StorageNotifier, String>(
    properties: const ['main'],
    builder: (context, notify, child) {
      String username = "${StorageProvider.user.displayName}";
      String hey;
      if (username.trim().isEmpty) {
        hey = "Hey";
      } else {
        hey = "Hey, ${username.trim()}";
      }

      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xff00bcd4)),
              padding: const EdgeInsets.all(0),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Image.asset(
                        'assets/sph_white_wide.png',
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Color(0xff0575e6)],
                            begin: Alignment.topCenter,
                            end: Alignment(0, 1))),
                  ),
                  Container(
                      padding: const EdgeInsets.fromLTRB(8, 16, 16, 16),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Benutzerdaten",
                                        textAlign: TextAlign.center,
                                      ),
                                      scrollable: true,
                                      content: Column(
                                        children: [
                                          ListTile(
                                            title: const Text("Name"),
                                            subtitle: Text(
                                                "${StorageProvider.user.firstName} ${StorageProvider.user.lastName}"),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            title: const Text("E-Mail"),
                                            subtitle: Text(
                                                "${StorageProvider.user.email}"),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            title: const Text("Geburtsdatum"),
                                            subtitle: Text(
                                                "${StorageProvider.user.birthDate}"),
                                          ),
                                          const Divider(),
                                          ListTile(
                                            title: const Text("Klasse"),
                                            subtitle: Text(
                                                "${StorageProvider.user.course}"),
                                          ),
                                          const Divider(),
                                          ListTile(
                                              title: Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 8),
                                                child: const Text("Profilbild"),
                                              ),
                                              subtitle: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Image(
                                                  image: MemoryImage(
                                                      base64Decode(
                                                          StorageProvider.user.profileImage!)),
                                                ),
                                              )),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Schließen")),
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              alignment: Alignment.topLeft,
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: MemoryImage(base64Decode(
                                        StorageProvider.user.profileImage!))),
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () => anzeigeNameDialog(context),
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  hey,
                                  style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                ),
                              )),
                        ],
                      ))
                ],
              ),
            ),
            ListTile(
              selected: StorageProvider.settings.viewMode == "vertretung",
              title: const Text(
                'Vertretungsplan',
              ),
              leading: const Icon(
                Icons.calendar_view_day,
              ),
              onTap: () {
                StorageProvider.settings.viewMode = "vertretung";
                notify!.notify("main");
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              selected: StorageProvider.settings.viewMode == "stundenplan",
              title: const Text('Stundenplan'),
              leading: const Icon(
                Icons.calendar_month,
              ),
              onTap: () {
                StorageProvider.settings.viewMode = "stundenplan";
                notify!.notify("main");
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              selected: StorageProvider.settings.viewMode == "hausaufgaben",
              title: const Text('Hausaufgaben'),
              leading: const Icon(
                Icons.book,
              ),
              onTap: () {
                StorageProvider.settings.viewMode = "hausaufgaben";
                notify!.notify("main");
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              selected: StorageProvider.settings.viewMode == "settings",
              title: const Text(
                'Einstellungen',
              ),
              leading: const Icon(
                Icons.settings,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
            ),
            ListTile(
              selected: StorageProvider.settings.viewMode == "support",
              title: const Text(
                'Unterstütze diese App',
              ),
              leading: const Icon(
                handHoldingHeart,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Support()));
              },
            ),
            AboutListTile(
              icon: const Icon(Icons.info),
              applicationName: "SPH Planer",
              applicationVersion: "v${app_info.version}",
              applicationIcon: Image.asset(
                "assets/sph.png",
                width: 64,
              ),
              aboutBoxChildren: [
                ListTile(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                  title: const Text(
                    'Unterstütze diese App',
                  ),
                  leading: const Icon(
                    handHoldingHeart,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Support()));
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                _created(context)
              ],
              child: const Text("About"),
            )
          ],
        ),
      );
    },
  );
}

Widget _created(BuildContext ctx) {
  return Center(
      child: RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
            text: '</ ',
            style: TextStyle(
                color: Theme.of(ctx).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(ctx,
                    MaterialPageRoute(builder: (context) => const EasterEgg()));
              }),
        const TextSpan(text: 'made by ', style: TextStyle(fontSize: 16)),
        TextSpan(
            text: 'Leon Wisseler ',
            style: TextStyle(
                color: Theme.of(ctx).colorScheme.primary,
                fontSize: 16,
                fontStyle: FontStyle.italic),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(Uri.parse('https://www.lkwslr.de'),
                    mode: LaunchMode.externalApplication);
              }),
        TextSpan(
          text: '>',
          style: TextStyle(
              color: Theme.of(ctx).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  ));
}
