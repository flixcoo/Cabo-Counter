import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter/cupertino.dart';

class LicenceDetailView extends StatelessWidget {
  final String title, licence;
  const LicenceDetailView(
      {super.key, required this.title, required this.licence});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: AppLocalizations.of(context).licenses,
        middle: Text(
          AppLocalizations.of(context).license_details,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                    color: CustomTheme.buttonBackgroundColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Text(
                  licence,
                  style: const TextStyle(fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
