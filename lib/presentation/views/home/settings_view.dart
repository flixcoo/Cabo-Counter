import 'package:cabo_counter/core/adaptive_page_route.dart';
import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_dialog_action.dart';
import 'package:cabo_counter/presentation/components/widgets/settings/custom_form_row.dart';
import 'package:cabo_counter/presentation/components/widgets/settings/custom_form_section.dart';
import 'package:cabo_counter/presentation/components/widgets/settings/custom_stepper.dart';
import 'package:cabo_counter/presentation/views/home/create_game/mode_selection_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/data_transfer_service.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/popup_service.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Settings and information page for the app.
///
/// [SettingsView] is a settings page for the app, allowing users to configure game options,
/// manage game data (import, export, delete), and view app information.
class SettingsView extends StatefulWidget {
  const SettingsView({super.key, required this.onSessionsUpdated});

  final VoidCallback onSessionsUpdated;

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
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.settings)),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormSection(
                title: loc.points,
                infoText: loc.rotate_dealer_info,
                rows: [
                  CustomFormRow(
                    prefixText: loc.cabo_penalty,
                    prefixIcon: IconService.cabo_penalty,
                    showChevron: false,
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
                    prefixText: loc.point_limit,
                    prefixIcon: IconService.point_limit,
                    showChevron: false,
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
                    prefixText: loc.standard_mode,
                    prefixIcon: IconService.mode,
                    suffixWidget: Text(
                      defaultMode == GameMode.none
                          ? loc.no_default_mode
                          : (defaultMode == GameMode.pointLimit
                                ? '${ConfigService.getPointLimit()} ${loc.points}'
                                : loc.unlimited),
                      style: const TextStyle(color: CustomTheme.primaryColor),
                    ),
                    onPressed: () async {
                      final selectedMode = await Navigator.push(
                        context,
                        adaptivePageRoute(
                          builder: (context) => ModeSelectionView(
                            pointLimit: ConfigService.getPointLimit(),
                            showDeselection: true,
                            initialSelectedGameMode: defaultMode,
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
                    prefixText: loc.rotate_dealer,
                    prefixIcon: IconService.shuffle_cards,
                    suffixWidget: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
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
                    showChevron: false,
                  ),
                ],
              ),
              CustomFormSection(
                infoText: loc.config_change_info,
                rows: [
                  CustomFormRow(
                    prefixText: loc.reset_to_default,
                    prefixIcon: IconService.reset,
                    onPressed: () => showConfirmPopup(),
                  ),
                ],
              ),
              CustomFormSection(
                title: loc.game_data,
                rows: [
                  CustomFormRow(
                    prefixText: loc.export_data,
                    prefixIcon: IconService.export,
                    onPressed: () =>
                        DataTransferService.exportGameData(context),
                  ),
                  CustomFormRow(
                    prefixText: loc.import_data,
                    prefixIcon: IconService.import,
                    onPressed: () async {
                      final status = await DataTransferService.importJsonFile(
                        context,
                      );
                      showFeedbackDialog(status);
                      widget.onSessionsUpdated.call();
                    },
                  ),
                  CustomFormRow(
                    prefixText: loc.delete_data,
                    prefixIcon: IconService.delete,
                    showChevron: false,
                    onPressed: () => _deleteAllGames(),
                  ),
                ],
              ),
              CustomFormSection(
                title: loc.app,
                rows: [
                  CustomFormRow(
                    prefixText: loc.mail_developer,
                    prefixIcon: IconService.e_mail,
                    onPressed: () => launchUrl(
                      Uri.parse('mailto:${Constants.CONTACT_EMAIL}'),
                    ),
                  ),
                  CustomFormRow(
                    prefixText: loc.report_error,
                    prefixIcon: IconService.brand_github,
                    onPressed: () =>
                        launchUrl(Uri.parse(Constants.GITHUB_ISSUE_LINK)),
                  ),
                  CustomFormRow(
                    prefixText: loc.version,
                    prefixIcon: IconService.version,
                    suffixWidget: Text(
                      VersionService.getVersion(),
                      style: const TextStyle(color: CustomTheme.primaryColor),
                    ),
                    suffixPadding: 12,
                    showChevron: false,
                  ),
                  CustomFormRow(
                    prefixText: loc.build,
                    prefixIcon: IconService.number,
                    onPressed: null,
                    suffixWidget: Text(
                      VersionService.getBuildNumber(),
                      style: const TextStyle(color: CustomTheme.primaryColor),
                    ),
                    suffixPadding: 12,
                    showChevron: false,
                  ),
                ],
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
    final loc = AppLocalizations.of(context);
    final db = Provider.of<AppDatabase>(context, listen: false);
    final dialogActions = [
      CustomDialogAction(isDefaultAction: true, actionText: loc.cancel),
      CustomDialogAction(
        isDestructiveAction: true,
        onAfterPop: () async {
          await db.gameSessionDao.deleteAllGames();
          widget.onSessionsUpdated.call();
        },
        actionText: loc.delete,
      ),
    ];

    PopupService.showSelectionPopup(
      context: context,
      title: Text(loc.delete_data_title),
      message: Text(loc.delete_data_message),
      actions: dialogActions,
    );
  }

  /// Displays a feedback dialog for import operations based on the [ImportStatus].
  /// If the import was canceled, no dialog is shown.
  void showFeedbackDialog(ImportStatus status) {
    if (status == ImportStatus.canceled) return;
    final (title, message) = getDialogContent(status);

    PopupService.showInfoPopup(
      context: context,
      title: Text(title),
      content: Text(message),
    );
  }

  /// Returns the dialog title and message based on the [ImportStatus].
  /// [status] The status of the import operation.
  /// Returns a tuple containing the title and message for the dialog.
  (String, String) getDialogContent(ImportStatus status) {
    final loc = AppLocalizations.of(context);
    switch (status) {
      case ImportStatus.success:
        return (loc.import_success_title, loc.import_success_message);
      case ImportStatus.validationError:
        return (
          loc.import_validation_error_title,
          loc.import_validation_error_message,
        );

      case ImportStatus.formatError:
        return (loc.import_format_error_title, loc.import_format_error_message);
      case ImportStatus.genericError:
        return (
          loc.import_generic_error_title,
          loc.import_generic_error_message,
        );
      case ImportStatus.canceled:
        return ('', '');
    }
  }

  /// Shows a popup for the user to confirm the reset of their settings
  void showConfirmPopup() {
    final loc = AppLocalizations.of(context);
    final dialogActions = [
      CustomDialogAction(actionText: loc.cancel),
      CustomDialogAction(
        isDestructiveAction: true,
        isDefaultAction: true,
        actionText: loc.reset,
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
      title: Text(loc.reset_config_title),
      message: Text(loc.reset_config_message),
      actions: dialogActions,
    );
  }
}
