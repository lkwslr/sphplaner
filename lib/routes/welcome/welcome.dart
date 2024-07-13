import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String buttonText = "Jetzt anmelden";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SPH Planer'),
        ),
        body: OrientationBuilder(builder: (context, _) {
          Size logicalScreenSize =
              View.of(context).physicalSize / View.of(context).devicePixelRatio;

          if (logicalScreenSize.height > logicalScreenSize.width) {
            return ListView(
              children: [
                Image.asset("assets/sph_wide.png", color: Theme.of(context).colorScheme.primary,),
                const Divider(height: 32, color: Colors.transparent),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: buildWelcomeText(40.0, context))
              ],
            );
          } else {
            return Stack(
              fit: StackFit.expand,
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Image.asset(
                    'assets/sph_extra-wide.png',
                    color: Theme.of(context).colorScheme.primary,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Theme.of(context).colorScheme.surface.withOpacity(1),
                    Theme.of(context).colorScheme.surface.withOpacity(.5),
                    Theme.of(context).colorScheme.surface.withOpacity(.5),
                    Theme.of(context).colorScheme.surface.withOpacity(.5)
                  ], begin: Alignment.topCenter, end: const Alignment(0, 1))),
                ),
                SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: SizedBox(
                            width: logicalScreenSize.width / 2,
                            child: buildWelcomeText(
                                min(max(40.0, logicalScreenSize.height / 12),
                                    64.0),
                                context),
                          ),
                        )))
              ],
            );
          }
        }));
  }

  Widget buildWelcomeText(buttonHeight, context) {
    return Column(
      children: [
        const Text("Danke, dass du dir den SPH Planer heruntergeladen hast!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            textAlign: TextAlign.center),
        const Divider(
          height: 32,
          color: Colors.transparent,
        ),
        const SizedBox(
          width: double.infinity,
          child: Text(
            "Bitte beachte: \n"
            "· Bei einzelnen Schulen kann es zu Problemen kommen.\n"
            "· Diese App übermittelt eingegebene Zugangsdaten nur an das Schulportal.\n"
            "· Es besteht keine Gewähr für die Richtigkeit der angezeigten Information.\n"
            "· Es werden nicht alle Funktionen des Schulportals unterstützt.\n\n"
            "Bei Fragen oder Problemen: sphplaner@lkwslr.de",
            style: TextStyle(fontSize: 16),
          ),
        ),
        const Divider(
          height: 32,
          color: Colors.transparent,
        ),
        ElevatedButton(
            onPressed: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Login()));
                  },
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(buttonHeight),
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              buttonText,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary),
            ))
      ],
    );
  }
}
