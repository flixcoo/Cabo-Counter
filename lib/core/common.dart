import 'package:cabo_counter/l10n/generated/app_localizations.dart';

String getPointLabel(AppLocalizations loc, int points) {
  if (points == 1 || points == -1) {
    return '$points ${loc.point}';
  } else {
    return '$points ${loc.points}';
  }
}

extension FilenameSanitization on String {
  /// Sanitizes a string to be used as a filename.
  ///
  /// Replaces spaces with underscores, normalizes German umlauts,
  /// and removes any characters that are not alphanumeric, dots, underscores, or hyphens.
  /// If the resulting string is empty, returns the [fallback].
  String toSafeFilename({String fallback = 'game_session'}) {
    final sanitized = replaceAll(' ', '_')
        .replaceAll('ä', 'ae')
        .replaceAll('ö', 'oe')
        .replaceAll('ü', 'ue')
        .replaceAll('Ä', 'Ae')
        .replaceAll('Ö', 'Oe')
        .replaceAll('Ü', 'Ue')
        .replaceAll('ß', 'ss')
        .replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '');

    return sanitized.isEmpty ? fallback : sanitized;
  }
}
