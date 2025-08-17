import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/about/licenses/license_detail_view.dart';
import 'package:cabo_counter/presentation/views/about/licenses/oss_licenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A view that displays a list of the open source software licenses used in the app.
/// It allows users to tap on a license to view its details in a separate screen.
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
          itemCount: ossLicenses.length,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
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
                          title: ossLicenses[index].name,
                          license: ossLicenses[index].license ??
                              AppLocalizations.of(context).no_license_text,
                        ),
                      ),
                    );
                  },
                  trailing: const CupertinoListTileChevron(),
                  title: Text(
                    ossLicenses[index].name,
                    style: GoogleFonts.roboto(),
                  ),
                  subtitle: Text(ossLicenses[index].description),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
