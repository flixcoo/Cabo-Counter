import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart'
    show AppLocalizations;
import 'package:flutter/cupertino.dart';

/// Displays the details of a specific open source software license in a Cupertino-style view.
///
/// This view presents the license title and its full text in a scrollable layout.
///
/// Required parameters:
/// - [title]: The name of the license.
/// - [license]: The full license text to display.
class LicenseDetailView extends StatelessWidget {
  final String title, description, license;
  const LicenseDetailView({
    super.key,
    required this.title,
    required this.description,
    required this.license,
  });

  @override
  Widget build(BuildContext context) {
    print(description);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context).license_details),
        previousPageTitle: AppLocalizations.of(context).licenses,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
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
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: CustomTheme.buttonBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(license, style: const TextStyle(fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
