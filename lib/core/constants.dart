import 'package:rate_my_app/rate_my_app.dart';

class Constants {
  static const String appDevPhase = 'Beta';

  static const String kInstagramLink = 'https://instagram.felixkirchner.de';
  static const String kGithubLink = 'https://github.felixkirchner.de';
  static const String kGithubIssuesLink =
      'https://cabocounter-issues.felixkirchner.de';
  static const String kGithubWikiLink =
      'https://cabocounter-wiki.felixkirchner.de';
  static const String kEmail = 'cabocounter@felixkirchner.de';
  static const String kPrivacyPolicyLink =
      'https://www.privacypolicies.com/live/1b3759d4-b2f1-4511-8e3b-21bb1626be68';

  static RateMyApp rateMyApp = RateMyApp(
      appStoreIdentifier: '6747105718',
      minDays: 15,
      remindDays: 45,
      minLaunches: 15,
      remindLaunches: 40);

  /// Delay in milliseconds before a pop-up appears.
  static const int popUpDelay = 300;

  /// Delay in milliseconds before the round view appears after the previous one is closed.
  static const int roundViewDelay = 600;

  /// Duration in milliseconds for the fade-in animation of texts.
  static const int fadeInDuration = 300;
}
