import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/views/about/about_view.dart';
import 'package:cabo_counter/presentation/views/home/main_menu_view.dart';
import 'package:flutter/cupertino.dart';

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
