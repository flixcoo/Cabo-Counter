import 'package:cabo_counter/core/custom_theme.dart';
import 'package:cabo_counter/data/db/database.dart';
import 'package:cabo_counter/l10n/generated/app_localizations.dart';
import 'package:cabo_counter/presentation/components/custom_navigation_bar.dart';
import 'package:cabo_counter/services/config_service.dart';
import 'package:cabo_counter/services/version_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure the app runs in portrait mode only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Initialize services
  await ConfigService.initConfig();
  await VersionService.init();
  await ConfigService.setMigrationDone(false);
  runApp(
    Provider<AppDatabase>(
      create: (context) => AppDatabase(),
      child: const CaboCounterApp(),
      dispose: (context, databaseInstance) => databaseInstance.close(),
    ),
  );
}

class CaboCounterApp extends StatefulWidget {
  const CaboCounterApp({super.key});

  @override
  State<StatefulWidget> createState() => _CaboCounterAppState();
}

class _CaboCounterAppState extends State<CaboCounterApp>
    with WidgetsBindingObserver {
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
      precacheImage(
        const AssetImage('assets/cabo_counter-logo_rounded.png'),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      theme: ThemeData(
        brightness: Brightness.dark,

        // colors
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        primaryColor: CustomTheme.primaryColor,
        scaffoldBackgroundColor: CustomTheme.backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: CustomTheme.primaryColor,
          brightness: Brightness.dark,
          primary: CustomTheme.primaryColor,
          onPrimary: CustomTheme.textColor,
          surface: CustomTheme.backgroundColor,
          onSurface: CustomTheme.textColor,
        ),

        // icon button
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(CustomTheme.primaryColor),
          ),
        ),

        // text button
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 17)),
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
          ),
        ),

        // texts
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),

        // app bar
        appBarTheme: const AppBarTheme(
          backgroundColor: CustomTheme.backgroundColor,
          foregroundColor: CustomTheme.textColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: CustomTheme.textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Cabo Counter',
      home: const CustomNavigationBar(),
    );
  }
}
