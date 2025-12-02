import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/home/whats_new/whats_new_item.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:flutter/material.dart';

class WhatsNewDialog extends StatelessWidget {
  const WhatsNewDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: CustomTheme.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Text(
              AppLocalizations.of(context).whats_new,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            Text(
              'Version ${VersionService.getVersionNumber()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text('Build ${VersionService.getBuildNumber()}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withAlpha(150),
                  fontSize: 14,
                )),
            const SizedBox(height: 40),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                children: [
                  WhatsNewItem(
                      icon: IconService.shuffle_cards,
                      title: 'Person zum Mischen',
                      text:
                          'In der Rundenübersicht wird angezeigt, wer mischt. In den Einstellungen kannst du festlegen, ob standardmäßig der vorherige Verlierer oder rotierend gemischt wird.'),
                  const SizedBox(height: 28),
                  const WhatsNewItem(
                      icon: Icons.navigation,
                      title: 'Verbesserte Navigation',
                      text:
                          'Chevrons wurden hinzugefügt, um die Bedienung übersichtlicher und intuitiver zu machen.'),
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
                    AppLocalizations.of(context).continue_button,
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
