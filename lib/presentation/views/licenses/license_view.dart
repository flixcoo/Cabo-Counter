import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/licenses/license_detail_view.dart';
import 'package:cabo_counter/presentation/views/licenses/oss_licenses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LicenseView extends StatelessWidget {
  const LicenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppLocalizations.of(context).licenses),
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
                        builder: (_) => LicenceDetailView(
                          title: ossLicenses[index].name[0].toUpperCase() +
                              ossLicenses[index].name.substring(1),
                          licence: ossLicenses[index].license!,
                        ),
                      ),
                    );
                  },
                  trailing: const CupertinoListTileChevron(),
                  title: Text(
                    ossLicenses[index].name[0].toUpperCase() +
                        ossLicenses[index].name.substring(1),
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
