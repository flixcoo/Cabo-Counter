import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/dto/NewsItem.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/NewsTile.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:cabo_counter/services/vibration_service.dart';
import 'package:flutter/material.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final locale = loc.localeName;
    final items = NewsItems.containsKey(locale)
        ? NewsItems[locale]
        : NewsItems['en'];

    return Dialog.fullscreen(
      backgroundColor: CustomTheme.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text(
              loc.whats_new,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: CustomTheme.textColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            Text(
              '${loc.version} ${VersionService.getVersionNumber()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: CustomTheme.textColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in items ?? []) NewsTile(newsItem: item),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 28, 28),
              child: SizedBox(
                height: 52,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => {
                    VibrationService.selectionClick(),
                    Navigator.pop(context),
                  },
                  child: Text(
                    loc.continu,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
