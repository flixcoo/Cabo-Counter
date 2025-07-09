import 'package:rate_my_app/rate_my_app.dart';

class Globals {
  static String appDevPhase = 'Beta';
  static RateMyApp rateMyApp = RateMyApp(
      appStoreIdentifier: '6747105718',
      minDays: 15,
      remindDays: 45,
      minLaunches: 15,
      remindLaunches: 40);
}
