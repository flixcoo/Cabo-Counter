// ignore_for_file: non_constant_identifier_names
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconService {
  static IconData get chart =>
      Platform.isIOS ? CupertinoIcons.chart_bar_alt_fill : Icons.bar_chart;

  static IconData get remove_player =>
      Platform.isIOS ? CupertinoIcons.minus_circle_fill : Icons.remove_circle;

  static IconData get drag =>
      Platform.isIOS ? CupertinoIcons.line_horizontal_3 : Icons.menu;

  static IconData get add_player =>
      Platform.isIOS ? CupertinoIcons.plus_circle_fill : Icons.add_circle;

  static IconData get minus =>
      Platform.isIOS ? CupertinoIcons.minus : Icons.remove;

  static IconData get import => Platform.isIOS
      ? CupertinoIcons.arrow_down_square
      : Icons.file_download_outlined;

  static IconData get export => Platform.isIOS
      ? CupertinoIcons.arrow_up_square
      : Icons.file_upload_outlined;

  static IconData get mail =>
      Platform.isIOS ? CupertinoIcons.mail : Icons.mail_outline;

  static IconData get number =>
      Platform.isIOS ? CupertinoIcons.number : Icons.numbers;

  static IconData get sort_by_date =>
      Platform.isIOS ? CupertinoIcons.calendar : Icons.calendar_month;

  static IconData get sort_by_name =>
      Platform.isIOS ? CupertinoIcons.textformat_abc : Icons.abc;

  static IconData get sort_down =>
      Platform.isIOS ? CupertinoIcons.sort_down : Icons.sort;

  static IconData get sort_up =>
      Platform.isIOS ? CupertinoIcons.sort_up : Icons.sort;

  static IconData get sort =>
      Platform.isIOS ? CupertinoIcons.arrow_up_arrow_down : Icons.swap_vert;

  static IconData get add => Platform.isIOS ? CupertinoIcons.add : Icons.add;

  static IconData get delete =>
      Platform.isIOS ? CupertinoIcons.delete : Icons.delete;

  static IconData get rounds => Platform.isIOS
      ? CupertinoIcons.arrow_2_circlepath_circle_fill
      : Icons.autorenew;

  static IconData get players =>
      Platform.isIOS ? CupertinoIcons.person_2_fill : Icons.group;

  static IconData get settings =>
      Platform.isIOS ? CupertinoIcons.settings : Icons.settings;

  static IconData get reset =>
      Platform.isIOS ? CupertinoIcons.arrow_counterclockwise : Icons.replay;

  static IconData get info =>
      Platform.isIOS ? CupertinoIcons.info_circle_fill : Icons.info_rounded;

  static IconData get mode =>
      Platform.isIOS ? CupertinoIcons.square_stack_3d_up_fill : Icons.mode;

  static IconData get visibility_off => Platform.isIOS
      ? CupertinoIcons.eye_slash_fill
      : Icons.visibility_off_rounded;

  static IconData get cabo_penalty =>
      Platform.isIOS ? CupertinoIcons.bolt_fill : Icons.bolt_rounded;

  static IconData get share =>
      Platform.isIOS ? CupertinoIcons.share : Icons.share;

  static IconData get home =>
      Platform.isIOS ? CupertinoIcons.house_fill : Icons.home;

  static IconData get e_mail =>
      Platform.isIOS ? CupertinoIcons.envelope : Icons.mail;

  static IconData get no_games =>
      Platform.isIOS ? CupertinoIcons.tray : Icons.extension;

  static IconData get locked =>
      Platform.isIOS ? CupertinoIcons.lock : Icons.lock;
}
