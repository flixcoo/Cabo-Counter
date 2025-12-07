import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/about/licenses/license_detail_view.dart';
import 'package:cabo_counter/presentation/views/about/licenses/oss_licenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Displays a list of open source software licenses used in the app.
///
/// Users can tap on a license to view its details on a separate screen.
/// This view uses a Cupertino design and supports localization.
///
/// See also:
///   - [LicenseDetailView] for displaying license details.
///   - [ossLicenses] for the list of licenses.
class LicenseView extends StatelessWidget {
  const LicenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context).licenses),
        previousPageTitle: AppLocalizations.of(context).about,
      ),
      child: SafeArea(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: allDependencies.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CupertinoListTile(
                  backgroundColor: CustomTheme.backgroundColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => LicenseDetailView(
                          title: allDependencies[index].name,
                          description: allDependencies[index].description,
                          license: allDependencies[index].license ??
                              AppLocalizations.of(context).no_license_text,
                        ),
                      ),
                    );
                  },
                  trailing: const CupertinoListTileChevron(),
                  title: Text(
                    allDependencies[index].name,
                    style: GoogleFonts.roboto(),
                  ),
                  subtitle: Text(allDependencies[index].description),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
