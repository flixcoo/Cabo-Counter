// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get app_name => 'Cabo Counter';

  @override
  String get round => 'Runde';

  @override
  String get rounds => 'Runden';

  @override
  String get mode => 'Modus';

  @override
  String get points => 'Punkte';

  @override
  String get unlimited => 'Unbegrenzt';

  @override
  String get delete => 'Löschen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get game => 'Spiel';

  @override
  String get ok => 'OK';

  @override
  String get player => 'Spieler:in';

  @override
  String get players => 'Spieler:innen';

  @override
  String get name => 'Name';

  @override
  String get back => 'Zurück';

  @override
  String get home => 'Home';

  @override
  String get about => 'Über';

  @override
  String get empty_text_1 => 'Ganz schön leer hier...';

  @override
  String get empty_text_2 =>
      'Füge über den Button oben rechts eine neue Runde hinzu';

  @override
  String get delete_game_title => 'Spiel löschen?';

  @override
  String delete_game_message(String gameTitle) {
    return 'Bist du sicher, dass du das Spiel \"$gameTitle\" löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String get pre_rating_title => 'Gefällt dir die App?';

  @override
  String get pre_rating_message =>
      'Feedback hilft mir, die App zu verbessern. Vielen Dank!';

  @override
  String get yes => 'Ja';

  @override
  String get no => 'Nein';

  @override
  String get bad_rating_title => 'Unzufrieden mit der App?';

  @override
  String get bad_rating_message =>
      'Schreib mir gerne direkt eine E-Mail, damit wir dein Problem lösen können!';

  @override
  String get contact_email => 'E-Mail schreiben';

  @override
  String get email_subject => 'Feedback: Cabo Counter App';

  @override
  String get email_body => 'Ich habe folgendes Feedback...';

  @override
  String get overview => 'Übersicht';

  @override
  String get new_game => 'Neues Spiel';

  @override
  String get game_title => 'Titel des Spiels';

  @override
  String get select_mode => 'Wähle einen Modus';

  @override
  String get add_player => 'Spieler:in hinzufügen';

  @override
  String get create_game => 'Spiel erstellen';

  @override
  String get max_players_title => 'Maximale Anzahl erreicht';

  @override
  String get max_players_message =>
      'Es können maximal 5 Spieler:innen hinzugefügt werden.';

  @override
  String get no_gameTitle_title => 'Kein Titel';

  @override
  String get no_gameTitle_message =>
      'Es muss ein Titel für das Spiel eingegeben werden.';

  @override
  String get no_mode_title => 'Kein Modus';

  @override
  String get no_mode_message => 'Es muss ein Spielmodus ausgewählt werden.';

  @override
  String get min_players_title => 'Zu wenig Spieler:innen';

  @override
  String get min_players_message =>
      'Es müssen mindestens 2 Spieler:innen hinzugefügt werden';

  @override
  String get no_name_title => 'Kein Name';

  @override
  String get no_name_message => 'Jeder Spieler muss einen Namen haben.';

  @override
  String get select_game_mode => 'Spielmodus auswählen';

  @override
  String point_limit_description(int pointLimit) {
    return 'Es wird so lange gespielt, bis ein:e Spieler:in mehr als $pointLimit Punkte erreicht';
  }

  @override
  String get unlimited_description =>
      'Dem Spiel sind keine Grenzen gesetzt. Es wird so lange gespielt, bis ihr keine Lust mehr habt.';

  @override
  String get results => 'Ergebnisse';

  @override
  String get who_said_cabo => 'Wer hat CABO gesagt?';

  @override
  String get kamikaze => 'Kamikaze';

  @override
  String get done => 'Fertig';

  @override
  String get next_round => 'Nächste Runde';

  @override
  String get bonus_points_title => 'Bonus-Punkte!';

  @override
  String bonus_points_message(
      int playerCount, String names, int pointLimit, int bonusPoints) {
    String _temp0 = intl.Intl.pluralLogic(
      playerCount,
      locale: localeName,
      other:
          '$names haben exakt das Punktelimit von $pointLimit Punkten erreicht und bekommen deshalb jeweils $bonusPoints Punkte abgezogen!',
      one:
          '$names hat exakt das Punktelimit von $pointLimit Punkten erreicht und bekommt deshalb $bonusPoints Punkte abgezogen!',
    );
    return '$_temp0';
  }

  @override
  String get end_game => 'Spiel beenden';

  @override
  String get delete_game => 'Spiel löschen';

  @override
  String get new_game_same_settings => 'Neues Spiel mit gleichen Einstellungen';

  @override
  String get export_game => 'Spiel exportieren';

  @override
  String get id_error_title => 'ID Fehler';

  @override
  String get id_error_message =>
      'Das Spiel hat bisher noch keine ID zugewiesen bekommen. Falls du das Spiel löschen möchtest, mache das bitte über das Hauptmenü. Alle neu erstellten Spiele haben eine ID.';

  @override
  String get end_game_title => 'Spiel beenden?';

  @override
  String get end_game_message =>
      'Möchtest du das Spiel beenden? Das Spiel wird als beendet markiert und kann nicht fortgeführt werden.';

  @override
  String get table => 'Punkteübersicht';

  @override
  String get game_process => 'Spielverlauf';

  @override
  String get empty_graph_text =>
      'Du musst mindestens eine Runde spielen, damit der Graph des Spielverlaufes angezeigt werden kann.';

  @override
  String get settings => 'Einstellungen';

  @override
  String get cabo_penalty => 'Cabo-Strafe';

  @override
  String get cabo_penalty_subtitle => '... für falsches Cabo sagen';

  @override
  String get point_limit => 'Punkte-Limit';

  @override
  String get point_limit_subtitle => '... hier ist Schluss';

  @override
  String get reset_to_default => 'Auf Standard zurücksetzen';

  @override
  String get game_data => 'Spieldaten';

  @override
  String get import_data => 'Spieldaten importieren';

  @override
  String get export_data => 'Spieldaten exportieren';

  @override
  String get delete_data => 'Alle Spieldaten löschen';

  @override
  String get delete_data_title => 'Spieldaten löschen?';

  @override
  String get delete_data_message =>
      'Bist du sicher, dass du alle Spieldaten löschen möchtest? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get app => 'App';

  @override
  String get import_success_title => 'Import erfolgreich';

  @override
  String get import_success_message =>
      'Die Spieldaten wurden erfolgreich importiert.';

  @override
  String get import_validation_error_title => 'Validierung fehlgeschlagen';

  @override
  String get import_validation_error_message =>
      'Es wurden keine Cabo-Counter Spieldaten gefunden. Bitte stellen Sie sicher, dass es sich um eine gültige Cabo-Counter Exportdatei handelt.';

  @override
  String get import_format_error_title => 'Falsches Format';

  @override
  String get import_format_error_message =>
      'Die Datei ist kein gültiges JSON-Format oder enthält ungültige Daten.';

  @override
  String get import_generic_error_title => 'Import fehlgeschlagen';

  @override
  String get import_generic_error_message => 'Der Import ist fehlgeschlagen.';

  @override
  String get export_error_title => 'Fehler';

  @override
  String get export_error_message => 'Datei konnte nicht exportiert werden';

  @override
  String get error_found => 'Fehler gefunden?';

  @override
  String get create_issue => 'Issue erstellen';

  @override
  String get wiki => 'Wiki';

  @override
  String get app_version => 'App-Version';

  @override
  String get privacy_policy => 'Datenschutzerklärung';

  @override
  String get build => 'Build-Nr.';

  @override
  String get loading => 'Lädt...';

  @override
  String get about_text =>
      'Hey :) Danke, dass du als eine:r der ersten User meiner ersten eigenen App dabei bist! Ich hab sehr viel Arbeit in dieses Projekt gesteckt und auch, wenn ich (hoffentlich) an vieles Gedacht hab, wird auf jeden Fall noch nicht alles 100% funktionieren. Solltest du also irgendwelche Fehler entdecken oder Feedback zum Design oder der Benutzerfreundlichkeit haben, teile Sie mir gern über die Testflight App oder auf den dir bekannten Wegen mit. Danke! ';
}
