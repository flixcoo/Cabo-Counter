import 'package:rate_my_app/rate_my_app.dart';

class Constants {
  static const String appDevPhase = 'Beta';

  static const String INSTAGRAM_LINK = 'https://instagram.felixkirchner.de';
  static const String GITHUB_LINK = 'https://github.felixkirchner.de';
  static const String GITHUB_ISSUES_LINK =
      'https://cabocounter-issues.felixkirchner.de';
  static const String GITHUB_WIKI_LINK =
      'https://cabocounter-wiki.felixkirchner.de';
  static const String EMAIL = 'cabocounter@felixkirchner.de';
  static const String PRIVACY_POLICY_LINK =
      'https://www.privacypolicies.com/live/1b3759d4-b2f1-4511-8e3b-21bb1626be68';

  static RateMyApp rateMyApp = RateMyApp(
      appStoreIdentifier: '6747105718',
      minDays: 15,
      remindDays: 45,
      minLaunches: 15,
      remindLaunches: 40);
}
