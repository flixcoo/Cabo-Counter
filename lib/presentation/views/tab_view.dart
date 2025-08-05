import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/about/about_view.dart';
import 'package:cabo_counter/presentation/views/home/main_menu_view.dart';
import 'package:flutter/cupertino.dart';

/// A view that provides a tabbed interface for navigating between the main menu and the about section.
class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: false,
      tabBar: CupertinoTabBar(
          backgroundColor: CustomTheme.mainElementBackgroundColor,
          iconSize: 27,
          height: 55,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(
                CupertinoIcons.house_fill,
              ),
              label: AppLocalizations.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                CupertinoIcons.info,
              ),
              label: AppLocalizations.of(context).about,
            ),
          ]),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(builder: (BuildContext context) {
          if (index == 0) {
            return const MainMenuView();
          } else {
            return const AboutView();
          }
        });
      },
    );
  }
}
