import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/dto/game_manager.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/home/active_game/active_game_view.dart';
import 'package:cabo_counter/presentation/views/home/create_game_view.dart';
import 'package:cabo_counter/presentation/views/home/settings_view.dart';
import 'package:cabo_counter/presentation/widgets/main_menu_skeleton.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/data_migration_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:url_launcher/url_launcher.dart';

enum PreRatingDialogDecision { yes, no, cancel }

enum BadRatingDialogDecision { email, cancel }

enum SortOption { date, title }

enum SortDirection { ascending, descending }

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

  /// Current sorting option for the game list
  SortOption currentSortOption = SortOption.title;

  /// Current sorting direction for the game list
  SortDirection currentSortDirection = SortDirection.descending;

  /// If true, only active (unfinished) games are shown in the list
  bool showOnlyActiveGames = false;

  @override
  initState() {
    super.initState();
    db.gameSessionDao.getAllGameSessions().then((gameSessions) {
      for (final session in gameSessions) {
        gameManager.addGameSessionFromDataBase(session);
      }
      return Future.delayed(const Duration(milliseconds: 500), () {
        _migrateData();
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
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

  void _updateView() {
    if (mounted) setState(() {});
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
                        iconSize: Constants.mainMenuButtonIconSize,
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const SettingsView(),
                            ),
                          ).then((_) {
                            setState(() {});
                          });
                        },
                        icon: const Icon(CupertinoIcons.settings)),
                    PullDownButton(
                      itemBuilder: (context) => [
                        const PullDownMenuTitle(
                            title: Text('Sortier- und Filter-Optionen')),
                        PullDownMenuItem.selectable(
                          onTap: () => _setSortOption(SortOption.date),
                          selected: currentSortOption == SortOption.date,
                          title: 'Datum',
                          icon: CupertinoIcons.calendar,
                        ),
                        PullDownMenuItem.selectable(
                          onTap: () => _setSortOption(SortOption.title),
                          selected: currentSortOption == SortOption.title,
                          title: 'Spieltitel',
                          icon: CupertinoIcons.textformat_abc,
                        ),
                        const PullDownMenuDivider.large(),
                        PullDownMenuItem.selectable(
                          onTap: () =>
                              _setSortDirection(SortDirection.descending),
                          selected:
                              currentSortDirection == SortDirection.descending,
                          title: 'Absteigend',
                          icon: CupertinoIcons.sort_down,
                        ),
                        PullDownMenuItem.selectable(
                          onTap: () =>
                              _setSortDirection(SortDirection.ascending),
                          selected:
                              currentSortDirection == SortDirection.ascending,
                          title: 'Aufsteigend',
                          icon: CupertinoIcons.sort_up,
                        ),
                        const PullDownMenuDivider.large(),
                        PullDownMenuItem.selectable(
                          onTap: () => _toggleShowOnlyActiveGames(),
                          selected: showOnlyActiveGames,
                          title: 'Nur aktive Spiele',
                          subtitle: 'Beendete Spiele werden ausgeblendet.',
                          icon: CupertinoIcons.eye_slash,
                        ),
                      ],
                      buttonBuilder: (context, showMenu) => IconButton(
                        onPressed: showMenu,
                        padding: EdgeInsets.zero,
                        icon: const Icon(CupertinoIcons.arrow_up_arrow_down),
                        iconSize: Constants.mainMenuButtonIconSize,
                      ),
                    ),
                  ],
                ),
                middle: Text(AppLocalizations.of(context).games),
                trailing: IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CreateGameView(
                        gameMode: ConfigService.getGameMode(),
                      ),
                    ),
                  ),
                  icon: const Icon(CupertinoIcons.add),
                  iconSize: Constants.mainMenuButtonIconSize,
                ),
              ),
              child: CupertinoPageScaffold(
                  child: SafeArea(
                child: Visibility(
                  visible: _isLoading,
                  replacement: Visibility(
                    visible: gameManager.gameList.isEmpty,
                    replacement: ListView.separated(
                      itemCount: showOnlyActiveGames
                          ? gameManager.gameList
                              .where((s) => !s.isGameFinished)
                              .length
                          : gameManager.gameList.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        thickness: 0.5,
                        color: CustomTheme.white.withAlpha(50),
                        indent: 50,
                        endIndent: 50,
                      ),
                      itemBuilder: (context, index) {
                        final session = gameManager.gameList[index];
                        return ListenableBuilder(
                            listenable: session,
                            builder: (context, _) {
                              return Dismissible(
                                key: Key(session.gameId),
                                background: Container(
                                  color: CustomTheme.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: const Icon(
                                    CupertinoIcons.delete,
                                    color: CupertinoColors.white,
                                  ),
                                ),
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (direction) async {
                                  return await _showDeleteGamePopup(
                                      context, session.gameTitle);
                                },
                                onDismissed: (direction) {
                                  gameManager.deleteGameById(session.gameId);
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
                                          style:
                                              const TextStyle(fontSize: 14.5),
                                        ),
                                        child: Text(
                                          '\u{1F947} ${session.winner}',
                                          style:
                                              const TextStyle(fontSize: 14.5),
                                        )),
                                    trailing: Row(
                                      children: [
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text('${session.roundNumber}'),
                                        const SizedBox(width: 3),
                                        const Icon(CupertinoIcons
                                            .arrow_2_circlepath_circle_fill),
                                        const SizedBox(width: 15),
                                        Text('${session.players.length}'),
                                        const SizedBox(width: 3),
                                        const Icon(
                                            CupertinoIcons.person_2_fill),
                                      ],
                                    ),
                                    onTap: () {
                                      final session =
                                          gameManager.gameList[index];
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => ActiveGameView(
                                              gameSession: session),
                                        ),
                                      ).then((_) {
                                        setState(() {});
                                      });
                                    },
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Center(
                            child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => CreateGameView(
                                  gameMode: ConfigService.getGameMode()),
                            ),
                          ),
                          child: Icon(
                            CupertinoIcons.plus,
                            size: 60,
                            color: CustomTheme.primaryColor,
                          ),
                        )),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70),
                          child: Text(
                            '${AppLocalizations.of(context).empty_text_1}\n${AppLocalizations.of(context).empty_text_2}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
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
        await _showPreRatingDialog(context);
    BadRatingDialogDecision badRatingDecision = BadRatingDialogDecision.cancel;

    // so that the bad rating dialog is not shown immediately
    await Future.delayed(const Duration(milliseconds: Constants.kPopUpDelay));

    switch (preRatingDecision) {
      case PreRatingDialogDecision.yes:
        if (context.mounted) Constants.rateMyApp.showStarRateDialog(context);
        break;
      case PreRatingDialogDecision.no:
        if (context.mounted) {
          badRatingDecision = await _showBadRatingDialog(context);
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
  Future<bool> _showDeleteGamePopup(
      BuildContext context, String gameTitle) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
                title: Text(
                  AppLocalizations.of(context).delete_game_title,
                ),
                content: Text(AppLocalizations.of(context)
                    .delete_game_message(gameTitle)),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(AppLocalizations.of(context).cancel),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    isDefaultAction: true,
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      AppLocalizations.of(context).delete,
                    ),
                  )
                ]);
          },
        ) ??
        false;
  }

  /// Shows a dialog asking the user if they like the app.
  /// Returns the user's decision as an integer.
  /// - PRE_RATING_DIALOG_YES: User likes the app and wants to rate it.
  /// - PRE_RATING_DIALOG_NO: User does not like the app and wants to provide feedback.
  /// - PRE_RATING_DIALOG_CANCEL: User cancels the dialog.
  Future<PreRatingDialogDecision> _showPreRatingDialog(
      BuildContext context) async {
    return await showCupertinoDialog<PreRatingDialogDecision>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text(AppLocalizations.of(context).pre_rating_title),
                  content:
                      Text(AppLocalizations.of(context).pre_rating_message),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context)
                          .pop(PreRatingDialogDecision.yes),
                      isDefaultAction: true,
                      child: Text(AppLocalizations.of(context).yes),
                    ),
                    CupertinoDialogAction(
                      onPressed: () =>
                          Navigator.of(context).pop(PreRatingDialogDecision.no),
                      child: Text(AppLocalizations.of(context).no),
                    ),
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      isDestructiveAction: true,
                      child: Text(AppLocalizations.of(context).cancel),
                    )
                  ],
                )) ??
        PreRatingDialogDecision.cancel;
  }

  /// Shows a dialog asking the user for feedback if they do not like the app.
  /// Returns the user's decision as an integer.
  /// - BAD_RATING_DIALOG_EMAIL: User wants to send an email with feedback.
  /// - BAD_RATING_DIALOG_CANCEL: User cancels the dialog.
  Future<BadRatingDialogDecision> _showBadRatingDialog(
      BuildContext context) async {
    return await showCupertinoDialog<BadRatingDialogDecision>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text(AppLocalizations.of(context).bad_rating_title),
                  content:
                      Text(AppLocalizations.of(context).bad_rating_message),
                  actions: [
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () => Navigator.of(context)
                          .pop(BadRatingDialogDecision.email),
                      child: Text(AppLocalizations.of(context).contact_email),
                    ),
                    CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(AppLocalizations.of(context).cancel))
                  ],
                )) ??
        BadRatingDialogDecision.cancel;
  }

  void _migrateData() async {
    if (!ConfigService.isMigrationDone()) {
      migrationStatus = await DataMigrationService.loadOldGameData();
      final success = migrationStatus['success'] ?? 0;
      if (success == 1) {
        ConfigService.setMigrationDone(true);

        if (mounted) {
          final int migratedGames = migrationStatus['gameCount'] ?? 0;
          await showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Migration erfolgreich'),
              content: Text(
                  '$migratedGames Spiele konnten aus den gefundenen Spieldaten migriert werden.'),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text(AppLocalizations.of(context).ok),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      } else if (success == -1) {
        ConfigService.setMigrationDone(true);

        if (mounted) {
          await showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Migration fehlgeschlagen'),
              content: const Text(
                  'Deine alten Spieldaten konnten leider nicht migriert werden.'),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text(AppLocalizations.of(context).ok),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
        }
      }
    } else {
      print('[MainMenuView] Data migration already completed. Skipping.');
    }
  }

  void _sortGames(
      {required SortOption sortOption, required SortDirection sortDirection}) {
    final compare = sortOption == SortOption.date
        ? (a, b) => a.createdAt.compareTo(b.createdAt)
        : (a, b) => a.gameTitle.compareTo(b.gameTitle);

    gameManager.gameList.sort(
      sortDirection == SortDirection.ascending
          ? (GameSession a, GameSession b) => compare(a, b)
          : (GameSession a, GameSession b) => compare(b, a),
    );

    _updateView();
  }

  /// Sets the current sort direction and updates the game list accordingly.
  /// [direction] The new sort direction to be set.
  void _setSortDirection(SortDirection direction) {
    setState(() {
      currentSortDirection = direction;
      _sortGames(sortOption: currentSortOption, sortDirection: direction);
    });
  }

  /// Sets the current sort option and updates the game list accordingly.
  /// [option] The new sort option to be set.
  void _setSortOption(SortOption option) {
    setState(() {
      currentSortOption = option;
      _sortGames(sortOption: option, sortDirection: currentSortDirection);
    });
  }

  /// Toggles the filter to show only active (unfinished) games in the list.
  void _toggleShowOnlyActiveGames() {
    setState(() {
      showOnlyActiveGames = !showOnlyActiveGames;
    });
  }

  @override
  void dispose() {
    gameManager.removeListener(_updateView);
    super.dispose();
  }
}
