import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/tiles/mode_tile.dart';
import 'package:flutter/material.dart';

/// A stateless widget that displays a menu for selecting the game mode.
///
/// The [ModeSelectionView] allows the user to choose between different game modes:
/// - Point limit mode with a specified [pointLimit]
/// - Unlimited mode
/// - Optionally, no default mode if [showDeselection] is true
class ModeSelectionView extends StatefulWidget {
  const ModeSelectionView({
    super.key,
    required this.pointLimit,
    required this.showDeselection,
    this.initialSelectedGameMode,
  });

  final int pointLimit;
  final bool showDeselection;
  final GameMode? initialSelectedGameMode;

  @override
  State<ModeSelectionView> createState() => _ModeSelectionViewState();
}

class _ModeSelectionViewState extends State<ModeSelectionView> {
  late GameMode? selectedMode;

  // Supresses the tap while the Future.delayed are running
  bool supressTap = false;

  @override
  void initState() {
    selectedMode = widget.initialSelectedGameMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.gamemode)),
      body: ListView(
        children: [
          // Point limit mode
          ModeTile(
            title: '${widget.pointLimit} ${loc.points}',
            description: loc.point_limit_description(widget.pointLimit),
            onTap: () => onTapTile(GameMode.pointLimit),
            selected: selectedMode == GameMode.pointLimit,
          ),

          // Unlimited mode
          ModeTile(
            title: loc.unlimited,
            description: loc.unlimited_description,
            onTap: () => onTapTile(GameMode.unlimited),
            selected: selectedMode == GameMode.unlimited,
          ),

          if (widget.showDeselection)
            ModeTile(
              title: loc.no_default_mode,
              description: loc.no_default_description,
              onTap: () => onTapTile(GameMode.none),
              selected: selectedMode == GameMode.none,
            ),
        ],
      ),
    );
  }

  void onTapTile(GameMode selectedMode) {
    if (supressTap) return;
    supressTap = true;
    setState(() => this.selectedMode = selectedMode);
    Future.delayed(const Duration(milliseconds: 400), () {
      Navigator.of(context).pop(selectedMode);
    });
  }
}
