import 'dart:io';

import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/core/enums.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/opacity_button.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:flutter/material.dart';
import 'package:pull_down_button/pull_down_button.dart';

/// A button widget that provides sorting and filtering options for the main menu.
/// It adapts its UI based on the platform (iOS or others) to provide a native experience.
/// It uses a pull-down menu on iOS and a bottom sheet on other platforms.
/// It allows users to select sorting options, sort direction, and filter active games.
///
/// [currentSortOption] is the currently selected sorting option.
///
/// [currentSortDirection] is the currently selected sorting direction.
///
/// [showOnlyActiveGames] indicates whether only active games should be shown.
///
/// [onSortOptionChanged] is a callback function to handle changes in the sorting option.
///
/// [onSortDirectionChanged] is a callback function to handle changes in the sorting direction.
///
/// [onShowOnlyActiveGamesChanged] is a callback function to toggle the active games filter.
///
/// [context] is the BuildContext used for localization and theming.
class SortingButton extends StatelessWidget {
  final SortOption currentSortOption;
  final SortDirection currentSortDirection;
  final bool showOnlyActiveGames;
  final ValueChanged<SortOption> onSortOptionChanged;
  final ValueChanged<SortDirection> onSortDirectionChanged;
  final VoidCallback onShowOnlyActiveGamesChanged;

  const SortingButton({
    super.key,
    required this.currentSortOption,
    required this.currentSortDirection,
    required this.showOnlyActiveGames,
    required this.onSortOptionChanged,
    required this.onSortDirectionChanged,
    required this.onShowOnlyActiveGamesChanged,
  });

  @override
  Widget build(BuildContext context) {
    const buttonPadding = EdgeInsets.zero;
    final icon = IconService.sort;
    const iconSize = Constants.NAVBAR_ICON_SIZE;

    if (Platform.isIOS) {
      return PullDownButton(
        itemBuilder: _pullDownMenuItems,
        buttonBuilder: (context, showMenu) => OpacityButton.icon(
          onPressed: showMenu,
          padding: buttonPadding,
          icon: icon,
          size: iconSize,
        ),
      );
    } else {
      return OpacityButton.icon(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            backgroundColor: CustomTheme.backgroundColor,
            builder: (context) {
              return _bottomSheet(context);
            },
          );
        },
        padding: buttonPadding,
        icon: icon,
        size: iconSize,
      );
    }
  }

  /// Builds the list of pull-down menu items for iOS platform.
  /// This method creates a list of selectable menu items for sorting and filtering options.
  List<PullDownMenuEntry> _pullDownMenuItems(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return [
      PullDownMenuTitle(title: Text(loc.sort_and_filter_options)),
      PullDownMenuItem.selectable(
        onTap: () => onSortOptionChanged(SortOption.date),
        selected: currentSortOption == SortOption.date,
        title: loc.date,
        icon: IconService.sort_by_date,
      ),
      PullDownMenuItem.selectable(
        onTap: () => onSortOptionChanged(SortOption.title),
        selected: currentSortOption == SortOption.title,
        title: loc.game_title,
        icon: IconService.sort_by_name,
      ),
      const PullDownMenuDivider.large(),
      PullDownMenuItem.selectable(
        onTap: () => onSortDirectionChanged(SortDirection.descending),
        selected: currentSortDirection == SortDirection.descending,
        title: loc.descending,
        icon: IconService.sort_desc,
      ),
      PullDownMenuItem.selectable(
        onTap: () => onSortDirectionChanged(SortDirection.ascending),
        selected: currentSortDirection == SortDirection.ascending,
        title: loc.ascending,
        icon: IconService.sort_asc,
      ),
      const PullDownMenuDivider.large(),
      PullDownMenuItem.selectable(
        onTap: () => onShowOnlyActiveGamesChanged(),
        selected: showOnlyActiveGames,
        title: loc.only_active_game_title,
        subtitle: loc.only_active_games_description,
        icon: IconService.visibility_off,
      ),
    ];
  }

  /// Builds the bottom sheet widget for non-iOS platforms.
  /// This method creates a bottom sheet containing sorting and filtering options.
  Widget _bottomSheet(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(title: Text(loc.sort_and_filter_options)),
          ListTile(
            leading: Icon(IconService.sort_by_date),
            title: Text(loc.date),
            selected: currentSortOption == SortOption.date,
            onTap: () {
              Navigator.pop(context);
              onSortOptionChanged(SortOption.date);
            },
          ),
          ListTile(
            leading: Icon(IconService.sort_by_name),
            title: Text(loc.game_title),
            selected: currentSortOption == SortOption.title,
            onTap: () {
              Navigator.pop(context);
              onSortOptionChanged(SortOption.title);
            },
          ),
          Constants.BOTTOM_SHEET_DIVIDER,
          ListTile(
            leading: Icon(IconService.sort_desc),
            title: Text(loc.descending),
            selected: currentSortDirection == SortDirection.descending,
            onTap: () {
              Navigator.pop(context);
              onSortDirectionChanged(SortDirection.descending);
            },
          ),
          ListTile(
            leading: Icon(IconService.sort_asc),
            title: Text(loc.ascending),
            selected: currentSortDirection == SortDirection.ascending,
            onTap: () {
              Navigator.pop(context);
              onSortDirectionChanged(SortDirection.ascending);
            },
          ),
          Constants.BOTTOM_SHEET_DIVIDER,
          ListTile(
            leading: Icon(IconService.visibility_off),
            title: Text(loc.only_active_game_title),
            subtitle: Text(loc.only_active_games_description),
            selected: showOnlyActiveGames,
            onTap: () {
              Navigator.pop(context);
              onShowOnlyActiveGamesChanged();
            },
          ),
        ],
      ),
    );
  }
}
