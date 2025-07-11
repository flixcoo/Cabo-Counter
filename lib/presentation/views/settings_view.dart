import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/widgets/custom_form_row.dart';
import 'package:cabo_counter/presentation/widgets/custom_stepper.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          child: SingleChildScrollView(
        child: Column(
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
                        prefixText: AppLocalizations.of(context).cabo_penalty,
                        prefixIcon: CupertinoIcons.bolt_fill,
                        suffixWidget: CustomStepper(
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
                      ),
                      CustomFormRow(
                        prefixText: AppLocalizations.of(context).point_limit,
                        prefixIcon: FontAwesomeIcons.bullseye,
                        suffixWidget: CustomStepper(
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
                          });
                        },
                      )
                    ])),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                AppLocalizations.of(context).game_data,
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
                        onPressed: () async {
                          final status =
                              await LocalStorageService.importJsonFile();
                          showFeedbackDialog(status);
                        },
                        suffixWidget: const CupertinoListTileChevron(),
                      ),
                      CustomFormRow(
                        prefixText: AppLocalizations.of(context).export_data,
                        prefixIcon: CupertinoIcons.square_arrow_up,
                        onPressed: () => LocalStorageService.exportGameData(),
                        suffixWidget: const CupertinoListTileChevron(),
                      ),
                      CustomFormRow(
                        prefixText: AppLocalizations.of(context).delete_data,
                        prefixIcon: CupertinoIcons.trash,
                        onPressed: () => _deleteAllGames(),
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
                        prefixText: AppLocalizations.of(context).wiki,
                        prefixIcon: CupertinoIcons.book,
                        onPressed: () =>
                            launchUrl(Uri.parse(Constants.kGithubWikiLink)),
                        suffixWidget: const CupertinoListTileChevron(),
                      ),
                      CustomFormRow(
                        prefixText: AppLocalizations.of(context).privacy_policy,
                        prefixIcon: CupertinoIcons.doc_append,
                        onPressed: () =>
                            launchUrl(Uri.parse(Constants.kPrivacyPolicyLink)),
                        suffixWidget: const CupertinoListTileChevron(),
                      ),
                      CustomFormRow(
                        prefixText: AppLocalizations.of(context).error_found,
                        prefixIcon: FontAwesomeIcons.github,
                        onPressed: () =>
                            launchUrl(Uri.parse(Constants.kGithubIssuesLink)),
                        suffixWidget: const CupertinoListTileChevron(),
                      ),
                      CustomFormRow(
                          prefixText: AppLocalizations.of(context).app_version,
                          prefixIcon: CupertinoIcons.tag,
                          onPressed: null,
                          suffixWidget: Text(VersionService.getVersion(),
                              style: TextStyle(
                                color: CustomTheme.primaryColor,
                              ))),
                      CustomFormRow(
                          prefixText: AppLocalizations.of(context).build,
                          prefixIcon: CupertinoIcons.number,
                          onPressed: null,
                          suffixWidget: Text(VersionService.getBuildNumber(),
                              style: TextStyle(
                                color: CustomTheme.primaryColor,
                              ))),
                    ])),
            const SizedBox(height: 50)
          ],
        ),
      )),
    );
  }

  /// Shows a dialog to confirm the deletion of all game data.
  /// When confirmed, it deletes all game data from local storage.
  void _deleteAllGames() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(AppLocalizations.of(context).delete_data_title),
          content: Text(AppLocalizations.of(context).delete_data_message),
          actions: [
            CupertinoDialogAction(
              child: Text(AppLocalizations.of(context).cancel),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              isDefaultAction: true,
              child: Text(AppLocalizations.of(context).delete),
              onPressed: () {
                LocalStorageService.deleteAllGames();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
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
