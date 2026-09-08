import 'dart:async';

import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/floating_animated_button.dart';
import 'package:cabo_counter/presentation/controllers/game_session_controller.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';

/// A bottom sheet for selecting the player who has Kamikaze.
///
/// - [gameSession]: The current game session.
class KamikazeSheet extends StatefulWidget {
  final GameSessionController gameSession;

  const KamikazeSheet({super.key, required this.gameSession});

  /// Displays the Kamikaze bottom sheet and returns the selected player index,
  /// or `null` if the sheet was dismissed.
  static Future<int?> show(
    BuildContext context,
    GameSessionController gameSession,
  ) async {
    return await showModalBottomSheet<int?>(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => KamikazeSheet(gameSession: gameSession),
    );
  }

  @override
  State<KamikazeSheet> createState() => _KamikazeSheetState();
}

class _KamikazeSheetState extends State<KamikazeSheet> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CustomTheme.mainElementColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: CustomTheme.subtitleColor.withAlpha(120),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: CustomTheme.kamikazeColor.withAlpha(30),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      IconService.kamikaze,
                      color: CustomTheme.kamikazeColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    loc.kamikaze,
                    style: const TextStyle(
                      color: CustomTheme.textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loc.who_has_kamikaze,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: CustomTheme.subtitleColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Player
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...widget.gameSession.players.asMap().entries.map((
                        entry,
                      ) {
                        return _PlayerTile(
                          name: entry.value.name,
                          selected: _selectedIndex == entry.key,
                          onTap: () {
                            VibrationService.selectionClick();
                            setState(() => _selectedIndex = entry.key);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              FloatingAnimatedButton(
                text: loc.submit,
                onPressed: _selectedIndex == null
                    ? null
                    : () {
                        VibrationService.mediumImpact();
                        Navigator.pop(context, _selectedIndex);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A selectable tile representing a single player in the Kamikaze sheet.
class _PlayerTile extends StatefulWidget {
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const _PlayerTile({
    required this.name,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_PlayerTile> createState() => _PlayerTileState();
}

class _PlayerTileState extends State<_PlayerTile> {
  bool isPressed = false;
  Timer? timer;

  void _activatePressState() {
    timer?.cancel();
    setState(() => isPressed = true);

    timer = Timer(const Duration(milliseconds: 250), () {
      if (mounted) {
        setState(() => isPressed = false);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selected;

    final Color backgroundColor = selected
        ? Color.alphaBlend(
            CustomTheme.kamikazeColor.withAlpha(45),
            CustomTheme.tileColor,
          )
        : CustomTheme.tileColor;
    final borderColor = selected
        ? CustomTheme.kamikazeColor
        : Colors.transparent;

    return GestureDetector(
      onTapDown: (_) => _activatePressState(),
      onTapUp: (_) => widget.onTap(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Center(
          child: Text(
            widget.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: CustomTheme.textColor,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
