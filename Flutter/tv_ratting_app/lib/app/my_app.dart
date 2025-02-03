import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/generated/translations.g.dart';
import 'package:tv_ratting_app/app/inject_repositories.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/theme_controller.dart';
import 'package:tv_ratting_app/app/presentation/global/theme.dart';
import 'package:tv_ratting_app/app/presentation/modules/splash/views/splash_view.dart';
import 'package:tv_ratting_app/app/presentation/routes/router.dart';

class MyApp extends StatefulWidget {
  final String? initialRoute;
  final Map<String, WidgetBuilder>? appRoutes;
  const MyApp({
    super.key,
    required this.initialRoute,
    this.appRoutes,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver, RouterMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    if (locales?.isNotEmpty ?? false) {
      final locale = locales!.first;
      Repositories.language.setLanguageCode(locale.languageCode);
      Intl.defaultLocale = locale.toLanguageTag();
      LocaleSettings.setLocaleRaw(
        locale.languageCode,
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = context.watch();
    if (loading) {
      return const SplashView();
    }
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp.router(
        theme: getTheme(themeController.darkMode),
        routerConfig: router,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocaleUtils.supportedLocales,
        locale: TranslationProvider.of(context).flutterLocale,
      ),
    );
  }
}
