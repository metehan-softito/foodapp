import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kendin_ye/core/localization/app_localizations.dart';
import 'package:kendin_ye/core/theme/app_theme.dart';
import 'package:kendin_ye/presentation/navigation/app_router.dart';
import 'package:kendin_ye/presentation/screens/burger_login_screen.dart';
import 'package:kendin_ye/presentation/screens/main_screen.dart';

// GlobalKey to access the app state from anywhere
final GlobalKey<_MyAppState> appKey = GlobalKey<_MyAppState>();

void main() {
  runApp(MyApp(key: appKey));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;
  Locale _locale = const Locale('en');

  void setThemeMode(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.cartoon,
      darkTheme: AppTheme.realistic,
      themeMode: themeMode,
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('tr')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      onGenerateRoute: AppRouter.generateRoute, // ✅ THIS LINE
      initialRoute: '/',
    );
  }
}
