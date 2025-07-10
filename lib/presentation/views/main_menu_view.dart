import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/game_manager.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/active_game_view.dart';
import 'package:cabo_counter/presentation/views/create_game_view.dart';
import 'package:cabo_counter/presentation/views/settings_view.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainMenuViewState createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  bool _isLoading = true;
  static const int PRE_RATING_DIALOG_YES = 1;
  static const int PRE_RATING_DIALOG_NO = 0;
  static const int PRE_RATING_DIALOG_CANCEL = -1;
  static const int BAD_RATING_DIALOG_EMAIL = 1;
  static const int BAD_RATING_DIALOG_CANCEL = 0;

  @override
  initState() {
    super.initState();
    LocalStorageService.loadGameSessions().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    gameManager.addListener(_updateView);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
              middle: const Text('Cabo Counter'),
              trailing: IconButton(
                  onPressed: () => Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const CreateGameView(),
                        ),
                      ),
                  icon: const Icon(CupertinoIcons.add)),
            ),
            child: CupertinoPageScaffold(
              child: SafeArea(
                child: _isLoading
                    ? const Center(child: CupertinoActivityIndicator())
                    : gameManager.gameList.isEmpty
                        ? Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // Oben ausrichten
                            children: [
                              const SizedBox(height: 30), // Abstand von oben
                              Center(
                                  child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        const CreateGameView(),
                                  ),
                                ),
                                child: Icon(
                                  CupertinoIcons.plus,
                                  size: 60,
                                  color: CustomTheme.primaryColor,
                                ),
                              )),
                              const SizedBox(height: 10), // Abstand von oben
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 70),
                                child: Text(
                                  '${AppLocalizations.of(context).empty_text_1}\n${AppLocalizations.of(context).empty_text_2}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: gameManager.gameList.length,
                            itemBuilder: (context, index) {
                              final session = gameManager.gameList[index];
                              return ListenableBuilder(
                                  listenable: session,
                                  builder: (context, _) {
                                    return Dismissible(
                                      key: Key(session.gameTitle),
                                      background: Container(
                                        color: CupertinoColors.destructiveRed,
                                        alignment: Alignment.centerRight,
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: const Icon(
                                          CupertinoIcons.delete,
                                          color: CupertinoColors.white,
                                        ),
                                      ),
                                      direction: DismissDirection.endToStart,
                                      confirmDismiss: (direction) async {
                                        final String gameTitle = gameManager
                                            .gameList[index].gameTitle;
                                        return await _showDeleteGamePopup(
                                            gameTitle, context);
                                      },
                                      onDismissed: (direction) {
                                        gameManager
                                            .removeGameSessionByIndex(index);
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
                                          subtitle:
                                              session.isGameFinished == true
                                                  ? Text(
                                                      '\u{1F947} ${session.winner}',
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    )
                                                  : Text(
                                                      '${AppLocalizations.of(context).mode}: ${_translateGameMode(session.isPointsLimitEnabled)}',
                                                      style: const TextStyle(
                                                          fontSize: 14),
                                                    ),
                                          trailing: Row(
                                            children: [
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
                                                builder: (context) =>
                                                    ActiveGameView(
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
              ),
            ),
          );
        });
  }

  /// Translates the game mode boolean into the corresponding String.
  /// If [pointLimit] is true, it returns '101 Punkte', otherwise it returns 'Unbegrenzt'.
  String _translateGameMode(bool pointLimit) {
    if (pointLimit) {
      return '${ConfigService.pointLimit} ${AppLocalizations.of(context).points}';
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
      path: Constants.EMAIL,
      query: 'subject=$emailSubject'
          '&body=$emailBody',
    );

    int preRatingDecision = await _showPreRatingDialog(context);
    int badRatingDecision = BAD_RATING_DIALOG_CANCEL;

    // so that the bad rating dialog is not shown immediately
    await Future.delayed(const Duration(milliseconds: 300));

    switch (preRatingDecision) {
      case PRE_RATING_DIALOG_YES:
        if (context.mounted) Constants.rateMyApp.showStarRateDialog(context);
        break;
      case PRE_RATING_DIALOG_NO:
        if (context.mounted) {
          badRatingDecision = await _showBadRatingDialog(context);
        }
        if (badRatingDecision == BAD_RATING_DIALOG_EMAIL) {
          if (context.mounted) {
            launchUrl(emailUri);
          }
        }
        break;
      case PRE_RATING_DIALOG_CANCEL:
        break;
    }
  }

  /// Shows a confirmation dialog to delete all game sessions.
  /// Returns true if the user confirms the deletion, false otherwise.
  /// [gameTitle] is the title of the game session to be deleted.
  Future<bool?> _showDeleteGamePopup(
      String gameTitle, BuildContext context) async {
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
                      child: Text(AppLocalizations.of(context).cancel),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      }),
                  CupertinoDialogAction(
                      isDestructiveAction: true,
                      isDefaultAction: true,
                      child: Text(
                        AppLocalizations.of(context).delete,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      })
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
  Future<int> _showPreRatingDialog(BuildContext context) async {
    return await showCupertinoDialog<int>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text(AppLocalizations.of(context).pre_rating_title),
                  content:
                      Text(AppLocalizations.of(context).pre_rating_message),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () =>
                          Navigator.of(context).pop(PRE_RATING_DIALOG_YES),
                      isDefaultAction: true,
                      child: Text(AppLocalizations.of(context).yes),
                    ),
                    CupertinoDialogAction(
                      onPressed: () =>
                          Navigator.of(context).pop(PRE_RATING_DIALOG_NO),
                      child: Text(AppLocalizations.of(context).no),
                    ),
                    CupertinoDialogAction(
                      onPressed: () =>
                          Navigator.of(context).pop(PRE_RATING_DIALOG_CANCEL),
                      isDestructiveAction: true,
                      child: Text(AppLocalizations.of(context).cancel),
                    )
                  ],
                )) ??
        PRE_RATING_DIALOG_CANCEL;
  }

  /// Shows a dialog asking the user for feedback if they do not like the app.
  /// Returns the user's decision as an integer.
  /// - BAD_RATING_DIALOG_EMAIL: User wants to send an email with feedback.
  /// - BAD_RATING_DIALOG_CANCEL: User cancels the dialog.
  Future<int> _showBadRatingDialog(BuildContext context) async {
    return await showCupertinoDialog<int>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text(AppLocalizations.of(context).bad_rating_title),
                  content:
                      Text(AppLocalizations.of(context).bad_rating_message),
                  actions: [
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () =>
                          Navigator.of(context).pop(BAD_RATING_DIALOG_EMAIL),
                      child: Text(AppLocalizations.of(context).contact_email),
                    ),
                    CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () =>
                            Navigator.of(context).pop(BAD_RATING_DIALOG_CANCEL),
                        child: Text(AppLocalizations.of(context).cancel))
                  ],
                )) ??
        BAD_RATING_DIALOG_CANCEL;
  }

  @override
  void dispose() {
    gameManager.removeListener(_updateView);
    super.dispose();
  }
}
