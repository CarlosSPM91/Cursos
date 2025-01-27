import 'dart:ui' as ui;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/account_repository_impl.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/authentication_repository_implementation.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/language_repository_impl.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/movies_repository_impl.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/preference_repository_impl.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/series_repository_impl.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/trending_repository_impl.dart';
import 'package:tv_ratting_app/app/data/services/local/language_service.dart';
import 'package:tv_ratting_app/app/data/services/local/session_service.dart';
import 'package:tv_ratting_app/app/data/services/remote/account_api.dart';
import 'package:tv_ratting_app/app/data/services/remote/authentication_api.dart';
import 'package:tv_ratting_app/app/data/services/remote/internet_checker.dart';
import 'package:tv_ratting_app/app/data/services/remote/movies_api.dart';
import 'package:tv_ratting_app/app/data/services/remote/series_api.dart';
import 'package:tv_ratting_app/app/data/services/remote/trending_api.dart';
import 'package:tv_ratting_app/app/domain/api_key.dart';
import 'package:tv_ratting_app/app/domain/repositories/account_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/connectivity_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/language_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/movies_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/preferences_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/series_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/trending_repository.dart';
import 'package:tv_ratting_app/app/generated/translations.g.dart';
import 'package:tv_ratting_app/app/my_app.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/favorites/favorites_controller.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/favorites/state/favorites_state.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/session_controller.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/theme_controller.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  Intl.defaultLocale = LocaleSettings.currentLocale.languageCode;
  final sessionService = SessionService(const FlutterSecureStorage());
  final languageService = LanguageService(AppLocaleUtils.findDeviceLocale().languageCode);
  print("language service: ${languageService.languageCode}");
  final http = Http(
    baseURL: ApiKey.baseURL,
    apiKey: ApiKey.apiKey,
    client: Client(),
  );
  final acountAPI = AccountApi(
    http,
    sessionService,
    languageService,
  );
  final sysDarkMode = ui.PlatformDispatcher.instance.platformBrightness == Brightness.dark;

  final connectivity = ConnectivityRepositoryImpl(
    Connectivity(),
    InternetChecker(),
  );
  final preferences = await SharedPreferences.getInstance();
  await connectivity.initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider<AccountRepository>(
          create: (_) {
            return AccountRepositoryImpl(
              acountAPI,
              sessionService,
            );
          },
        ),
        Provider<ConnectivityRepository>(
          create: (_) => connectivity,
        ),
        Provider<LanguageRepository>(
          create: (_) => LanguageRepositoryImpl(languageService),
        ),
        Provider<AuthenticationRepository>(
          create: (_) {
            return AuthenticationRepositoryImpl(
              sessionService,
              AutenthicationAPI(http),
              acountAPI,
            );
          },
        ),
        Provider<TrendingRepository>(
          create: (_) => TrendingRepositoryImpl(
            TrendingApi(
              http,
              languageService,
            ),
          ),
        ),
        Provider<MoviesRepository>(
          create: (_) => MoviesRepositoryImpl(
            moviesApi: MoviesApi(
              http,
              languageService,
            ),
          ),
        ),
        Provider<SeriesRepository>(
          create: (_) => SeriesRepositoryImpl(
            seriesApi: SeriesApi(
              http,
              languageService,
            ),
          ),
        ),
        Provider<PreferencesRepository>(
          create: (_) {
            return PreferenceRepositoryImpl(
              preferences,
            );
          },
        ),
        ChangeNotifierProvider<SessionController>(
          create: (context) => SessionController(
            authenticationRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider<FavoritesController>(
          create: (context) => FavoritesController(
            FavoritesState.loading(),
            accountRepository: context.read(),
          ),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (context) {
            final PreferencesRepository preferencesRepository = context.read();
            return ThemeController(
              preferencesRepository.darkMode ?? sysDarkMode,
              preferencesRepository: preferencesRepository,
            );
          },
        ),
      ],
      child: TranslationProvider(
        child: const MyApp(),
      ),
    ),
  );
}

// class Injector extends InheritedWidget {
//   const Injector({
//     super.key,
//     required super.child,
//     required this.authenticationRepository,
//   });

//   final AuthenticationRepository authenticationRepository;

//   @override
//   // ignore: avoid_renaming_method_parameters
//   bool updateShouldNotify(_) => false;

//   static Injector of(BuildContext context) {
//     final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
//     assert(injector != null, "Injector could not be found");
//     return injector!;
//   }
// }
