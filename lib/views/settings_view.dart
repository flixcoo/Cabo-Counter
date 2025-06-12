import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:cabo_counter/utility/globals.dart';
import 'package:cabo_counter/widgets/stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  UniqueKey _stepperKey1 = UniqueKey();
  UniqueKey _stepperKey2 = UniqueKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Einstellungen'),
      ),
      child: SafeArea(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text(
                  'Punkte',
                  style: CustomTheme.rowTitle,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                  child: CupertinoListTile(
                    padding: EdgeInsets.zero,
                    title: const Text('Cabo-Strafe'),
                    subtitle: const Text('... für falsches Cabo sagen'),
                    trailing: Stepper(
                      key: _stepperKey1,
                      initialValue: Globals.caboPenalty,
                      minValue: 0,
                      maxValue: 50,
                      step: 1,
                      onChanged: (newCaboPenalty) {
                        setState(() {
                          ConfigService.setCaboPenalty(newCaboPenalty);
                          Globals.caboPenalty = newCaboPenalty;
                        });
                      },
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                  child: CupertinoListTile(
                    padding: EdgeInsets.zero,
                    title: const Text('Punkte-Limit'),
                    subtitle: const Text('... hier ist Schluss'),
                    trailing: Stepper(
                      key: _stepperKey2,
                      initialValue: Globals.pointLimit,
                      minValue: 30,
                      maxValue: 1000,
                      step: 10,
                      onChanged: (newPointLimit) {
                        setState(() {
                          ConfigService.setPointLimit(newPointLimit);
                          Globals.pointLimit = newPointLimit;
                        });
                      },
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Center(
                    heightFactor: 0.9,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => setState(() {
                        ConfigService.resetConfig();
                        _stepperKey1 = UniqueKey();
                        _stepperKey2 = UniqueKey();
                      }),
                      child: const Text('Auf Standard zurücksetzten'),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text(
                  'Spieldaten',
                  style: CustomTheme.rowTitle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                    heightFactor: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoButton(
                            color: CustomTheme.primaryColor,
                            sizeStyle: CupertinoButtonSize.medium,
                            child: Text(
                              'Daten importieren',
                              style:
                                  TextStyle(color: CustomTheme.backgroundColor),
                            ),
                            onPressed: () async {
                              final success =
                                  await LocalStorageService.importJsonFile();
                              if (!success && context.mounted) {
                                showCupertinoDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                          title: const Text('Fehler'),
                                          content: const Text(
                                              'Datei konnte nicht importiert werden.'),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text('OK'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ));
                              }
                            }),
                        const SizedBox(
                          width: 20,
                        ),
                        CupertinoButton(
                          color: CustomTheme.primaryColor,
                          sizeStyle: CupertinoButtonSize.medium,
                          child: Text(
                            'Daten exportieren',
                            style:
                                TextStyle(color: CustomTheme.backgroundColor),
                          ),
                          onPressed: () async {
                            final success =
                                await LocalStorageService.exportJsonFile();
                            if (!success && context.mounted) {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: const Text('Fehler'),
                                  content: const Text(
                                      'Datei konnte nicht exportiert werden.'),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: const Text('OK'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    )),
              )
            ],
          ),
          Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const Center(
                    child: Text('Fehler gefunden?'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Center(
                      child: CupertinoButton(
                        onPressed: () => launchUrl(Uri.parse(
                            'https://github.com/flixcoo/Cabo-Counter/issues')),
                        child: const Text('Issue erstellen'),
                      ),
                    ),
                  ),
                  FutureBuilder<PackageInfo>(
                    future: _getPackageInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          '${Globals.appDevPhase} ${snapshot.data!.version} '
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
                  )
                ],
              )),
        ],
      )),
    );
  }

  Future<PackageInfo> _getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }
}
