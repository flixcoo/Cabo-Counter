import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundTile extends StatefulWidget {
  const RoundTile({
    super.key,
    this.shufflePlayer = false,
    this.showMedal = false,
    required this.playerName,
    required this.points,
    required this.textInputAction,
    required this.controller,
    required this.onSubmitted,
    required this.focusNode,
    required this.onChanged,
  });

  /// The name to display for the player
  final String playerName;

  /// The current score of the player, displayed below the name
  final int points;

  /// Whether to show the "dealer" label next to the player's name
  final bool shufflePlayer;

  /// Whether to show a medal icon next to the player's name,
  /// indicating they won the previous round.
  final bool showMedal;

  final TextInputAction textInputAction;

  final TextEditingController controller;

  final void Function(String) onSubmitted;

  final FocusNode focusNode;

  final ValueChanged<String>? onChanged;

  @override
  State<RoundTile> createState() => _RoundTileState();
}

class _RoundTileState extends State<RoundTile> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        color: CustomTheme.buttonBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Row(
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Text(widget.playerName),
                    if (widget.shufflePlayer) ...[
                      const SizedBox(width: 8),
                      Text(
                        loc.dealer,
                        style: const TextStyle(
                          fontSize: 13,
                          color: CustomTheme.subtitleColor,
                        ),
                      ),
                    ],
                    if (widget.showMedal) ...const [
                      SizedBox(width: 10),
                      FaIcon(
                        FontAwesomeIcons.crown,
                        size: 15,
                        color: CustomTheme.primaryColor,
                      ),
                    ],
                  ],
                ),
                Text(
                  '${widget.points} ${loc.points}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  isDense: true,
                  fillColor: Colors.red,
                  border: InputBorder.none,
                  hintText: loc.points,
                  hintStyle: TextStyle(color: CustomTheme.hintTextColor),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: false,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: widget.textInputAction,
                controller: widget.controller,
                onSubmitted: widget.onSubmitted,
                maxLength: 3,
                focusNode: widget.focusNode,
                onChanged: widget.onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
