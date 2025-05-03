import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:cabo_counter/utility/custom_theme.dart';
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
  final TextEditingController _gameTitleTextController =
      TextEditingController();
  late final int _pointLimit;
  late final int _caboPenalty;
  bool _isLoading = true;

  @override
  void initState() {
    _loadSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Einstellungen'),
      ),
      child: SafeArea(
          child: _isLoading
              ? const Center(child: CupertinoActivityIndicator())
              : Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                            'Punkte',
                            style: CustomTheme.createGameTitle,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                            child: CupertinoListTile(
                              padding: EdgeInsets.zero,
                              title: const Text('Cabo-Strafe'),
                              subtitle:
                                  const Text('... für falsches Cabo sagen'),
                              trailing: Stepper(
                                initialValue: _caboPenalty,
                                minValue: 0,
                                maxValue: 50,
                                step: 1,
                                onChanged: (value) {
                                  setState(() {
                                    print('Neuer Wert: $value');
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
                                initialValue: _pointLimit,
                                minValue: 30,
                                maxValue: 1000,
                                step: 10,
                                onChanged: (value) {
                                  setState(() {
                                    print('Neuer Wert: $value');
                                  });
                                },
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                            'Spieldaten',
                            style: CustomTheme.createGameTitle,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 10, 0),
                            child: Row(
                              children: [
                                CupertinoButton(
                                  sizeStyle: CupertinoButtonSize.medium,
                                  child: Text(
                                    'Daten exportieren',
                                    style: TextStyle(color: CustomTheme.white),
                                  ),
                                  onPressed: () async {
                                    final success = await LocalStorageService
                                        .exportJsonFile();
                                    if (!success && context.mounted) {
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                          title: const Text('Fehler'),
                                          content: const Text(
                                              'Datei konnte nicht exportiert werden.'),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text('OK'),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                                CupertinoButton(
                                    sizeStyle: CupertinoButtonSize.large,
                                    child: Text(
                                      'Daten importieren',
                                      style:
                                          TextStyle(color: CustomTheme.white),
                                    ),
                                    onPressed: () async {
                                      final success = await LocalStorageService
                                          .importJsonFile();
                                      if (!success && context.mounted) {
                                        showCupertinoDialog(
                                            context: context,
                                            builder: (context) =>
                                                CupertinoAlertDialog(
                                                  title: const Text('Fehler'),
                                                  content: const Text(
                                                      'Datei konnte nicht importiert werden.'),
                                                  actions: [
                                                    CupertinoDialogAction(
                                                      child: const Text('OK'),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                  ],
                                                ));
                                      }
                                    }),
                              ],
                            )),
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
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
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

  Future<void> _loadSettings() async {
    final pointLimit = await ConfigService.getPointLimit();
    final caboPenalty = await ConfigService.getCaboPenalty();
    setState(() {
      _pointLimit = pointLimit;
      _caboPenalty = caboPenalty;
      _isLoading = false;
    });
  }
}
