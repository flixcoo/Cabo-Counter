import 'dart:core';

import 'package:cabo_counter/core/adaptive_page_route.dart';
import 'package:cabo_counter/core/adaptive_sheet_route.dart';
import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/models/game_session.dart';
import 'package:cabo_counter/data/models/player.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/placeholders/empty_filter_placeholder.dart';
import 'package:cabo_counter/presentation/components/placeholders/empty_games_placeholder.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/animated_icon_button.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/floating_animated_button.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_dialog_action.dart';
import 'package:cabo_counter/presentation/components/widgets/sorting_sheet.dart';
import 'package:cabo_counter/presentation/components/widgets/tiles/game_tile.dart';
import 'package:cabo_counter/presentation/views/home/active_game/active_game_view.dart';
import 'package:cabo_counter/presentation/views/home/create_game/create_game_view.dart';
import 'package:cabo_counter/presentation/views/home/news_view/news_view.dart';
import 'package:cabo_counter/presentation/views/home/settings_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/popup_service.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';
import 'package:once/once.dart';
import 'package:provider/provider.dart';
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
      title: 'Skeleton session',
      players: [
        Player(name: 'Player 1', gameSessionId: '', position: 0),
        Player(name: 'Player 2', gameSessionId: '', position: 1),
        Player(name: 'Player 3', gameSessionId: '', position: 2),
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
      title: 'Skeleton session',
      players: [
        Player(name: 'Player 1', gameSessionId: '', position: 0),
        Player(name: 'Player 2', gameSessionId: '', position: 1),
        Player(name: 'Player 3', gameSessionId: '', position: 2),
      ],
      pointLimit: 100,
      caboPenalty: 5,
      isPointsLimitEnabled: true,
    ),
  );

  // Sorting & fiilter
  SortOption currentSortOption = ConfigService.getSortingOption();
  SortDirection currentSortDirection = ConfigService.getSortingDirection();
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

      showRatingDialog();
      showNewsView(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
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
        leading: AnimatedIconButton(
          onPressed: () {
            Navigator.push(
              context,
              adaptivePageRoute(
                builder: (context) =>
                    SettingsView(onSessionsUpdated: loadSessions),
              ),
            );
          },
          icon: IconService.settings,
        ),
        title: Text(loc.games),
        actions: [sortingButton()],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            sessions.isEmpty
                ? const EmptyGamesPlaceholder()
                : displaySessions.isEmpty
                ? EmptyFilterPlaceholder(
                    toggleShowOnlyActiveGames: toggleShowOnlyActiveGames,
                  )
                : Skeletonizer(
                    enabled: isLoading,
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.paddingOf(context).bottom + 80,
                      ),
                      itemCount:
                          displaySessions.length +
                          (showOnlyActiveGames ? 1 : 0),
                      itemBuilder: (context, index) {
                        // Show info about active games filter at the end of the list
                        if (showOnlyActiveGames &&
                            index == displaySessions.length) {
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
                          return Padding(
                            padding: const EdgeInsets.all(6),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 20.0,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(
                                          IconService.delete,
                                          color: CustomTheme.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Dismissible(
                                  key: Key(session.id),
                                  direction: DismissDirection.endToStart,
                                  confirmDismiss: (direction) async {
                                    return await showDeleteGamePopup(
                                      context,
                                      session.title,
                                    );
                                  },
                                  onDismissed: (direction) {
                                    setState(() {
                                      deleteSession(
                                        session.id,
                                        Provider.of<AppDatabase>(
                                          context,
                                          listen: false,
                                        ),
                                      );
                                    });
                                  },
                                  dismissThresholds: const {
                                    DismissDirection.endToStart: 0.6,
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: GameTile(
                                      session: session,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          adaptivePageRoute(
                                            builder: (context) =>
                                                ActiveGameView(
                                                  gameSession: session,
                                                  onSessionsUpdated:
                                                      loadSessions,
                                                ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
            Positioned(
              bottom: MediaQuery.paddingOf(context).bottom + 10,
              child: FloatingAnimatedButton(
                text: loc.new_game,
                onPressed: () => Navigator.push(
                  context,
                  adaptivePageRoute(
                    builder: (context) => CreateGameView(
                      gameMode: ConfigService.getGameMode(),
                      onSessionsUpdated: loadSessions,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadSessions() {
    setState(() => isLoading = true);

    final db = Provider.of<AppDatabase>(context, listen: false);

    Future.wait([
      db.gameSessionDao.getAllGameSessions(),
      Future.delayed(
        const Duration(
          milliseconds: Constants.MINIMUM_SKELETON_SCREEN_DURATION,
        ),
      ),
    ]).then((results) {
      final loadedSessions = results[0] as List<GameSession>;
      sessions = [...loadedSessions]
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      if (mounted) {
        setState(() {
          displaySessions = [...sessions];
          isLoading = false;
        });
      }
    });
  }

  /// Deletes a game session with the given [gameId] from the local list and the database.
  Future<void> deleteSession(String gameId, AppDatabase db) async {
    sessions = sessions..removeWhere((session) => session.id == gameId);
    sortGames(
      sortOption: currentSortOption,
      sortDirection: currentSortDirection,
    );
    await db.gameSessionDao.deleteGameSession(gameId: gameId);
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
            return normalize(a.title).compareTo(normalize(b.title));
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
  void showNewsView(BuildContext context) {
    Once.runOnEveryNewVersion(
      key: 'whats_new_dialog',
      callback: () {
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context)
              .push(adaptiveSheetRoute(builder: (context) => const NewsView()));
        });
      },
    );
  }

  Future<void> showRatingDialog() async {
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
  }

  Widget sortingButton() {
    return AnimatedIconButton(
      onPressed: () {
        VibrationService.selectionClick();
        SortingSheet.show(
          context,
          currentSortOption: currentSortOption,
          currentSortDirection: currentSortDirection,
          showOnlyActiveGames: showOnlyActiveGames,
          onOptionChanged: (newSortingOption) =>
              setSortOption(newSortingOption),
          onDirectionChanged: (newSortingDirection) =>
              setSortDirection(newSortingDirection),
          onFilterChanged: () => toggleShowOnlyActiveGames(),
        );
      },
      icon: IconService.sort,
    );
  }
}
