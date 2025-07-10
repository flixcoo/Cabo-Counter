import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/utility/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationView extends StatelessWidget {
  const InformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        navigationBar: CupertinoNavigationBar(
          middle: Text(AppLocalizations.of(context).about),
        ),
        child: SafeArea(
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
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: SizedBox(
                  height: 200,
                  child: Image.asset('assets/cabo_counter-logo_rounded.png'),
                )),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  AppLocalizations.of(context).about_text,
                  textAlign: TextAlign.center,
                  softWrap: true,
                )),
            const SizedBox(
              height: 30,
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
                        launchUrl(Uri.parse(Constants.INSTAGRAM_LINK)),
                    icon: const Icon(FontAwesomeIcons.instagram)),
                IconButton(
                    onPressed: () =>
                        launchUrl(Uri.parse('mailto:${Constants.EMAIL}')),
                    icon: const Icon(CupertinoIcons.envelope)),
                IconButton(
                    onPressed: () =>
                        launchUrl(Uri.parse(Constants.GITHUB_LINK)),
                    icon: const Icon(FontAwesomeIcons.github)),
              ],
            ),
          ],
        )));
  }
}
