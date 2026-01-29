import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/dto/game_session.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/home/active_game/active_game_view.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:flutter/cupertino.dart';

class GameTile extends StatefulWidget {
  const GameTile({super.key, required this.session});

  final GameSession session;

  @override
  State<GameTile> createState() => _GameTileState();
}

class _GameTileState extends State<GameTile> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      padding: const EdgeInsets.only(right: 4, left: 2),
      decoration: BoxDecoration(
        color: CustomTheme.mainElementBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ActiveGameView(gameSession: widget.session),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    alignment: AlignmentGeometry.center,
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: CustomTheme.primaryColor.withAlpha(100),
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: widget.session.isPointsLimitEnabled
                        ? Text(
                            widget.session.pointLimit.toString(),
                            style: TextStyle(
                              color: CustomTheme.primaryColor.withRed(40),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Icon(
                            CupertinoIcons.infinite,
                            size: 32,
                            color: CustomTheme.primaryColor.withRed(40),
                          ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.session.gameTitle,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        widget.session.isGameFinished
                            ? '\u{1F947} ${widget.session.winner}'
                            : '${loc.round} ${widget.session.roundNumber}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${widget.session.players.length}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 10),
                  Icon(IconService.players, size: 28),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
