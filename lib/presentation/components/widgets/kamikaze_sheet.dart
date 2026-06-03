import 'dart:io';

import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A widget that displays a bottom sheet for selecting a player who has Kamikaze.
/// The sheet adapts its UI based on the platform (iOS or Android) to provide a native experience.
///
/// [gameSession] is the current game session containing the list of players.
///
class KamikazeSheet extends StatelessWidget {
  final GameSession gameSession;

  const KamikazeSheet({super.key, required this.gameSession});

  /// Displays a bottom sheet for selecting a player with Kamikaze.
  /// The sheet adapts its UI based on the platform (iOS or Android).
  static Future<int?> show(
    BuildContext context,
    GameSession gameSession,
  ) async {
    if (Platform.isIOS) {
      return await showCupertinoModalPopup<int?>(
        context: context,
        builder: (context) => KamikazeSheet(gameSession: gameSession),
      );
    } else {
      return await showModalBottomSheet<int?>(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        showDragHandle: true,
        backgroundColor: CustomTheme.mainElementColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => KamikazeSheet(gameSession: gameSession),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _buildIosSheet(context);
    } else {
      return _buildAndroidSheet(context);
    }
  }

  /// Builds the iOS-style action sheet for selecting a player with Kamikaze.
  Widget _buildIosSheet(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return CupertinoActionSheet(
      title: Text(loc.kamikaze),
      message: Text(loc.who_has_kamikaze),
      actions: gameSession.players.asMap().entries.map((entry) {
        final index = entry.key;
        final player = entry.value;
        return CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context, index),
          child: Text(
            player.name,
            style: const TextStyle(color: CustomTheme.kamikazeColor),
          ),
        );
      }).toList(),
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context, null),
        isDestructiveAction: true,
        child: Text(loc.cancel),
      ),
    );
  }

  /// Builds the Android-style bottom sheet for selecting a player with Kamikaze.
  Widget _buildAndroidSheet(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            loc.kamikaze,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              loc.who_has_kamikaze,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(indent: 40, endIndent: 40),
          ...gameSession.players.asMap().entries.map((entry) {
            final index = entry.key;
            final player = entry.value;
            return ListTile(
              title: Text(
                player.name,
                style: const TextStyle(
                  color: CustomTheme.kamikazeColor,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () => Navigator.pop(context, index),
            );
          }),
          ListTile(
            title: Text(
              loc.cancel,
              style: const TextStyle(color: CustomTheme.red, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            onTap: () => Navigator.pop(context, null),
          ),
        ],
      ),
    );
  }
}
