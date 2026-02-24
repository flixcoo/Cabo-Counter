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
    final loc = AppLocalizations.of(context);
    await showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        title: title,
        content: content,
        actions: [
          Platform.isIOS
              ? CupertinoDialogAction(
                  child: Text(loc.ok),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (onAfterPop != null) onAfterPop();
                  },
                )
              : TextButton(
                  child: Text(loc.ok),
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
    final loc = AppLocalizations.of(context);
    return await PopupService.showSelectionPopup<PreRatingDialogDecision>(
          context: context,
          actions: [
            CustomDialogAction(
              returnValue: PreRatingDialogDecision.yes,
              isDefaultAction: true,
              actionText: loc.yes,
            ),
            CustomDialogAction(
              returnValue: PreRatingDialogDecision.no,
              actionText: loc.no,
            ),
            CustomDialogAction(
              returnValue: PreRatingDialogDecision.cancel,
              isDestructiveAction: true,
              actionText: loc.cancel,
            ),
          ],
          title: Text(loc.pre_rating_title),
          message: Text(loc.pre_rating_message),
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
    final loc = AppLocalizations.of(context);
    return await PopupService.showSelectionPopup<BadRatingDialogDecision>(
          context: context,
          title: Text(loc.bad_rating_title),
          message: Text(loc.bad_rating_message),
          actions: [
            CustomDialogAction(
              actionText: loc.contact_email,
              returnValue: BadRatingDialogDecision.email,
            ),
            CustomDialogAction(
              actionText: loc.cancel,
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
    final loc = AppLocalizations.of(context);
    return await PopupService.showSelectionPopup<bool>(
          context: context,
          title: Text(loc.delete_game_title),
          message: Text(loc.delete_game_message(gameTitle)),
          actions: [
            CustomDialogAction(
              returnValue: false,
              isDefaultAction: true,
              actionText: loc.cancel,
            ),
            CustomDialogAction(
              isDestructiveAction: true,
              returnValue: true,
              actionText: loc.delete,
            ),
          ],
        ) ??
        false;
  }
}
