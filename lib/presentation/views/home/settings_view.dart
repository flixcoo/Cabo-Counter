import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/dto/game_manager.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_dialog_action.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_form_row.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_stepper.dart';
import 'package:cabo_counter/presentation/views/home/create_game/mode_selection_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/data_transfer_service.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/popup_service.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Settings and information page for the app.
///
/// [SettingsView] is a settings page for the app, allowing users to configure game options,
/// manage game data (import, export, delete), and view app information.
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  UniqueKey _stepperKey1 = UniqueKey();
  UniqueKey _stepperKey2 = UniqueKey();
  GameMode defaultMode = ConfigService.getGameMode();
  bool rotateShuffler = ConfigService.getRotateShuffler();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context).settings),
        previousPageTitle: AppLocalizations.of(context).games,
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
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: CupertinoFormSection.insetGrouped(
                  footer: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      AppLocalizations.of(context).rotate_dealer_info,
                    ),
                  ),
                  backgroundColor: CustomTheme.backgroundColor,
                  margin: EdgeInsets.zero,
                  children: [
                    CustomFormRow(
                      prefixText: AppLocalizations.of(context).cabo_penalty,
                      prefixIcon: IconService.cabo_penalty,
                      suffixWidget: CustomStepper(
                        key: _stepperKey1,
                        initialValue: ConfigService.getCaboPenalty(),
                        minValue: 0,
                        maxValue: 50,
                        step: 1,
                        onChanged: (newCaboPenalty) {
                          setState(() {
                            ConfigService.setCaboPenalty(newCaboPenalty);
                          });
                        },
                      ),
                    ),
                    CustomFormRow(
                      prefixText: AppLocalizations.of(context).point_limit,
                      prefixIcon: IconService.point_limit,
                      suffixWidget: CustomStepper(
                        key: _stepperKey2,
                        initialValue: ConfigService.getPointLimit(),
                        minValue: 30,
                        maxValue: 1000,
                        step: 10,
                        onChanged: (newPointLimit) {
                          setState(() {
                            ConfigService.setPointLimit(newPointLimit);
                          });
                        },
                      ),
                    ),
                    CustomFormRow(
                      prefixText: AppLocalizations.of(context).standard_mode,
                      prefixIcon: IconService.mode,
                      suffixWidget: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            defaultMode == GameMode.none
                                ? AppLocalizations.of(context).no_default_mode
                                : (defaultMode == GameMode.pointLimit
                                      ? '${ConfigService.getPointLimit()} ${AppLocalizations.of(context).points}'
                                      : AppLocalizations.of(context).unlimited),
                          ),
                          const SizedBox(width: 5),
                          IconService.chevron,
                        ],
                      ),
                      onPressed: () async {
                        final selectedMode = await Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => ModeSelectionMenu(
                              pointLimit: ConfigService.getPointLimit(),
                              showDeselection: true,
                            ),
                          ),
                        );

                        setState(() {
                          defaultMode = selectedMode ?? GameMode.none;
                        });
                        ConfigService.setGameMode(defaultMode);
                      },
                    ),
                    CustomFormRow(
                      prefixText: AppLocalizations.of(context).rotate_dealer,
                      prefixIcon: IconService.shuffle_cards,
                      suffixWidget: Material(
                        color: Colors.transparent,
                        child: Switch.adaptive(
                          activeTrackColor: CustomTheme.primaryColor,
                          inactiveThumbColor: Colors.white,
                          value: rotateShuffler,
                          onChanged: (switchValue) {
                            setState(() {
                              ConfigService.setRotateShuffler(switchValue);
                              rotateShuffler = switchValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: CupertinoFormSection.insetGrouped(
                  footer: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      AppLocalizations.of(context).config_change_info,
                    ),
                  ),
                  backgroundColor: CustomTheme.backgroundColor,
                  margin: EdgeInsets.zero,
                  children: [
                    CustomFormRow(
                      prefixText: AppLocalizations.of(context).reset_to_default,
                      prefixIcon: IconService.reset,
                      onPressed: () => showConfirmPopup(),
                    ),
                  ],
                ),
              ),
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
                      prefixIcon: IconService.import,
                      onPressed: () async {
                        final status =
                            await DataTransferService.importJsonFile();
                        showFeedbackDialog(status);
                      },
                      suffixWidget: IconService.chevron,
                    ),
                    CustomFormRow(
                      prefixText: AppLocalizations.of(context).export_data,
                      prefixIcon: IconService.export,
                      onPressed: () => DataTransferService.exportGameData(),
                      suffixWidget: IconService.chevron,
                    ),
                    CustomFormRow(
                      prefixText: AppLocalizations.of(context).delete_data,
                      prefixIcon: IconService.delete,
                      onPressed: () => _deleteAllGames(),
                    ),
                  ],
                ),
              ),
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
                      prefixText: AppLocalizations.of(context).mail_developer,
                      prefixIcon: IconService.e_mail,
                      onPressed: () => launchUrl(
                        Uri.parse('mailto:${Constants.CONTACT_EMAIL}'),
                      ),
                      suffixWidget: IconService.chevron,
                    ),
                    CustomFormRow(
                      prefixText: AppLocalizations.of(context).report_error,
                      prefixIcon: IconService.report_error,
                      onPressed: () =>
                          launchUrl(Uri.parse(Constants.GITHUB_ISSUE_LINK)),
                      suffixWidget: IconService.chevron,
                    ),
                    CustomFormRow(
                      prefixText: AppLocalizations.of(context).app_version,
                      prefixIcon: IconService.version,
                      onPressed: null,
                      suffixWidget: Text(
                        VersionService.getVersion(),
                        style: TextStyle(color: CustomTheme.primaryColor),
                      ),
                    ),
                    CustomFormRow(
                      prefixText: AppLocalizations.of(context).build,
                      prefixIcon: IconService.number,
                      onPressed: null,
                      suffixWidget: Text(
                        VersionService.getBuildNumber(),
                        style: TextStyle(color: CustomTheme.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  /// Shows a dialog to confirm the deletion of all game data.
  /// When confirmed, it deletes all game data from local storage.
  void _deleteAllGames() {
    final dialogActions = [
      CustomDialogAction(
        isDefaultAction: true,
        actionText: AppLocalizations.of(context).cancel,
      ),
      CustomDialogAction(
        isDestructiveAction: true,
        onAfterPop: () {
          gameManager.deleteAllGames();
        },
        actionText: AppLocalizations.of(context).delete,
      ),
    ];

    PopupService.showSelectionPopup(
      context: context,
      title: Text(AppLocalizations.of(context).delete_data_title),
      message: Text(AppLocalizations.of(context).delete_data_message),
      actions: dialogActions,
    );
  }

  /// Displays a feedback dialog for import operations based on the [ImportStatus].
  /// If the import was canceled, no dialog is shown.
  void showFeedbackDialog(ImportStatus status) {
    if (status == ImportStatus.canceled) return;
    final (title, message) = _getDialogContent(status);

    PopupService.showInfoPopup(
      context: context,
      title: Text(title),
      content: Text(message),
    );
  }

  /// Returns the dialog title and message based on the [ImportStatus].
  /// [status] The status of the import operation.
  /// Returns a tuple containing the title and message for the dialog.
  (String, String) _getDialogContent(ImportStatus status) {
    switch (status) {
      case ImportStatus.success:
        return (
          AppLocalizations.of(context).import_success_title,
          AppLocalizations.of(context).import_success_message,
        );
      case ImportStatus.validationError:
        return (
          AppLocalizations.of(context).import_validation_error_title,
          AppLocalizations.of(context).import_validation_error_message,
        );

      case ImportStatus.formatError:
        return (
          AppLocalizations.of(context).import_format_error_title,
          AppLocalizations.of(context).import_format_error_message,
        );
      case ImportStatus.genericError:
        return (
          AppLocalizations.of(context).import_generic_error_title,
          AppLocalizations.of(context).import_generic_error_message,
        );
      case ImportStatus.canceled:
        return ('', '');
    }
  }

  /// Shows a popup for the user to confirm the reset of their settings
  void showConfirmPopup() {
    final dialogActions = [
      CustomDialogAction(actionText: AppLocalizations.of(context).cancel),
      CustomDialogAction(
        isDestructiveAction: true,
        isDefaultAction: true,
        actionText: AppLocalizations.of(context).reset,
        onAfterPop: () {
          ConfigService.resetUserConfig();
          setState(() {
            _stepperKey1 = UniqueKey();
            _stepperKey2 = UniqueKey();
            defaultMode = ConfigService.getGameMode();
            rotateShuffler = ConfigService.getRotateShuffler();
          });
        },
      ),
    ];
    PopupService.showSelectionPopup(
      context: context,
      title: Text(AppLocalizations.of(context).reset_config_title),
      message: Text(AppLocalizations.of(context).reset_config_message),
      actions: dialogActions,
    );
  }
}
