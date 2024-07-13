import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatelessWidget {
  const Support({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Unterstütze diese App")),
      body: ListView(
        children: [
          Image.asset("assets/sph_wide.png",
          color: Theme.of(context).textTheme.bodyMedium?.color,),
          ListTile(
            title: const Text("Für weitere Informationen besuche die Webseite!"),
            subtitle: const Text(
                "Auf der Webseite findest du weitere Informationen über diese App"),
            leading: const Icon(Icons.open_in_browser),
            onTap: () async {
              await launchUrl(Uri.parse("https://www.lkwslr.de/sphplaner"));
            },
          ),
          ListTile(
            title: const Text("Teile die App!"),
            subtitle: const Text(
                "Je mehr Leute die App nutzen, desto besser. Außerdem ist das für dich die einfachste Art mich zu unterstützen.\nKomplett kostenlos!"),
            leading: const Icon(Icons.share),
            onTap: () async {
              final box = context.findRenderObject() as RenderBox?;
              final result = await Share.share(
                "https://www.lkwslr.de/sphplaner",
                subject: "SPH Planer",
                sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
              );

              if (result.status == ShareResultStatus.success) {
                Fluttertoast.showToast(
                    msg: "Vielen Dank für's Teilen!",
                    toastLength: Toast.LENGTH_LONG);
              }
            },
          ),
          ListTile(
            title: const Text("Melde Fehler!"),
            subtitle: const Text(
                "Durch das Melden von Fehlern kann die App immer weiter verbessert werden."),
            leading: const Icon(Icons.code),
            onTap: () async {
              String email = Uri.encodeComponent("sphplaner@lkwslr.de");
              String subject = Uri.encodeComponent("SPH Planer Bug Report");
              String body =
                  Uri.encodeComponent("Ich habe folgenden Fehler gefunden:");
              Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
              if (await launchUrl(mail)) {
                Fluttertoast.showToast(
                    msg: "Vielen Dank für's Helfen!",
                    toastLength: Toast.LENGTH_LONG);
              }
            },
          ),
          ListTile(
            title: const Text("Schlage neue Features vor!"),
            subtitle:
                const Text("Nur so kann ich wissen, was dir an der App fehlt."),
            leading: const Icon(Icons.thumb_up_off_alt_sharp),
            onTap: () async {
              String email = Uri.encodeComponent("sphplaner@lkwslr.de");
              String subject =
                  Uri.encodeComponent("SPH Planer Feature Request");
              String body =
                  Uri.encodeComponent("Ich habe folgenden Vorschlag:");
              Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
              if (await launchUrl(mail)) {
                Fluttertoast.showToast(
                    msg: "Vielen Dank für deine Idee!",
                    toastLength: Toast.LENGTH_LONG);
              }
            },
          ),
          if (!Platform.isIOS)
            const ListTile(
              title: Text("Unterstütze durch Geld"),
              subtitle: Text(
                  "Die Entwicklung einer App kostet viel Zeit und Geld. Um die App weiter zu entwickeln und anzubieten bin ich auf deine Unterstützung angewiesen!\n"
                  "Geld spenden kannst du auf den folgenden Wegen:"),
              leading: Icon(Icons.attach_money),
            ),
          if (!Platform.isIOS)
            ListTile(
              leading: Icon(
                Icons.attach_money,
                color: Theme.of(context).colorScheme.surface,
              ),
              subtitle: Column(
                children: [
                  ListTile(
                    title: const Text("PayPal"),
                    leading: const Icon(Icons.paypal),
                    onTap: () async {
                      Uri paypal = Uri.parse(
                          "https://www.paypal.com/donate/?hosted_button_id=GD9ZT87VLH8PQ");
                      if (await launchUrl(paypal)) {
                        Fluttertoast.showToast(
                            msg: "Vielen Dank für deine Unterstützung!",
                            toastLength: Toast.LENGTH_LONG);
                      }
                    },
                  ),
                  ListTile(
                    title: const Text("Ko-fi"),
                    leading: const Icon(Icons.coffee),
                    onTap: () async {
                      Uri kofi = Uri.parse("https://ko-fi.com/lkwslr");
                      if (await launchUrl(kofi)) {
                        Fluttertoast.showToast(
                            msg: "Vielen Dank für deine Unterstützung!",
                            toastLength: Toast.LENGTH_LONG);
                      }
                    },
                  ),
                  ListTile(
                    title: const Text("Github Sponsors"),
                    leading: const Icon(Icons.code),
                    onTap: () async {
                      Uri githubSponsors =
                          Uri.parse("https://github.com/sponsors/lkwslr");
                      if (await launchUrl(githubSponsors)) {
                        Fluttertoast.showToast(
                            msg: "Vielen Dank für deine Unterstützung!",
                            toastLength: Toast.LENGTH_LONG);
                      }
                    },
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
