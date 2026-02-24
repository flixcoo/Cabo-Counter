import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/opacity_button.dart';
import 'package:cabo_counter/presentation/views/about/licenses/license_view.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// A view that displays information about the app, including its name, version,
/// privacy policy, imprint, and licenses.
class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(loc.about)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  loc.app_name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${loc.version} ${VersionService.getVersionWithBuild()}',
                style: TextStyle(fontSize: 15, color: Colors.grey[300]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: SizedBox(
                  height: 200,
                  child: Image.asset('assets/cabo_counter-logo_rounded.png'),
                ),
              ),
              OpacityButton.text(
                padding: const EdgeInsets.symmetric(vertical: 4),
                text: loc.privacy_policy,
                onPressed: () =>
                    launchUrl(Uri.parse(Constants.PRIVACY_POLICY_LINK)),
              ),
              OpacityButton.text(
                padding: const EdgeInsets.symmetric(vertical: 4),
                text: loc.support_me,
                onPressed: () => launchUrl(Uri.parse(Constants.DONATE_LINK)),
              ),
              OpacityButton.text(
                padding: const EdgeInsets.symmetric(vertical: 4),
                text: loc.legal_notice,
                onPressed: () => launchUrl(Uri.parse(Constants.LEGAL_LINK)),
              ),
              OpacityButton.text(
                padding: const EdgeInsets.symmetric(vertical: 4),
                text: loc.licenses,
                onPressed: () => Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (_) => const LicenseView()),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '\u00A9 Felix Kirchner',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OpacityButton.icon(
                    onPressed: () =>
                        launchUrl(Uri.parse(Constants.WEBSITE_LINK)),
                    icon: IconService.website,
                    color: CustomTheme.primaryColor,
                  ),
                  OpacityButton.icon(
                    onPressed: () => launchUrl(
                      Uri.parse('mailto:${Constants.CONTACT_EMAIL}'),
                    ),
                    icon: IconService.e_mail,
                    color: CustomTheme.primaryColor,
                  ),
                  OpacityButton.icon(
                    onPressed: () =>
                        launchUrl(Uri.parse(Constants.GITHUB_LINK)),
                    icon: FontAwesomeIcons.github,
                    size: 22,
                    color: CustomTheme.primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
