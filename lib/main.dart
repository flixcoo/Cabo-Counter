import 'package:cabo_counter/utility/theme.dart' as theme;
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
        primaryColor: theme.primaryColor,
        scaffoldBackgroundColor: theme.backgroundColor,
        textTheme: CupertinoTextThemeData(
          primaryColor: theme.primaryColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'CABO-Counter',
      home: MainMenuView(),
    );
  }
}
