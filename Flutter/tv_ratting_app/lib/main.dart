import 'dart:ui' as ui;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/data/services/remote/internet_checker.dart';
import 'package:tv_ratting_app/app/domain/api_key.dart';
import 'package:tv_ratting_app/app/domain/repositories/preferences_repository.dart';
import 'package:tv_ratting_app/app/generated/translations.g.dart';
import 'package:tv_ratting_app/app/inject_repositories.dart';
import 'package:tv_ratting_app/app/my_app.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/favorites/favorites_controller.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/favorites/state/favorites_state.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/session_controller.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/theme_controller.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    setPathUrlStrategy();
    LocaleSettings.useDeviceLocale();
    Intl.defaultLocale = LocaleSettings.currentLocale.languageCode;

    final http = Http(
      baseURL: ApiKey.baseURL,
      apiKey: ApiKey.apiKey,
      client: Client(),
    );

    final sysDarkMode = ui.PlatformDispatcher.instance.platformBrightness == Brightness.dark;

    await injectRepositories(
      systemDarkMode: sysDarkMode,
      http: http,
      secureStorage: const FlutterSecureStorage(),
      languageCode: LocaleSettings.currentLocale.languageCode,
      preferences: await SharedPreferences.getInstance(),
      connectivity: Connectivity(),
      internetChecker: InternetChecker(),
    );

    runApp(const Root());
  } catch (e, stackTrace) {
    debugPrint("Error en main: $e\n$stackTrace");
  }
}

class Root extends StatelessWidget {
  final String? initialRoute;
  final List<GoRoute>? overrideRoutes;
  const Root({
    super.key,
    this.initialRoute,
    this.overrideRoutes,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeController>(
          create: (context) {
            final PreferencesRepository preferencesRepository = Repositories.preferences;
            return ThemeController(
              preferencesRepository.darkMode,
              preferencesRepository: preferencesRepository,
            );
          },
        ),
        ChangeNotifierProvider<SessionController>(
          create: (context) => SessionController(
            authenticationRepository: Repositories.authentication,
          ),
        ),
        ChangeNotifierProvider<FavoritesController>(
          create: (context) => FavoritesController(
            FavoritesState.loading(),
            accountRepository: Repositories.account,
          ),
        ),
      ],
      child: TranslationProvider(
        child: MyApp(
          initialRoute: initialRoute,
          overrideRoutes: overrideRoutes,
        ),
      ),
    );
  }
}
