import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

/// A utility class that holds constant values and configuration settings
/// used throughout the application, such as external links, email addresses,
/// and timing parameters for UI elements.
///
/// This class also provides an instance of [RateMyApp] for managing
/// in-app rating prompts.
class Constants {
  /// Indicates the current development phase of the app
  static const String appDevPhase = 'Stable';

  /// Links to various social media profiles and resources related to the app.
  /// URL to my Instagram profile
  static const String kInstagramLink = 'https://instagram.felixkirchner.de';

  /// URL to my GitHub profile
  static const String kGithubLink = 'https://github.felixkirchner.de';

  /// URL to the GitHub issues page for reporting bugs or requesting features.
  static const String kGithubIssuesLink =
      'https://github.com/flixcoo/cabo-counter/issues';

  /// Official email address for user inquiries and support.
  static const String kEmail = 'cabocounter@felixkirchner.de';

  /// URL to the app's privacy policy page.
  static const String kPrivacyPolicyLink =
      'https://felixkirchner.de/projects/cabo-counter/privacy/';

  /// URL to the app's imprint page, containing legal information.
  static const String kLegalLink = 'https://felixkirchner.de/legal';

  /// URL to my PayPal donation page for users who wish to support the app.
  static const String kDonateLink = 'https://www.paypal.me/flixcoo';

  /// Instance of [RateMyApp] configured to prompt users for app store ratings.
  static RateMyApp rateMyApp = RateMyApp(
      appStoreIdentifier: '6751843294',
      minDays: 14,
      remindDays: 28,
      minLaunches: 10,
      remindLaunches: 30);

  /// Delay in milliseconds before a pop-up appears.
  static const int kPopUpDelay = 300;

  /// Delay in milliseconds before the round view appears after the previous one is closed.
  static const int kRoundViewDelay = 600;

  /// Duration in milliseconds for the fade-in animation of texts.
  static const int kFadeInDuration = 300;

  /// Duration in milliseconds for the keyboard to fully disappear.
  static const int kKeyboardDelay = 300;

  /// Minimum duration in milliseconds that the skeleton screen should be displayed.
  static const int kMinimumSkeletonScreenDuration = 500;

  /// Size of the icons used on the buttons in the nav bar.
  static const double navBarIconSize = 28.0;

  static const Widget bottomSheetDivider = Divider(indent: 10, endIndent: 10);
}
