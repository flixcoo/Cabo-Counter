import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationView extends StatelessWidget {
  const InformationView({super.key});

  Future<PackageInfo> _getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Über'),
        ),
        child: SafeArea(
            child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    'Cabo Counter',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: SizedBox(
                      height: 200,
                      child:
                          Image.asset('assets/cabo-counter-logo_rounded.png'),
                    )),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      'Hey :) Danke, dass du als eine:r der ersten User '
                      'meiner ersten eigenen App dabei bist! Ich hab sehr '
                      'viel Arbeit in dieses Projekt gesteckt und auch, '
                      'wenn ich (hoffentlich) an vieles Gedacht hab, wird '
                      'auf jeden Fall noch nicht alles 100% funktionieren. '
                      'Solltest du also irgendwelche Fehler entdecken oder '
                      'Feedback zum Design oder der Benutzerfreundlichkeit'
                      ' haben, zögere bitte nicht sie mir auf den dir '
                      'bekannten Wegen mitzuteilen. Danke! ',
                      textAlign: TextAlign.center,
                      softWrap: true,
                    )),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '\u00A9 Felix Kirchner',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () => launchUrl(
                            Uri.parse('https://www.instagram.com/fx.kr')),
                        icon: const Icon(FontAwesomeIcons.instagram)),
                    IconButton(
                        onPressed: () => launchUrl(
                            Uri.parse('mailto:felix.kirchner.fk@gmail.com')),
                        icon: const Icon(CupertinoIcons.envelope)),
                    IconButton(
                        onPressed: () => launchUrl(
                            Uri.parse('https://www.github.com/flixcoo')),
                        icon: const Icon(FontAwesomeIcons.github)),
                  ],
                ),
                CupertinoButton(
                    child: const Text('Spieldaten exportieren'),
                    onPressed: () => {saveJsonToDevice()})
              ],
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: FutureBuilder<PackageInfo>(
                future: _getPackageInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Alpha ${snapshot.data!.version} '
                      '(Build ${snapshot.data!.buildNumber})',
                      textAlign: TextAlign.center,
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      'App-Version -.-.- (Build -)',
                      textAlign: TextAlign.center,
                    );
                  }
                  return const Text(
                    'Lade Version...',
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
          ],
        )));
  }

  void saveJsonToDevice() async {
    //todo: implement
  }
}
