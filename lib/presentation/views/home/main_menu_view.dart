import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/data/dto/game_manager.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/home/active_game/active_game_view.dart';
import 'package:cabo_counter/presentation/views/home/create_game_view.dart';
import 'package:cabo_counter/presentation/views/home/settings_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum PreRatingDialogDecision { yes, no, cancel }

enum BadRatingDialogDecision { email, cancel }

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
  bool _isLoading = true;
  late final AppDatabase db;

  @override
  initState() {
    super.initState();
    db = Provider.of<AppDatabase>(context, listen: false);

    db.gameSessionDao.getAllGameSessions().then((gameSessions) {
      print(
          '[MainMenuView] Loaded ${gameSessions.length} game sessions from the database.');
      for (final session in gameSessions) {
        gameManager.addGameSession(session, db);
      }

      print('[MainMenuView] Game sessions loaded successfully.');
      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      print('[MainMenuView] Error loading game sessions: $error');
    });

    /* LocalStorageService.loadGameSessions().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    gameManager.addListener(_updateView);*/

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      precacheImage(
          const AssetImage('assets/cabo_counter-logo_rounded.png'), context);
      await Constants.rateMyApp.init();

      if (Constants.rateMyApp.shouldOpenDialog &&
          Constants.appDevPhase != 'Beta') {
        await Future.delayed(const Duration(milliseconds: 600));
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
                leading: IconButton(
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
                    icon: const Icon(CupertinoIcons.settings, size: 30)),
                middle: Text(AppLocalizations.of(context).games),
                trailing: IconButton(
                    onPressed: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => CreateGameView(
                                gameMode: ConfigService.getGameMode()),
                          ),
                        ),
                    icon: const Icon(CupertinoIcons.add)),
              ),
              child: CupertinoPageScaffold(
                  child: SafeArea(
                child: Visibility(
                  visible: _isLoading,
                  replacement: Visibility(
                    visible: gameManager.gameList.isEmpty,
                    replacement: ListView.separated(
                      itemCount: gameManager.gameList.length,
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
                                key: Key(session.id),
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
                                  gameManager.removeGameSessionById(session.id);
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
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        child: Text(
                                          '\u{1F947} ${session.winner}',
                                          style: const TextStyle(fontSize: 14),
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
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CupertinoActivityIndicator(),
                      const SizedBox(height: 10),
                      Text(AppLocalizations.of(context).loading_games)
                    ],
                  )),
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

  @override
  void dispose() {
    gameManager.removeListener(_updateView);
    super.dispose();
  }
}
