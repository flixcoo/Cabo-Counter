import 'package:cabo_counter/l10n/app_localizations.dart';
import 'package:cabo_counter/presentation/widgets/custom_form_row.dart';
import 'package:cabo_counter/presentation/widgets/stepper.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:cabo_counter/utility/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  child: CupertinoFormSection.insetGrouped(
                      backgroundColor: CustomTheme.backgroundColor,
                      margin: EdgeInsets.zero,
                      children: [
                        CustomFormRow(
                          key: _stepperKey1,
                          prefixText: 'Cabo-Strafe',
                          prefixIcon: CupertinoIcons.minus_square,
                          suffixWidget: Stepper(
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
                        ),
                        CustomFormRow(
                          key: _stepperKey2,
                          prefixText: 'Punkte-Limit',
                          prefixIcon: FontAwesomeIcons.bullseye,
                          suffixWidget: Stepper(
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
                        ),
                        CustomFormRow(
                          prefixText:
                              AppLocalizations.of(context).reset_to_default,
                          prefixIcon: CupertinoIcons.arrow_counterclockwise,
                          onPressed: () {
                            ConfigService.resetConfig();
                            setState(() {
                              _stepperKey1 = UniqueKey();
                              _stepperKey2 = UniqueKey();
                              print('Config reset to default');
                            });
                          },
                        )
                      ])),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text(
                  AppLocalizations.of(context).data,
                  style: CustomTheme.rowTitle,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                  child: CupertinoFormSection.insetGrouped(
                      backgroundColor: CustomTheme.backgroundColor,
                      margin: EdgeInsets.zero,
                      children: [
                        CustomFormRow(
                          prefixText: AppLocalizations.of(context).import_data,
                          prefixIcon: CupertinoIcons.square_arrow_down,
                          onPressed: () => LocalStorageService.importJsonFile(),
                          suffixWidget: const CupertinoListTileChevron(),
                        ),
                        CustomFormRow(
                          prefixText: AppLocalizations.of(context).export_data,
                          prefixIcon: CupertinoIcons.square_arrow_up,
                          onPressed: () => LocalStorageService.importJsonFile(),
                          suffixWidget: const CupertinoListTileChevron(),
                        ),
                      ])),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text(
                  AppLocalizations.of(context).app,
                  style: CustomTheme.rowTitle,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: CupertinoFormSection.insetGrouped(
                      backgroundColor: CustomTheme.backgroundColor,
                      margin: EdgeInsets.zero,
                      children: [
                        CustomFormRow(
                          prefixText: AppLocalizations.of(context).create_issue,
                          prefixIcon: FontAwesomeIcons.github,
                          onPressed: () => launchUrl(Uri.parse(
                              'https://github.com/flixcoo/Cabo-Counter/issues')),
                          suffixWidget: const CupertinoListTileChevron(),
                        ),
                        CustomFormRow(
                            prefixText: 'App-Version',
                            prefixIcon: CupertinoIcons.info,
                            onPressed: null,
                            suffixWidget: FutureBuilder<PackageInfo>(
                              future: _getPackageInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${Globals.appDevPhase} ${snapshot.data!.version} ',
                                    style: TextStyle(
                                      color: CustomTheme.primaryColor,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(
                                    '${AppLocalizations.of(context).app_version} -.-.-',
                                    style: TextStyle(
                                      color: CustomTheme.primaryColor,
                                    ),
                                  );
                                }
                                return Text(
                                  AppLocalizations.of(context).loading,
                                  style: TextStyle(
                                    color: CustomTheme.primaryColor,
                                  ),
                                );
                              },
                            )),
                        CustomFormRow(
                            prefixText: 'Build-Nr.',
                            prefixIcon: CupertinoIcons.info,
                            onPressed: null,
                            suffixWidget: FutureBuilder<PackageInfo>(
                              future: _getPackageInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    snapshot.data!.buildNumber,
                                    style: TextStyle(
                                      color: CustomTheme.primaryColor,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(
                                    '-',
                                    style: TextStyle(
                                      color: CustomTheme.primaryColor,
                                    ),
                                  );
                                }
                                return Text(
                                  AppLocalizations.of(context).loading,
                                );
                              },
                            )),
                      ])),
            ],
          ),
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
