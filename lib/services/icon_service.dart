// ignore_for_file: non_constant_identifier_names
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconService {
  static IconData get chart_bar_alt_fill =>
      Platform.isIOS ? CupertinoIcons.chart_bar_alt_fill : Icons.bar_chart;

  static IconData get minus_circle_fill =>
      Platform.isIOS ? CupertinoIcons.minus_circle_fill : Icons.remove_circle;

  static IconData get line_horizontal_3 =>
      Platform.isIOS ? CupertinoIcons.line_horizontal_3 : Icons.menu;

  static IconData get plus_circle_fill =>
      Platform.isIOS ? CupertinoIcons.plus_circle_fill : Icons.add_circle;

  static IconData get minus =>
      Platform.isIOS ? CupertinoIcons.minus : Icons.remove;

  static IconData get square_arrow_down => Platform.isIOS
      ? CupertinoIcons.arrow_down_square
      : Icons.file_download_outlined;

  static IconData get square_arrow_up => Platform.isIOS
      ? CupertinoIcons.arrow_up_square
      : Icons.file_upload_outlined;

  static IconData get mail =>
      Platform.isIOS ? CupertinoIcons.mail : Icons.mail_outline;

  static IconData get number =>
      Platform.isIOS ? CupertinoIcons.number : Icons.numbers;

  static IconData get trash =>
      Platform.isIOS ? CupertinoIcons.trash : Icons.delete;
  static IconData get calendar =>
      Platform.isIOS ? CupertinoIcons.calendar : Icons.calendar_month;

  static IconData get textformat_abc =>
      Platform.isIOS ? CupertinoIcons.textformat_abc : Icons.abc;

  static IconData get sort_down =>
      Platform.isIOS ? CupertinoIcons.sort_down : Icons.sort;

  static IconData get sort_up =>
      Platform.isIOS ? CupertinoIcons.sort_up : Icons.sort;

  static IconData get arrow_up_arrow_down =>
      Platform.isIOS ? CupertinoIcons.arrow_up_arrow_down : Icons.swap_vert;

  static IconData get add => Platform.isIOS ? CupertinoIcons.add : Icons.add;

  static IconData get delete =>
      Platform.isIOS ? CupertinoIcons.delete : Icons.delete;

  static IconData get arrow_2_circlepath_circle_fill => Platform.isIOS
      ? CupertinoIcons.arrow_2_circlepath_circle_fill
      : Icons.autorenew;

  static IconData get person_2_fill =>
      Platform.isIOS ? CupertinoIcons.person_2_fill : Icons.group;

  static IconData get settings =>
      Platform.isIOS ? CupertinoIcons.settings : Icons.settings;

  static IconData get arrow_counterclockwise => Platform.isIOS
      ? CupertinoIcons.arrow_counterclockwise
      : Icons.refresh_rounded;

  static IconData get info =>
      Platform.isIOS ? CupertinoIcons.info_circle_fill : Icons.info_rounded;

  static IconData get square_stack =>
      Platform.isIOS ? CupertinoIcons.square_stack_3d_up_fill : Icons.layers;

  static IconData get eye_slash => Platform.isIOS
      ? CupertinoIcons.eye_slash_fill
      : Icons.visibility_off_rounded;

  static IconData get bolt_fill =>
      Platform.isIOS ? CupertinoIcons.bolt_fill : Icons.bolt_rounded;

  static IconData get share =>
      Platform.isIOS ? CupertinoIcons.share : Icons.share;

  static IconData get house_fill =>
      Platform.isIOS ? CupertinoIcons.house_fill : Icons.home;

  static IconData get envelope =>
      Platform.isIOS ? CupertinoIcons.envelope : Icons.mail;

  static IconData get tray =>
      Platform.isIOS ? CupertinoIcons.tray : Icons.extension;

  static IconData get lock =>
      Platform.isIOS ? CupertinoIcons.lock : Icons.hourglass_empty;
}
