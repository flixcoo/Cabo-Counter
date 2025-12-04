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
  String get games => 'Games';

  @override
  String get gamemode => 'Gamemode';

  @override
  String get ok => 'OK';

  @override
  String get player => 'Player';

  @override
  String get players => 'Players';

  @override
  String get name => 'Name';

  @override
  String get date => 'Datum';

  @override
  String get back => 'Back';

  @override
  String get home => 'Home';

  @override
  String get about => 'About';

  @override
  String get licenses => 'Licenses';

  @override
  String get license_details => 'License Details';

  @override
  String get no_license_text => 'No license available';

  @override
  String get legal_notice => 'Legal Notice';

  @override
  String get support_me => 'Support Me';

  @override
  String get empty_text_1 => 'Pretty empty here...';

  @override
  String get empty_text_2 =>
      'Create a new game using the button in the top right.';

  @override
  String get empty_filter_text => 'Adjust the filter options to see all games.';

  @override
  String get empty_filter_button => 'Show all games';

  @override
  String get sort_and_filter_options => 'Sort & Filter Options';

  @override
  String get ascending => 'Ascending';

  @override
  String get descending => 'Descending';

  @override
  String get only_active_games => 'Only active games are shown';

  @override
  String get only_active_game_title => 'Only active games';

  @override
  String get only_active_games_description => 'Finished games will be hidden.';

  @override
  String get delete_game_title => 'Delete game?';

  @override
  String delete_game_message(String gameTitle) {
    return 'Are you sure you want to delete the game \"$gameTitle\"? This action cannot be undone.';
  }

  @override
  String get pre_rating_title => 'Do you like the app?';

  @override
  String get pre_rating_message =>
      'Feedback helps me to continuously improve the app. Thank you!';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get bad_rating_title => 'Not satisfied?';

  @override
  String get bad_rating_message =>
      'Feel free to send me an email directly so we can solve your problem!';

  @override
  String get contact_email => 'Contact via E-Mail';

  @override
  String get email_subject => 'Feedback: Cabo Counter App';

  @override
  String get email_body => 'I have the following feedback...';

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
  String get max_players_title => 'Player Limit Reached';

  @override
  String get max_players_message => 'You can add a maximum of 5 players.';

  @override
  String get no_mode_title => 'Game Mode Required';

  @override
  String get no_mode_message => 'Please select a game mode to continue';

  @override
  String get min_players_title => 'Too Few Players';

  @override
  String get min_players_message =>
      'At least 2 players are required to start the game.';

  @override
  String get no_name_title => 'Missing Player Names';

  @override
  String get no_name_message => 'Each player must have a name.';

  @override
  String get select_game_mode => 'Select game mode';

  @override
  String get no_mode_selected => 'No mode selected';

  @override
  String get no_default_mode => 'No default mode';

  @override
  String get no_default_description => 'The default mode gets reset.';

  @override
  String point_limit_description(int pointLimit) {
    return 'The game ends when a player scores more than $pointLimit points.';
  }

  @override
  String get unlimited_description =>
      'The game continues until you decide to stop playing. The game can be ended manually at any time.';

  @override
  String standard_game_title(Object date) {
    return 'Game on $date';
  }

  @override
  String get results => 'Results';

  @override
  String get who_said_cabo => 'Who called Cabo?';

  @override
  String get kamikaze => 'Kamikaze';

  @override
  String get who_has_kamikaze => 'Who has Kamikaze?';

  @override
  String get dealer => 'Dealer';

  @override
  String get done => 'Done';

  @override
  String get next_round => 'Next Round';

  @override
  String get bonus_points_title => 'Bonus-Points!';

  @override
  String bonus_points_message(
      int playerCount, String names, int pointLimit, int bonusPoints) {
    String _temp0 = intl.Intl.pluralLogic(
      playerCount,
      locale: localeName,
      other:
          '$names have reached exactly the point limit of $pointLimit points and therefore get $bonusPoints points deducted!',
      one:
          '$names has reached exactly the point limit of $pointLimit points and therefore gets $bonusPoints points deducted!',
    );
    return '$_temp0';
  }

  @override
  String get end_of_game_title => 'End of Game';

  @override
  String end_of_game_message(int playerCount, String names, int points) {
    String _temp0 = intl.Intl.pluralLogic(
      playerCount,
      locale: localeName,
      other:
          '$names won the game with $points points. Congratulations to everyone!',
      one: '$names won the game with $points points. Congratulations!',
    );
    return '$_temp0';
  }

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
  String get statistics => 'Statistics';

  @override
  String get point_overview => 'Point Overview';

  @override
  String get scoring_history => 'Scoring History';

  @override
  String get empty_graph_text =>
      'You must play at least one round for the game progress graph to be displayed.';

  @override
  String get settings => 'Settings';

  @override
  String get cabo_penalty => 'Cabo Penalty';

  @override
  String get point_limit => 'Point Limit';

  @override
  String get standard_mode => 'Default Mode';

  @override
  String get rotate_shuffler => 'Rotate Shuffler';

  @override
  String get shuffler_rotation_info =>
      'By default, the person who lost the last round shuffles. Enable this option to rotate the role each round in game order.';

  @override
  String get reset_to_default => 'Reset to Default';

  @override
  String get reset_config_title => 'Reset Settings';

  @override
  String get reset_config_message => 'Do you want to reset your settings?';

  @override
  String get config_change_info =>
      'Changed values only apply to newly created games. Existing games retain their original settings.';

  @override
  String get reset => 'Reset';

  @override
  String get game_data => 'Game Data';

  @override
  String get import_data => 'Import Data';

  @override
  String get export_data => 'Export Data';

  @override
  String get delete_data => 'Delete all Game Data';

  @override
  String get delete_data_title => 'Delete game data?';

  @override
  String get delete_data_message =>
      'Are you sure you want to delete all game data? This action cannot be undone.';

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
  String get report_error => 'Report a bug';

  @override
  String get mail_developer => 'E-Mail the Developer';

  @override
  String get app_version => 'App Version';

  @override
  String get privacy_policy => 'Privacy Policy';

  @override
  String get loading_games => 'Loading Games ...';

  @override
  String get build => 'Build No.';

  @override
  String get whats_new => 'What\'s new';

  @override
  String get wn_item_1 => 'Dealer';

  @override
  String get wn_description_1 =>
      'The round overview shows who is dealing. In the settings, you can specify whether the previous loser deals by default or whether dealing rotates.';

  @override
  String get wn_item_2 => 'Improved navigation';

  @override
  String get wn_description_2 =>
      'Chevrons have been added to make navigation clearer and more intuitive.';
}
