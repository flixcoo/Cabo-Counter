import 'package:flutter/cupertino.dart';

class NewsItem {
  final String title;
  final String text;
  final IconData icon;

  NewsItem({required this.title, required this.text, required this.icon});
}

final NewsItems = {
  'de': [
    NewsItem(
      title: 'Neues Design',
      text:
          'Die komplette App wurde redesigned, weg vom iOS Systemdesign zu einer eigenständigen Optik',
      icon: CupertinoIcons.paintbrush_fill,
    ),
    NewsItem(
      title: 'Problem mit Kamikaze behoben',
      text:
          'Kamikaze addiert nun immer die Hälfte vom Punktelimit auf die Punktestände. Vorher wurde immer 50 Punkte addiert.',
      icon: CupertinoIcons.wrench_fill,
    ),
    NewsItem(
      title: 'Haptisches Feedback',
      text:
          'Die App wurde um haptisches Feedback ergänzt. Dieses kann in den Einstellungen deaktiviert werden.',
      icon: CupertinoIcons.radiowaves_right,
    ),
  ],
  'en': [
    NewsItem(
      title: 'New Design',
      text:
          'The entire app has been redesigned, moving away from the iOS system design towards a distinct look of its own.',
      icon: CupertinoIcons.paintbrush_fill,
    ),
    NewsItem(
      title: 'Kamikaze Issue Fixed',
      text:
          'Kamikaze now always adds half of the point limit to the scores. Previously it always added 50 points.',
      icon: CupertinoIcons.wrench_fill,
    ),
    NewsItem(
      title: 'Haptic Feedback',
      text:
          'The app now includes haptic feedback. This can be disabled in the settings.',
      icon: CupertinoIcons.radiowaves_right,
    ),
  ],
};
