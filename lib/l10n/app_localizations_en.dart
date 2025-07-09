// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Cabo Counter';

  @override
  String get round => 'Round';

  @override
  String get rounds => 'Rounds';

  @override
  String get mode => 'Mode';

  @override
  String get points => 'Points';

  @override
  String get unlimited => 'Unlimited';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get game => 'Game';

  @override
  String get ok => 'OK';

  @override
  String get player => 'Player';

  @override
  String get players => 'Players';

  @override
  String get name => 'Name';

  @override
  String get back => 'Back';

  @override
  String get home => 'Home';

  @override
  String get about => 'About';

  @override
  String get empty_text_1 => 'Pretty empty here...';

  @override
  String get empty_text_2 =>
      'Add a new round using the button in the top right corner.';

  @override
  String get delete_game_title => 'Delete game?';

  @override
  String delete_game_message(String gameTitle) {
    return 'Are you sure you want to delete the game \"$gameTitle\"? This action cannot be undone.';
  }

  @override
  String get overview => 'Overview';

  @override
  String get new_game => 'New Game';

  @override
  String get game_title => 'Game Title';

  @override
  String get select_mode => 'Select a mode';

  @override
  String get add_player => 'Add Player';

  @override
  String get create_game => 'Create Game';

  @override
  String get max_players_title => 'Maximum reached';

  @override
  String get max_players_message => 'A maximum of 5 players can be added.';

  @override
  String get no_gameTitle_title => 'No Title';

  @override
  String get no_gameTitle_message => 'You must enter a title for the game.';

  @override
  String get no_mode_title => 'No Mode';

  @override
  String get no_mode_message => 'You must select a game mode.';

  @override
  String get min_players_title => 'Too few players';

  @override
  String get min_players_message => 'At least 2 players must be added.';

  @override
  String get no_name_title => 'No Name';

  @override
  String get no_name_message => 'Each player must have a name.';

  @override
  String get select_game_mode => 'Select game mode';

  @override
  String point_limit_description(int pointLimit) {
    return 'The game ends when a player reaches more than $pointLimit points.';
  }

  @override
  String get unlimited_description =>
      'There is no limit. The game continues until you decide to stop.';

  @override
  String get results => 'Results';

  @override
  String get who_said_cabo => 'Who said CABO?';

  @override
  String get kamikaze => 'Kamikaze';

  @override
  String get done => 'Done';

  @override
  String get next_round => 'Next Round';

  @override
  String get statistics => 'Statistics';

  @override
  String get end_game => 'End Game';

  @override
  String get delete_game => 'Delete Game';

  @override
  String get new_game_same_settings => 'New Game with same Settings';

  @override
  String get export_game => 'Export Game';

  @override
  String get id_error_title => 'ID Error';

  @override
  String get id_error_message =>
      'The game has not yet been assigned an ID. If you want to delete the game, please do so via the main menu. All newly created games have an ID.';

  @override
  String get end_game_title => 'End the game?';

  @override
  String get end_game_message =>
      'Do you want to end the game? The game gets marked as finished and cannot be continued.';

  @override
  String get game_process => 'Spielverlauf';

  @override
  String get settings => 'Settings';

  @override
  String get cabo_penalty => 'Cabo Penalty';

  @override
  String get cabo_penalty_subtitle => '... for falsely calling Cabo.';

  @override
  String get point_limit => 'Point Limit';

  @override
  String get point_limit_subtitle => '... the game ends here.';

  @override
  String get reset_to_default => 'Reset to Default';

  @override
  String get game_data => 'Game Data';

  @override
  String get import_data => 'Import Data';

  @override
  String get export_data => 'Export Data';

  @override
  String get app => 'App';

  @override
  String get import_success_title => 'Import successful';

  @override
  String get import_success_message =>
      'The game data has been successfully imported.';

  @override
  String get import_validation_error_title => 'Validation failed';

  @override
  String get import_validation_error_message =>
      'No Cabo-Counter game data was found. Please make sure that this is a valid Cabo-Counter export file.';

  @override
  String get import_format_error_title => 'Wrong format';

  @override
  String get import_format_error_message =>
      'The file is not a valid JSON format or contains invalid data.';

  @override
  String get import_generic_error_title => 'Import failed';

  @override
  String get import_generic_error_message => 'The import has failed.';

  @override
  String get export_error_title => 'Export failed';

  @override
  String get export_error_message => 'Could not export file';

  @override
  String get error_found => 'Found a bug?';

  @override
  String get create_issue => 'Create Issue';

  @override
  String get wiki => 'Wiki';

  @override
  String get app_version => 'App Version';

  @override
  String get build => 'Build No.';

  @override
  String get loading => 'Loading...';

  @override
  String get about_text =>
      'Hey :) Thanks for being one of the first users of my app! I’ve put a lot of work into this project, and even though I tried to think of everything, it might not work perfectly just yet. So if you discover any bugs or have feedback on the design or usability, please let me know via the TestFlight app or by sending me a message or email. Thank you very much!';
}
