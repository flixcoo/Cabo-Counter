import 'package:cabo_counter/l10n/app_localizations.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/local_storage_service.dart';
import 'package:cabo_counter/utility/custom_theme.dart';
import 'package:cabo_counter/utility/globals.dart';
import 'package:cabo_counter/views/tab_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await ConfigService.initConfig();
  Globals.pointLimit = await ConfigService.getPointLimit();
  Globals.caboPenalty = await ConfigService.getCaboPenalty();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    LocalStorageService.loadGameSessions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      LocalStorageService.saveGameSessions();
    }
  }

  @override
  Widget build(BuildContext context) {
    LocalStorageService.loadGameSessions();

    return CupertinoApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'), // English
        Locale('de'), // German
      ],
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: CustomTheme.primaryColor,
        scaffoldBackgroundColor: CustomTheme.backgroundColor,
        textTheme: CupertinoTextThemeData(
          primaryColor: CustomTheme.primaryColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Cabo Counter',
      home: const TabView(),
    );
  }
}
