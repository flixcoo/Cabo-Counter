import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/tab_bar.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure the app runs in portrait mode only
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // Initialize services
  await ConfigService.initConfig();
  await VersionService.init();
  await ConfigService.setMigrationDone(false);
  runApp(
    Provider<AppDatabase>(
      create: (_) => db,
      child: const App(),
    ),
  );
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
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      /// Preload images when the app is resumed
      precacheImage(
          const AssetImage('assets/cabo_counter-logo_rounded.png'), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'), // English
        Locale('de'), // German
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (final supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: CupertinoThemeData(
        applyThemeToAll: true,
        brightness: Brightness.dark,
        primaryColor: CustomTheme.primaryColor,
        scaffoldBackgroundColor: CustomTheme.backgroundColor,
        textTheme: CupertinoTextThemeData(
          primaryColor: CustomTheme.primaryColor,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Cabo Counter',
      home: const TabBar(),
    );
  }
}
