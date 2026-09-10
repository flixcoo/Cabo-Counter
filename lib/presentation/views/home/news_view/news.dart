import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/dto/news_item.dart';
import 'package:flutter_sficon/flutter_sficon.dart';

final localizedNews = {
  'de': [
    NewsItem(
      title: 'Neues Design',
      text: 'Die App hat ein neues Design bekommen, mit überarbeiteten Elementen, Farben und einer teilweise neuer Anordnung. Schau dich gern um!',
      icon: const SFIcon(
        SFIcons.sf_paintbrush_fill,
        fontSize: 28,
        color: CustomTheme.primaryColor,
      ),
    ),
    NewsItem(
      title: 'Auswertung',
      text: 'Es gibt jetzt Auswertungen für jedes Spiel. Sie zeigt dir pro Spieler:in verschiedene Metriken an, mit welchen Ihr euch untereinander vergleichen könnt. Danke an Cameron für diesen Vorschlag!',
      icon: const SFIcon(
        SFIcons.sf_chart_bar_fill,
        fontSize: 28,
        color: CustomTheme.primaryColor,
      ),
    ),
    NewsItem(
      title: 'Haptisches Feedback',
      text: 'Die App wurde um haptisches Feedback ergänzt. Dieses kann in den Einstellungen deaktiviert werden.',
      icon: const SFIcon(
        SFIcons.sf_iphone_gen1_radiowaves_left_and_right,
        fontSize: 28,
        color: CustomTheme.primaryColor,
      ),
    ),
    NewsItem(
      title: 'Cabo-Spieler:in wählen',
      text: 'Zu Beginn der Runde ist der/die Spieler:in, die Cabo angesagt hat, nun nicht mehr automatisch ausgewählt. Zudem kannst du die Auswahl jederzeit wieder aufheben.',
      icon: const SFIcon(
        SFIcons.sf_person_fill,
        fontSize: 28,
        color: CustomTheme.primaryColor,
      ),
    ),
    NewsItem(
      title: 'Problem mit Kamikaze behoben',
      text: 'Kamikaze addiert nun immer die Hälfte vom Punktelimit auf die Punktestände. Vorher wurde immer 50 Punkte addiert. Danke an Justus für den Hinweis!',
      icon: const SFIcon(
        SFIcons.sf_wrench_adjustable_fill,
        fontSize: 28,
        color: CustomTheme.primaryColor,
      ),
    ),
  ],
  'en': [
    NewsItem(
      title: 'New Design',
      text: 'The entire app has been redesigned, moving away from the iOS system design towards a distinct look of its own. Take a look around!',
      icon: const SFIcon(
        SFIcons.sf_paintbrush_fill,
        fontSize: 28,
        color: CustomTheme.primaryColor,
      ),
    ),
    NewsItem(
      title: 'Evaluation',
      text: 'There are now statistics available for every game. They show you various metrics for each player, which you can use to compare yourselves with one another. Thanks to Cameron for this suggestion!',
      icon: const SFIcon(
        SFIcons.sf_chart_bar_fill,
        fontSize: 28,
        color: CustomTheme.primaryColor,
      ),
    ),
    NewsItem(
      title: 'Haptic Feedback',
      text: 'The app now includes haptic feedback. This can be disabled in the settings.',
      icon: const SFIcon(
        SFIcons.sf_iphone_gen1_radiowaves_left_and_right,
        fontSize: 28,
        color: CustomTheme.primaryColor,
      ),
    ),
    NewsItem(
      title: 'Select Cabo Player',
      text: 'At the beginning of the round, the player who called Cabo is no longer automatically selected. You can also deselect the choice at any time.',
      icon: const SFIcon(
        SFIcons.sf_person_fill,
        fontSize: 28,
        color: CustomTheme.primaryColor,
      ),
    ),

    NewsItem(
      title: 'Kamikaze Issue Fixed',
      text: 'Kamikaze now always adds half of the point limit to the scores. Previously it always added 50 points. Thanks to Justus for the hint!',
      icon: const SFIcon(
        SFIcons.sf_wrench_adjustable_fill,
        fontSize: 28,
        color: CustomTheme.primaryColor,
      ),
    ),
  ],
};
