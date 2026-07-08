import 'dart:core';

import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/data/dto/player.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/placeholders/empty_filter_placeholder.dart';
import 'package:cabo_counter/presentation/components/placeholders/empty_games_placeholder.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/main_menu_button.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/opacity_button.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/sorting_button.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_dialog_action.dart';
import 'package:cabo_counter/presentation/components/widgets/tiles/game_tile.dart';
import 'package:cabo_counter/presentation/components/widgets/whats_new/whats_new_dialog.dart';
import 'package:cabo_counter/presentation/views/home/create_game/create_game_view.dart';
import 'package:cabo_counter/presentation/views/home/settings_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/popup_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:once/once.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

/// Home screen of the app that displays a list of game sessions.
///
/// The [HomeView] is the main entry point for the app's home screen.
/// It displays a list of existing game sessions, allows users to create new games,
/// access settings, and handles user feedback dialogs for app rating and support.
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = true;

  List<GameSession> sessions = List.filled(
    10,
    GameSession(
      createdAt: DateTime.now(),
      gameTitle: 'Skeleton session',
      players: [
        Player(name: 'Player 1', gameId: '', position: 0),
        Player(name: 'Player 2', gameId: '', position: 1),
        Player(name: 'Player 3', gameId: '', position: 2),
      ],
      pointLimit: 100,
      caboPenalty: 5,
      isPointsLimitEnabled: true,
    ),
  );

  /// The sessions filtered and sorted for display based on the current sorting
  /// options and filters.
  List<GameSession> displaySessions = List.filled(
    10,
    GameSession(
      createdAt: DateTime.now(),
      gameTitle: 'Skeleton session',
      players: [
        Player(name: 'Player 1', gameId: '', position: 0),
        Player(name: 'Player 2', gameId: '', position: 1),
        Player(name: 'Player 3', gameId: '', position: 2),
      ],
      pointLimit: 100,
      caboPenalty: 5,
      isPointsLimitEnabled: true,
    ),
  );

  /// Current sorting option for the game list
  SortOption currentSortOption = ConfigService.getSortingOption();

  /// Current sorting direction for the game list
  SortDirection currentSortDirection = ConfigService.getSortingDirection();

  /// If true, only active (unfinished) games are shown in the list
  bool showOnlyActiveGames = ConfigService.getShowActiveGamesOnly();

  @override
  initState() {
    super.initState();

    loadSessions();

    // Caching app image
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      precacheImage(
        const AssetImage('assets/cabo_counter-logo_rounded.png'),
        context,
      );

      // Rating dialog
      await Constants.rateMyApp.init();
      if (Constants.rateMyApp.shouldOpenDialog) {
        await Future.delayed(
          const Duration(
            milliseconds: Constants.MINIMUM_SKELETON_SCREEN_DURATION + 200,
          ),
        );
        if (!mounted) return;
        handleFeedbackDialog(context);
      }

      // Whats new dialog
      Once.runOnEveryNewVersion(
        key: 'whats_new_dialog',
        callback: () {
          showWhatsNewDialog(context);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    sortGames(
      sortOption: currentSortOption,
      sortDirection: currentSortDirection,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: OpacityButton.icon(
          size: Constants.NAVBAR_ICON_SIZE,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) =>
                    SettingsView(onSessionsUpdated: loadSessions),
              ),
            );
          },
          icon: IconService.settings,
        ),
        title: Text(loc.games),
        actions: [
          SortingButton(
            currentSortOption: currentSortOption,
            currentSortDirection: currentSortDirection,
            showOnlyActiveGames: showOnlyActiveGames,
            onSortOptionChanged: (newSortingOption) =>
                setSortOption(newSortingOption),
            onSortDirectionChanged: (newSortingDirection) =>
                setSortDirection(newSortingDirection),
            onShowOnlyActiveGamesChanged: () => toggleShowOnlyActiveGames(),
          ),
        ],
      ),
      floatingActionButton: MainMenuButton(
        onPressed: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => CreateGameView(
              gameMode: ConfigService.getGameMode(),
              previousPageTitle: loc.games,
            ),
          ),
        ),
        icon: IconService.add,
      ),
      body: SafeArea(
        child: Visibility(
          visible: sessions.isEmpty,
          replacement: Visibility(
            visible: displaySessions.isEmpty,
            replacement: Skeletonizer(
              enabled: isLoading,
              child: ListView.builder(
                itemCount:
                    displaySessions.length + (showOnlyActiveGames ? 1 : 0),
                itemBuilder: (context, index) {
                  // Show info about active games filter at the end of the list
                  if (showOnlyActiveGames && index == displaySessions.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 30),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              IconService.visibility_off,
                              color: CustomTheme.white.withAlpha(150),
                              size: 16.0,
                            ),
                            const SizedBox(width: 6.0),
                            Text(
                              loc.only_active_games,
                              style: TextStyle(
                                color: CustomTheme.white.withAlpha(150),
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    final session = displaySessions[index];
                    return ListenableBuilder(
                      listenable: session,
                      builder: (context, _) {
                        return Dismissible(
                          key: Key(session.gameId),
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Icon(
                              IconService.delete,
                              color: CustomTheme.red,
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) async {
                            return await showDeleteGamePopup(
                              context,
                              session.gameTitle,
                            );
                          },
                          onDismissed: (direction) {
                            setState(() {
                              deleteSession(session.gameId);
                            });
                          },
                          dismissThresholds: const {
                            DismissDirection.startToEnd: 0.6,
                          },
                          child: GameTile(session: session),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            child: EmptyFilterPlaceholder(
              toggleShowOnlyActiveGames: toggleShowOnlyActiveGames,
            ),
          ),
          child: const EmptyGamesPlaceholder(),
        ),
      ),
    );
  }

  void loadSessions() {
    isLoading = true;

    Future.wait([
      databaseInstance.gameSessionDao.getAllGameSessions(),
      Future.delayed(
        const Duration(
          milliseconds: Constants.MINIMUM_SKELETON_SCREEN_DURATION,
        ),
      ),
    ]).then((results) {
      if (mounted) {
        setState(() {
          final loadedSessions = results[0] as List<GameSession>;
          sessions = [...loadedSessions]
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
          displaySessions = [...sessions];
          isLoading = false;
        });
      }
    });
  }

  /// Deletes a game session with the given [gameId] from the local list and the database.
  Future<void> deleteSession(String gameId) async {
    sessions = sessions..removeWhere((session) => session.gameId == gameId);
    sortGames(
      sortOption: currentSortOption,
      sortDirection: currentSortDirection,
    );
    await databaseInstance.gameSessionDao.deleteGameSession(gameId: gameId);
  }

  /// Handles the feedback dialog when the conditions for rating are met.
  /// It shows a dialog asking the user if they like the app,
  /// and based on their response, it either opens the rating dialog or an email client for feedback.
  Future<void> handleFeedbackDialog(BuildContext context) async {
    final loc = AppLocalizations.of(context);
    final emailSubject = loc.email_subject;
    final emailBody = loc.email_body;

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: Constants.CONTACT_EMAIL,
      query:
          'subject=$emailSubject'
          '&body=$emailBody',
    );

    PreRatingDialogDecision preRatingDecision =
        await PopupService.showPreRatingDialog(context);
    BadRatingDialogDecision badRatingDecision = BadRatingDialogDecision.cancel;

    // so that the bad rating dialog is not shown immediately
    await Future.delayed(const Duration(milliseconds: Constants.POP_UP_DELAY));

    switch (preRatingDecision) {
      case PreRatingDialogDecision.yes:
        if (context.mounted) Constants.rateMyApp.showStarRateDialog(context);
        break;
      case PreRatingDialogDecision.no:
        if (context.mounted) {
          badRatingDecision = await PopupService.showBadRatingDialog(context);
        }
        if (badRatingDecision == BadRatingDialogDecision.email) {
          if (context.mounted) {
            launchUrl(emailUri);
          }
        }
        break;
      case PreRatingDialogDecision.cancel:
        break;
    }
  }

  /// Shows a confirmation dialog to delete all game sessions.
  /// Returns true if the user confirms the deletion, false otherwise.
  /// [gameTitle] is the title of the game session to be deleted.
  static Future<bool> showDeleteGamePopup(
    BuildContext context,
    String gameTitle,
  ) async {
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

  /// Sorts the game list based on the provided sort option and direction.
  /// Updates the configuration service with the new sorting preferences.
  /// [sortOption] The option to sort by (date or title).
  /// [sortDirection] The direction to sort (ascending or descending).
  void sortGames({
    required SortOption sortOption,
    required SortDirection sortDirection,
  }) {
    displaySessions = showOnlyActiveGames
        ? sessions.where((game) => !game.isGameFinished).toList()
        : List.from(sessions);

    final compare = sortOption == SortOption.date
        ? (a, b) => a.createdAt.compareTo(b.createdAt)
        : (a, b) {
            // Normalize strings for consistent comparison, handling special characters
            String normalize(String s) => s
                .toLowerCase()
                .replaceAll('ä', 'a~')
                .replaceAll('ö', 'o~')
                .replaceAll('ü', 'u~')
                .replaceAll('ß', 'ss~');
            return normalize(a.gameTitle).compareTo(normalize(b.gameTitle));
          };

    displaySessions.sort(
      sortDirection == SortDirection.ascending
          ? (GameSession a, GameSession b) => compare(a, b)
          : (GameSession a, GameSession b) => compare(b, a),
    );
  }

  /// Sets the current sort direction and updates the game list accordingly.
  /// [direction] The new sort direction to be set.
  void setSortDirection(SortDirection direction) {
    setState(() {
      currentSortDirection = direction;
      sortGames(sortOption: currentSortOption, sortDirection: direction);
      ConfigService.setSortingDirection(direction);
    });
  }

  /// Sets the current sort option and updates the game list accordingly.
  /// [option] The new sort option to be set.
  void setSortOption(SortOption option) {
    setState(() {
      currentSortOption = option;
      sortGames(sortOption: option, sortDirection: currentSortDirection);
      ConfigService.setSortingOption(option);
    });
  }

  /// Toggles the filter to show only active (unfinished) games in the list.
  void toggleShowOnlyActiveGames() {
    setState(() {
      showOnlyActiveGames = !showOnlyActiveGames;
      sortGames(
        sortOption: currentSortOption,
        sortDirection: currentSortDirection,
      );
    });
    ConfigService.setShowActiveGamesOnly(showOnlyActiveGames);
  }

  /// Shows the "What's New" dialog.
  void showWhatsNewDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      CupertinoPageRoute(
        builder: (context) => const WhatsNewDialog(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
