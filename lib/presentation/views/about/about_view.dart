import 'package:cabo_counter/core/constants.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/about/licenses/license_view.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          middle: Text(AppLocalizations.of(context).about),
        ),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  AppLocalizations.of(context).app_name,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '${AppLocalizations.of(context).app_version} ${VersionService.getVersionWithBuild()}',
                style: TextStyle(fontSize: 15, color: Colors.grey[300]),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: SizedBox(
                    height: 200,
                    child: Image.asset('assets/cabo_counter-logo_rounded.png'),
                  )),
              CupertinoButton(
                sizeStyle: CupertinoButtonSize.medium,
                padding: EdgeInsets.zero,
                child: Text(AppLocalizations.of(context).privacy_policy),
                onPressed: () =>
                    launchUrl(Uri.parse(Constants.kPrivacyPolicyLink)),
              ),
              CupertinoButton(
                sizeStyle: CupertinoButtonSize.medium,
                padding: EdgeInsets.zero,
                child: Text(AppLocalizations.of(context).imprint),
                onPressed: () => launchUrl(Uri.parse(Constants.kImprintLink)),
              ),
              CupertinoButton(
                  sizeStyle: CupertinoButtonSize.medium,
                  padding: EdgeInsets.zero,
                  child: Text(AppLocalizations.of(context).licenses),
                  onPressed: () => Navigator.push(context,
                      CupertinoPageRoute(builder: (_) => const LicenseView()))),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '\u00A9 Felix Kirchner',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () =>
                          launchUrl(Uri.parse(Constants.kInstagramLink)),
                      icon: const Icon(FontAwesomeIcons.instagram)),
                  IconButton(
                      onPressed: () =>
                          launchUrl(Uri.parse('mailto:${Constants.kEmail}')),
                      icon: const Icon(CupertinoIcons.envelope)),
                  IconButton(
                      onPressed: () =>
                          launchUrl(Uri.parse(Constants.kGithubLink)),
                      icon: const Icon(FontAwesomeIcons.github)),
                ],
              ),
            ],
          ),
        )));
  }
}
