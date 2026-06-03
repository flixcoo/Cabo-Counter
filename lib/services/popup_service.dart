import 'dart:io';

import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_dialog_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopupService {
  /// Displays an informational pop-up dialog with a title, message, and a single action button.
  /// The dialog adapts its style based on the platform (iOS or Android).
  /// [context]: The BuildContext to show the dialog in.
  /// [title]: The title of the pop-up.
  /// [message]: The message content of the pop-up.
  /// Returns a Future that completes when the dialog is dismissed.
  static Future<void> showInfoPopup({
    required BuildContext context,
    required Widget title,
    required Widget content,
    VoidCallback? onAfterPop,
  }) async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: title,
        content: content,
        actions: [
          Platform.isIOS
              ? CupertinoDialogAction(
                  child: Text(AppLocalizations.of(context).ok),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onAfterPop != null) onAfterPop();
                  },
                )
              : TextButton(
                  child: Text(AppLocalizations.of(context).ok),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onAfterPop != null) onAfterPop();
                  },
                ),
        ],
      ),
    );
  }

  /// Displays a selection pop-up dialog with a title, message, and a list of actions.
  /// The dialog adapts its style based on the platform (iOS or Android).
  /// [context]: The BuildContext to show the dialog in.
  /// [title]: The title of the pop-up.
  /// [message]: The message content of the pop-up.
  /// [dialogActions]: A list of CustomDialogAction widgets representing the actions available in the pop-up.
  /// Returns a Future that completes when the dialog is dismissed.
  static Future<T?> showSelectionPopup<T>({
    required BuildContext context,
    required Widget title,
    required Widget message,
    required List<CustomDialogAction<T>> actions,
  }) async {
    return await showAdaptiveDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: title,
          content: message,
          actions: actions.map((action) => action.build(context)).toList(),
        );
      },
    );
  }

  /// Shows a dialog asking the user if they like the app.
  /// Returns the user's decision as enum [PreRatingDialogDecision].
  /// PreRatingDialogDecision.yes: User likes the app.
  /// PreRatingDialogDecision.no: User does not like the app.
  /// PreRatingDialogDecision.cancel: User cancels the dialog.
  static Future<PreRatingDialogDecision> showPreRatingDialog(
    BuildContext context,
  ) async {
    return await PopupService.showSelectionPopup<PreRatingDialogDecision>(
          context: context,
          actions: [
            CustomDialogAction(
              returnValue: PreRatingDialogDecision.yes,
              isDefaultAction: true,
              actionText: AppLocalizations.of(context).yes,
            ),
            CustomDialogAction(
              returnValue: PreRatingDialogDecision.no,
              actionText: AppLocalizations.of(context).no,
            ),
            CustomDialogAction(
              returnValue: PreRatingDialogDecision.cancel,
              isDestructiveAction: true,
              actionText: AppLocalizations.of(context).cancel,
            ),
          ],
          title: Text(AppLocalizations.of(context).pre_rating_title),
          message: Text(AppLocalizations.of(context).pre_rating_message),
        ) ??
        PreRatingDialogDecision.cancel;
  }

  /// Shows a dialog asking the user for feedback if they do not like the app.
  /// Returns the user's decision as enum [BadRatingDialogDecision].
  /// BadRatingDialogDecision.email: User wants to send an email for feedback.
  /// BadRatingDialogDecision.cancel: User cancels the dialog.
  static Future<BadRatingDialogDecision> showBadRatingDialog(
    BuildContext context,
  ) async {
    return await PopupService.showSelectionPopup<BadRatingDialogDecision>(
          context: context,
          title: Text(AppLocalizations.of(context).bad_rating_title),
          message: Text(AppLocalizations.of(context).bad_rating_message),
          actions: [
            CustomDialogAction(
              actionText: AppLocalizations.of(context).contact_email,
              returnValue: BadRatingDialogDecision.email,
            ),
            CustomDialogAction(
              actionText: AppLocalizations.of(context).cancel,
              returnValue: BadRatingDialogDecision.cancel,
            ),
          ],
        ) ??
        BadRatingDialogDecision.cancel;
  }

  static Future<bool> showDeleteGameDialog({
    required BuildContext context,
    required String gameTitle,
  }) async {
    return await PopupService.showSelectionPopup<bool>(
          context: context,
          title: Text(AppLocalizations.of(context).delete_game_title),
          message: Text(
            AppLocalizations.of(context).delete_game_message(gameTitle),
          ),
          actions: [
            CustomDialogAction(
              returnValue: false,
              isDefaultAction: true,
              actionText: AppLocalizations.of(context).cancel,
            ),
            CustomDialogAction(
              isDestructiveAction: true,
              returnValue: true,
              actionText: AppLocalizations.of(context).delete,
            ),
          ],
        ) ??
        false;
  }
}
