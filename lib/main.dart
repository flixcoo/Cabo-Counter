import 'package:cabo_counter/utility/theme.dart';
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
        brightness: Brightness.dark,
        primaryColor: Theme.primaryColor,
        scaffoldBackgroundColor: Theme.backgroundColor,
        textTheme: CupertinoTextThemeData(
          primaryColor: Theme.primaryColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Cabo Counter',
      home: const MainMenuView(),
    );
  }
}
