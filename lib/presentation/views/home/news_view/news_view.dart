import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/buttons/floating_animated_button.dart';
import 'package:cabo_counter/presentation/components/widgets/news_tile.dart';
import 'package:cabo_counter/presentation/views/home/news_view/news.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:flutter/material.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final locale = loc.localeName;
    final newsItems = localizedNews.containsKey(locale)
        ? localizedNews[locale]
        : localizedNews['en'];

    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: SafeArea(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                spacing: 40,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Invisible element to have some spacing on top
                  const SizedBox.shrink(),

                  // Texts
                  Center(
                    child: Column(
                      children: [
                        // title
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

                        // Version
                        Text(
                          '${loc.version} ${VersionService.getVersionNumber()}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: CustomTheme.textColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Items
                  Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // News Items
                      for (final item in newsItems ?? [])
                        NewsTile(newsItem: item),
                    ],
                  ),

                  // Continue button
                  FloatingAnimatedButton(
                    onPressed: () => Navigator.pop(context),
                    text: loc.continu,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
