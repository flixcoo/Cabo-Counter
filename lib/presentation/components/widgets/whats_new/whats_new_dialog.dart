import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/widgets/whats_new/whats_new_item.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:flutter/material.dart';

class WhatsNewDialog extends StatelessWidget {
  const WhatsNewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
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
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                children: [
                  WhatsNewItem(
                    icon: IconService.shuffle_cards,
                    title: loc.wn_item_1,
                    text: loc.wn_description_1,
                  ),
                  const SizedBox(height: 28),
                  WhatsNewItem(
                    icon: Icons.navigation,
                    title: AppLocalizations.of(context).wn_item_2,
                    text: AppLocalizations.of(context).wn_description_2,
                  ),
                ],
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
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    loc.ok,
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
