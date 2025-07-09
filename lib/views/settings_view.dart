import 'package:cabo_counter/l10n/app_localizations.dart';
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
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context).settings),
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
                  AppLocalizations.of(context).points,
                  style: CustomTheme.rowTitle,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                  child: CupertinoListTile(
                    padding: EdgeInsets.zero,
                    title: Text(AppLocalizations.of(context).cabo_penalty),
                    subtitle: Text(
                        AppLocalizations.of(context).cabo_penalty_subtitle),
                    trailing: Stepper(
                      key: _stepperKey1,
                      initialValue: ConfigService.caboPenalty,
                      minValue: 0,
                      maxValue: 50,
                      step: 1,
                      onChanged: (newCaboPenalty) {
                        setState(() {
                          ConfigService.setCaboPenalty(newCaboPenalty);
                          ConfigService.caboPenalty = newCaboPenalty;
                        });
                      },
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                  child: CupertinoListTile(
                    padding: EdgeInsets.zero,
                    title: Text(AppLocalizations.of(context).point_limit),
                    subtitle:
                        Text(AppLocalizations.of(context).point_limit_subtitle),
                    trailing: Stepper(
                      key: _stepperKey2,
                      initialValue: ConfigService.pointLimit,
                      minValue: 30,
                      maxValue: 1000,
                      step: 10,
                      onChanged: (newPointLimit) {
                        setState(() {
                          ConfigService.setPointLimit(newPointLimit);
                          ConfigService.pointLimit = newPointLimit;
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
                      child:
                          Text(AppLocalizations.of(context).reset_to_default),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text(
                  AppLocalizations.of(context).game_data,
                  style: CustomTheme.rowTitle,
                ),
              ),
              /*Padding(
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
                              AppLocalizations.of(context).import_data,
                              style:
                                  TextStyle(color: CustomTheme.backgroundColor),
                            ),
                            onPressed: () async {
                              final success =
                                  await LocalStorageService.importJsonFile();
                              showFeedbackDialog(success);
                            }),
                        const SizedBox(
                          width: 20,
                        ),
                        CupertinoButton(
                          color: CustomTheme.primaryColor,
                          sizeStyle: CupertinoButtonSize.medium,
                          child: Text(
                            AppLocalizations.of(context).export_data,
                            style:
                                TextStyle(color: CustomTheme.backgroundColor),
                          ),
                          onPressed: () async {
                            final success =
                                await LocalStorageService.exportGameData();
                            if (!success && context.mounted) {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  title: Text(AppLocalizations.of(context)
                                      .export_error_title),
                                  content: Text(AppLocalizations.of(context)
                                      .export_error_message),
                                  actions: [
                                    CupertinoDialogAction(
                                      child:
                                          Text(AppLocalizations.of(context).ok),
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
              ),*/
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: CupertinoFormSection.insetGrouped(
                      backgroundColor: CustomTheme.backgroundColor,
                      margin: EdgeInsets.zero,
                      children: [
                        CupertinoFormRow(
                            prefix: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.square_arrow_up,
                                  color: CustomTheme.primaryColor,
                                ),
                                const SizedBox(width: 10),
                                const Text('Spieldaten exportieren'),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: const CupertinoListTileChevron()),
                        CupertinoFormRow(
                            prefix: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.square_arrow_down,
                                  color: CustomTheme.primaryColor,
                                ),
                                const SizedBox(width: 10),
                                const Text('Spieldaten importieren'),
                              ],
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: const CupertinoListTileChevron())
                      ])),
            ],
          ),
          Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Center(
                    child: Text(AppLocalizations.of(context).error_found),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                    child: Center(
                      child: CupertinoButton(
                        onPressed: () => launchUrl(Uri.parse(
                            'https://github.com/flixcoo/Cabo-Counter/issues')),
                        child: Text(AppLocalizations.of(context).create_issue),
                      ),
                    ),
                  ),
                  FutureBuilder<PackageInfo>(
                    future: _getPackageInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          '${Globals.appDevPhase} ${snapshot.data!.version} '
                          '(${AppLocalizations.of(context).build} ${snapshot.data!.buildNumber})',
                          textAlign: TextAlign.center,
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          '${AppLocalizations.of(context).app_version} -.-.- (${AppLocalizations.of(context).build} -)',
                          textAlign: TextAlign.center,
                        );
                      }
                      return Text(
                        AppLocalizations.of(context).load_version,
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

  void showFeedbackDialog(ImportStatus status) {
    if (status == ImportStatus.canceled) return;
    final (title, message) = _getDialogContent(status);

    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                child: Text(AppLocalizations.of(context).ok),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  (String, String) _getDialogContent(ImportStatus status) {
    switch (status) {
      case ImportStatus.success:
        return (
          AppLocalizations.of(context).import_success_title,
          AppLocalizations.of(context).import_success_message
        );
      case ImportStatus.validationError:
        return (
          AppLocalizations.of(context).import_validation_error_title,
          AppLocalizations.of(context).import_validation_error_message
        );

      case ImportStatus.formatError:
        return (
          AppLocalizations.of(context).import_format_error_title,
          AppLocalizations.of(context).import_format_error_message
        );
      case ImportStatus.genericError:
        return (
          AppLocalizations.of(context).import_generic_error_title,
          AppLocalizations.of(context).import_generic_error_message
        );
      case ImportStatus.canceled:
        return ('', '');
    }
  }
}
