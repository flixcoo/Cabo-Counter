// ignore_for_file: non_constant_identifier_names
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A service that provides platform-specific icons for use in the app.
/// This service uses Cupertino icons for iOS and Material icons for other platforms.
/// The icons are accessed via static getters.
abstract class IconService {
  /// Icon for adding a player.
  static IconData get add_player =>
      Platform.isIOS ? CupertinoIcons.plus_circle_fill : Icons.add_circle;

  /// Icon for a plus sign.
  static IconData get add => Platform.isIOS ? CupertinoIcons.add : Icons.add;

  /// Icon for chart representation.
  static IconData get chart =>
      Platform.isIOS ? CupertinoIcons.chart_bar_alt_fill : Icons.bar_chart;

  static Widget get chevron => Platform.isIOS
      ? const CupertinoListTileChevron()
      : const Icon(
          Icons.chevron_right_sharp,
          size: 24,
          color: Colors.grey,
        );

  /// Icon for cabo penalty.
  static IconData get cabo_penalty =>
      Platform.isIOS ? CupertinoIcons.bolt_fill : Icons.electric_bolt;

  /// Icon for deleting.
  static IconData get delete =>
      Platform.isIOS ? CupertinoIcons.delete : Icons.delete;

  /// Icon for dragging items vertically.
  static IconData get drag =>
      Platform.isIOS ? CupertinoIcons.line_horizontal_3 : Icons.menu;

  /// Icon for email.
  static IconData get e_mail =>
      Platform.isIOS ? CupertinoIcons.envelope : Icons.mail;

  /// Icon for exporting files.
  static IconData get export => Platform.isIOS
      ? CupertinoIcons.square_arrow_up
      : Icons.file_upload_outlined;

  /// Icon for home.
  static IconData get home =>
      Platform.isIOS ? CupertinoIcons.house_fill : Icons.home;

  /// Icon for importing files.
  static IconData get import => Platform.isIOS
      ? CupertinoIcons.square_arrow_down
      : Icons.file_download_outlined;

  /// Icon for information.
  static IconData get info =>
      Platform.isIOS ? CupertinoIcons.info_circle : Icons.info_outline;

  /// Icon for lock.
  static IconData get locked =>
      Platform.isIOS ? CupertinoIcons.lock : Icons.lock;

  /// Icon for a minus sign.
  static IconData get minus =>
      Platform.isIOS ? CupertinoIcons.minus : Icons.remove;

  /// Icon for mode selection.
  static IconData get mode =>
      Platform.isIOS ? CupertinoIcons.square_stack_3d_up_fill : Icons.mode;

  /// Icon for number representation.
  static IconData get number =>
      Platform.isIOS ? CupertinoIcons.number : Icons.numbers;

  /// Icon for no games available.
  static IconData get no_games =>
      Platform.isIOS ? CupertinoIcons.tray : Icons.extension;

  /// Icon for player representation.
  static IconData get players =>
      Platform.isIOS ? CupertinoIcons.person_2_fill : Icons.group;

  /// Icon for removing a player.
  static IconData get remove_player =>
      Platform.isIOS ? CupertinoIcons.minus_circle_fill : Icons.remove_circle;

  /// Icon for resetting.
  static IconData get reset =>
      Platform.isIOS ? CupertinoIcons.arrow_counterclockwise : Icons.replay;

  /// Icon for round representation.
  static IconData get rounds => Platform.isIOS
      ? CupertinoIcons.arrow_2_circlepath_circle_fill
      : Icons.autorenew;

  /// Icon for sharing.
  static IconData get share =>
      Platform.isIOS ? CupertinoIcons.share : Icons.share;

  /// Icon for sorting by date.
  static IconData get sort_by_date =>
      Platform.isIOS ? CupertinoIcons.calendar : Icons.calendar_month;

  /// Icon for sorting by name.
  static IconData get sort_by_name =>
      Platform.isIOS ? CupertinoIcons.textformat_abc : Icons.abc;

  /// Icon for sorting in ascending order.
  static IconData get sort_asc =>
      Platform.isIOS ? CupertinoIcons.sort_up : Icons.arrow_upward;

  /// Icon for sorting in descending order.
  static IconData get sort_desc =>
      Platform.isIOS ? CupertinoIcons.sort_down : Icons.arrow_downward;

  /// Icon for sorting.
  static IconData get sort =>
      Platform.isIOS ? CupertinoIcons.arrow_up_arrow_down : Icons.swap_vert;

  /// Icon for settings.
  static IconData get settings =>
      Platform.isIOS ? CupertinoIcons.settings : Icons.settings;

  /// Icon for version information.
  static IconData get version =>
      Platform.isIOS ? CupertinoIcons.tag : Icons.label;

  /// Icon for visibility off.
  static IconData get visibility_off => Platform.isIOS
      ? CupertinoIcons.eye_slash_fill
      : Icons.visibility_off_rounded;

  /// Icon for shuffle rotation.
  static IconData get shuffle_cards => Platform.isIOS
      ? CupertinoIcons.rectangle_fill_on_rectangle_angled_fill
      : Icons.casino;
}
