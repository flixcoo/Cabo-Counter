import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
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

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(middle: Text(loc.about)),
      child: SafeArea(
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
                '${loc.app_version} ${VersionService.getVersionWithBuild()}',
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
              CupertinoButton(
                sizeStyle: CupertinoButtonSize.medium,
                padding: EdgeInsets.zero,
                child: Text(loc.privacy_policy),
                onPressed: () =>
                    launchUrl(Uri.parse(Constants.PRIVACY_POLICY_LINK)),
              ),
              CupertinoButton(
                sizeStyle: CupertinoButtonSize.medium,
                padding: EdgeInsets.zero,
                child: Text(loc.support_me),
                onPressed: () => launchUrl(Uri.parse(Constants.DONATE_LINK)),
              ),
              CupertinoButton(
                sizeStyle: CupertinoButtonSize.medium,
                padding: EdgeInsets.zero,
                child: Text(loc.legal_notice),
                onPressed: () => launchUrl(Uri.parse(Constants.LEGAL_LINK)),
              ),
              CupertinoButton(
                sizeStyle: CupertinoButtonSize.medium,
                padding: EdgeInsets.zero,
                child: Text(loc.licenses),
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
                  IconButton(
                    onPressed: () =>
                        launchUrl(Uri.parse(Constants.WEBSITE_LINK)),
                    icon: Icon(IconService.website),
                  ),
                  IconButton(
                    onPressed: () => launchUrl(
                      Uri.parse('mailto:${Constants.CONTACT_EMAIL}'),
                    ),
                    icon: Icon(IconService.e_mail),
                  ),
                  IconButton(
                    onPressed: () =>
                        launchUrl(Uri.parse(Constants.GITHUB_LINK)),
                    icon: const Icon(FontAwesomeIcons.github, size: 22),
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
