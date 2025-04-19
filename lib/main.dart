import 'package:cabo_counter/utility/styles.dart';
import 'package:cabo_counter/views/main_menu_view.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
          primaryColor: Styles.primaryColor,
          textTheme: CupertinoTextThemeData(
            primaryColor: Styles.primaryColor,
          )),
      home: MainMenuView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
