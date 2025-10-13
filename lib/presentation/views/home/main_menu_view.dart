import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/dto/game_manager.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/placeholders/empty_filter_placeholder.dart';
import 'package:cabo_counter/presentation/components/placeholders/empty_games_placeholder.dart';
import 'package:cabo_counter/presentation/components/placeholders/main_menu_skeleton.dart';
import 'package:cabo_counter/presentation/components/widgets/custom_dialog_action.dart';
import 'package:cabo_counter/presentation/components/widgets/sorting_button.dart';
import 'package:cabo_counter/presentation/views/home/active_game/active_game_view.dart';
import 'package:cabo_counter/presentation/views/home/create_game_view.dart';
import 'package:cabo_counter/presentation/views/home/settings_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/popup_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Home screen of the app that displays a list of game sessions.
///
/// The [MainMenuView] is the main entry point for the app's home screen.
/// It displays a list of existing game sessions, allows users to create new games,
/// access settings, and handles user feedback dialogs for app rating and support.
class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainMenuViewState createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  /// Indicates whether the view is currently loading data from the database
  bool _isLoading = true;

  /// Map to hold the status of data migration and amount of migrated games
  late Map<String, dynamic> migrationStatus;

  /// List of game sessions to be displayed based on sorting and filtering
  List<GameSession> displayedGames = [];

  /// Current sorting option for the game list
  SortOption currentSortOption = ConfigService.getSortingOption();

  /// Current sorting direction for the game list
  SortDirection currentSortDirection = ConfigService.getSortingDirection();

  /// If true, only active (unfinished) games are shown in the list
  bool _showOnlyActiveGames = ConfigService.getShowActiveGamesOnly();

  @override
  initState() {
    super.initState();
    db.gameSessionDao.getAllGameSessions().then((gameSessions) {
      for (final session in gameSessions) {
        gameManager.addGameSessionFromDataBase(session);
      }
      return Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        displayedGames = List.from(gameManager.gameList);
        _sortGames(
            sortOption: currentSortOption, sortDirection: currentSortDirection);
      });
    }).catchError((error) {
      print('[MainMenuView] $error');
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      precacheImage(
          const AssetImage('assets/cabo_counter-logo_rounded.png'), context);
      await Constants.rateMyApp.init();

      if (Constants.rateMyApp.shouldOpenDialog &&
          Constants.appDevPhase != 'Beta') {
        await Future.delayed(const Duration(
            milliseconds: Constants.kMinimumSkeletonScreenDuration));
        if (!mounted) return;
        _handleFeedbackDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: gameManager,
        builder: (context, _) {
          return CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: CupertinoNavigationBar(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 0,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        iconSize: Constants.navBarIconSize,
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const SettingsView(),
                            ),
                          ).then((_) {
                            setState(() {
                              _sortGames(
                                  sortOption: currentSortOption,
                                  sortDirection: currentSortDirection);
                            });
                          });
                        },
                        icon: Icon(IconService.settings)),
                    SortingButton(
                        context: context,
                        currentSortOption: currentSortOption,
                        currentSortDirection: currentSortDirection,
                        showOnlyActiveGames: _showOnlyActiveGames,
                        onSortOptionChanged: (newSortingOption) =>
                            _setSortOption(newSortingOption),
                        onSortDirectionChanged: (newSortingDirection) =>
                            _setSortDirection(newSortingDirection),
                        onShowOnlyActiveGamesChanged: () =>
                            _toggleShowOnlyActiveGames())
                  ],
                ),
                middle: Text(AppLocalizations.of(context).games),
                trailing: IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CreateGameView(
                        gameMode: ConfigService.getGameMode(),
                        previousPageTitle: AppLocalizations.of(context).games,
                      ),
                    ),
                  ).then((_) {
                    setState(() {
                      _sortGames(
                          sortOption: currentSortOption,
                          sortDirection: currentSortDirection);
                    });
                  }),
                  icon: Icon(IconService.add),
                  iconSize: Constants.navBarIconSize + 2,
                ),
              ),
              child: CupertinoPageScaffold(
                  child: SafeArea(
                child: Visibility(
                  visible: _isLoading,
                  replacement: Visibility(
                    visible: gameManager.gameList.isEmpty,
                    replacement: Visibility(
                        visible: displayedGames.isEmpty,
                        replacement: Builder(builder: (context) {
                          return ListView.separated(
                            itemCount: displayedGames.length +
                                (_showOnlyActiveGames ? 1 : 0),
                            separatorBuilder: (context, index) {
                              bool isLastGameIndex =
                                  index == displayedGames.length - 1;
                              return isLastGameIndex
                                  ? const SizedBox.shrink()
                                  : Divider(
                                      height: 1,
                                      thickness: 0.5,
                                      color: CustomTheme.white.withAlpha(50),
                                      indent: 50,
                                      endIndent: 50,
                                    );
                            },
                            itemBuilder: (context, index) {
                              if (_showOnlyActiveGames &&
                                  index == displayedGames.length) {
                                return Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        IconService.visibility_off,
                                        color: CustomTheme.white.withAlpha(150),
                                        size: 16.0,
                                      ),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        AppLocalizations.of(context)
                                            .only_active_games,
                                        style: TextStyle(
                                          color:
                                              CustomTheme.white.withAlpha(150),
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              final session = displayedGames[index];
                              return ListenableBuilder(
                                  listenable: session,
                                  builder: (context, _) {
                                    return Dismissible(
                                      key: Key(session.gameId),
                                      background: Container(
                                        color: CustomTheme.red,
                                        alignment: Alignment.centerRight,
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Icon(
                                          IconService.delete,
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                      direction: DismissDirection.endToStart,
                                      confirmDismiss: (direction) async {
                                        return await _showDeleteGamePopup(
                                            context, session.gameTitle);
                                      },
                                      onDismissed: (direction) {
                                        setState(() {
                                          gameManager
                                              .deleteGameById(session.gameId);
                                          _sortGames(
                                              sortOption: currentSortOption,
                                              sortDirection:
                                                  currentSortDirection);
                                        });
                                      },
                                      dismissThresholds: const {
                                        DismissDirection.startToEnd: 0.6
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: CupertinoListTile(
                                          backgroundColorActivated:
                                              CustomTheme.backgroundColor,
                                          title: Text(session.gameTitle),
                                          subtitle: Visibility(
                                              visible: session.isGameFinished,
                                              replacement: Text(
                                                '${AppLocalizations.of(context).mode}: ${_translateGameMode(session)}',
                                                style: const TextStyle(
                                                    fontSize: 14.5),
                                              ),
                                              child: Text(
                                                '\u{1F947} ${session.winner}',
                                                style: const TextStyle(
                                                    fontSize: 14.5),
                                              )),
                                          trailing: Row(
                                            children: [
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text('${session.roundNumber}'),
                                              const SizedBox(width: 3),
                                              Icon(IconService.rounds),
                                              const SizedBox(width: 15),
                                              Text('${session.players.length}'),
                                              const SizedBox(width: 3),
                                              Icon(IconService.players),
                                            ],
                                          ),
                                          onTap: () {
                                            final session =
                                                displayedGames[index];
                                            Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                builder: (context) =>
                                                    ActiveGameView(
                                                        gameSession: session),
                                              ),
                                            ).then((_) {
                                              setState(() {
                                                _sortGames(
                                                    sortOption:
                                                        currentSortOption,
                                                    sortDirection:
                                                        currentSortDirection);
                                              });
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  });
                            },
                          );
                        }),
                        child: EmptyFilterPlaceholder(
                            toggleShowOnlyActiveGames:
                                _toggleShowOnlyActiveGames)),
                    child: const EmptyGamesPlaceholder(),
                  ),
                  child: const MainMenuSkeleton(),
                ),
              )));
        });
  }

  /// Translates the game mode boolean into the corresponding String.
  /// If [pointLimit] is true, it returns '101 Punkte', otherwise it returns 'Unbegrenzt'.
  String _translateGameMode(GameSession gameSession) {
    if (gameSession.isPointsLimitEnabled) {
      return '${gameSession.pointLimit} ${AppLocalizations.of(context).points}';
    }
    return AppLocalizations.of(context).unlimited;
  }

  /// Handles the feedback dialog when the conditions for rating are met.
  /// It shows a dialog asking the user if they like the app,
  /// and based on their response, it either opens the rating dialog or an email client for feedback.
  Future<void> _handleFeedbackDialog(BuildContext context) async {
    final String emailSubject = AppLocalizations.of(context).email_subject;
    final String emailBody = AppLocalizations.of(context).email_body;

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: Constants.kEmail,
      query: 'subject=$emailSubject'
          '&body=$emailBody',
    );

    PreRatingDialogDecision preRatingDecision =
        await PopupService.showPreRatingDialog(context);
    BadRatingDialogDecision badRatingDecision = BadRatingDialogDecision.cancel;

    // so that the bad rating dialog is not shown immediately
    await Future.delayed(const Duration(milliseconds: Constants.kPopUpDelay));

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
  static Future<bool> _showDeleteGamePopup(
    BuildContext context,
    String gameTitle,
  ) async {
    return await PopupService.showSelectionPopup<bool>(
          context: context,
          title: Text(AppLocalizations.of(context).delete_game_title),
          message:
              Text(AppLocalizations.of(context).delete_game_message(gameTitle)),
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

  /// Sorts the game list based on the provided sort option and direction.
  /// Updates the configuration service with the new sorting preferences.
  /// [sortOption] The option to sort by (date or title).
  /// [sortDirection] The direction to sort (ascending or descending).
  void _sortGames(
      {required SortOption sortOption, required SortDirection sortDirection}) {
    displayedGames = _showOnlyActiveGames
        ? gameManager.gameList.where((game) => !game.isGameFinished).toList()
        : List.from(gameManager.gameList);

    final compare = sortOption == SortOption.date
        ? (a, b) => a.createdAt.compareTo(b.createdAt)
        : (a, b) =>
            a.gameTitle.toLowerCase().compareTo(b.gameTitle.toLowerCase());

    displayedGames.sort(
      sortDirection == SortDirection.ascending
          ? (GameSession a, GameSession b) => compare(a, b)
          : (GameSession a, GameSession b) => compare(b, a),
    );
  }

  /// Sets the current sort direction and updates the game list accordingly.
  /// [direction] The new sort direction to be set.
  void _setSortDirection(SortDirection direction) {
    setState(() {
      currentSortDirection = direction;
      _sortGames(sortOption: currentSortOption, sortDirection: direction);
      ConfigService.setSortingDirection(direction);
    });
  }

  /// Sets the current sort option and updates the game list accordingly.
  /// [option] The new sort option to be set.
  void _setSortOption(SortOption option) {
    setState(() {
      currentSortOption = option;
      _sortGames(sortOption: option, sortDirection: currentSortDirection);
      ConfigService.setSortingOption(option);
    });
  }

  /// Toggles the filter to show only active (unfinished) games in the list.
  void _toggleShowOnlyActiveGames() {
    setState(() {
      _showOnlyActiveGames = !_showOnlyActiveGames;
      _sortGames(
          sortOption: currentSortOption, sortDirection: currentSortDirection);
    });
    ConfigService.setShowActiveGamesOnly(_showOnlyActiveGames);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
