import 'package:cabo_counter/utility/apptheme.dart';
import 'package:cabo_counter/views/information_view.dart';
import 'package:cabo_counter/views/main_menu_view.dart';
import 'package:flutter/cupertino.dart';

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
      tabBar: CupertinoTabBar(
          backgroundColor: AppTheme.backgroundTintColor,
          iconSize: 27,
          height: 55,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.house_fill,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.info,
              ),
              label: 'About',
            ),
          ]),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(builder: (BuildContext context) {
          if (index == 0) {
            return const MainMenuView();
          } else {
            return const InformationView();
          }
        });
      },
    );
  }
}
