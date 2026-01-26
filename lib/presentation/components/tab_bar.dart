import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/about/about_view.dart';
import 'package:cabo_counter/presentation/views/home/main_menu_view.dart';
import 'package:cabo_counter/services/icon_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// TabBar for navigating between the main menu and about section.
///
/// [TabBar] is a [StatefulWidget] that provides a tabbed interface for navigating
/// between the main menu and the about section of the app. It uses a
/// [CupertinoTabScaffold] with two tabs:
/// - Home (MainMenuView)
/// - About (AboutView)
///
/// The tab labels are provided via localization.
class TabBar extends StatefulWidget {
  const TabBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<TabBar> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: tabIndex == 0 ? const MainMenuView() : const AboutView(),
      bottomNavigationBar: Theme(
        // TODO: Temporary fix to remove splash effect on bottom navigation bar
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 5,
          selectedFontSize: 14,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedFontSize: 14,
          fixedColor: CustomTheme.primaryColor,
          backgroundColor: CustomTheme.navBarBackgroundColor,
          enableFeedback: false,
          currentIndex: tabIndex,
          onTap: (int newIndex) {
            setState(() {
              tabIndex = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(IconService.home),
              label: loc.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(IconService.info),
              label: loc.about,
            ),
          ],
        ),
      ),
    );
  }
}
