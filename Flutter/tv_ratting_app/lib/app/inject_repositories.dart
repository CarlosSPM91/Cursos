import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
import 'package:tv_ratting_app/app/domain/repositories/account_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/connectivity_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/language_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/movies_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/preferences_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/series_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/trending_repository.dart';
import 'package:tv_ratting_app/app/presentation/service_locator/service_locator.dart';

Future<void> injectRepositories({
  required bool systemDarkMode,
  required Http http,
  required String languageCode,
  required FlutterSecureStorage secureStorage,
  required SharedPreferences preferences,
  required Connectivity connectivity,
  required InternetChecker internetChecker,
}) async {
  final sessionService = SessionService(secureStorage);
  final languageService = LanguageService(languageCode);
  final accountAPI = AccountApi(
    http,
    sessionService,
    languageService,
  );
  final authenticationApi = AutenthicationAPI(http);

  ServiceLocator.instance.put<AccountRepository>(
    AccountRepositoryImpl(
      accountAPI,
      sessionService,
    ),
  );

  ServiceLocator.instance.put<PreferencesRepository>(
    PreferenceRepositoryImpl(
      preferences,
      systemDarkMode,
    ),
  );

  ServiceLocator.instance.put<LanguageRepository>(
    LanguageRepositoryImpl(languageService),
  );

  final connectivityRepository = ServiceLocator.instance.put<ConnectivityRepository>(
    ConnectivityRepositoryImpl(
      connectivity,
      internetChecker,
    ),
  );

  ServiceLocator.instance.put<AuthenticationRepository>(
    AuthenticationRepositoryImpl(
      sessionService,
      authenticationApi,
      accountAPI,
    ),
  );

  ServiceLocator.instance.put<TrendingRepository>(
    TrendingRepositoryImpl(
      TrendingApi(
        http,
        languageService,
      ),
    ),
  );

  ServiceLocator.instance.put<MoviesRepository>(
    MoviesRepositoryImpl(
      moviesApi: MoviesApi(
        http,
        languageService,
      ),
    ),
  );

  ServiceLocator.instance.put<SeriesRepository>(
    SeriesRepositoryImpl(
      seriesApi: SeriesApi(
        http,
        languageService,
      ),
    ),
  );

  await connectivityRepository.initialize();
}

class Repositories {
  Repositories._(); // coverage:ignore-line

  static AccountRepository get account => ServiceLocator.instance.find();

  ///
  static ConnectivityRepository get connectivity => ServiceLocator.instance.find();

  ///
  static LanguageRepository get language => ServiceLocator.instance.find();

  ///
  static PreferencesRepository get preferences => ServiceLocator.instance.find();

  ///
  static AuthenticationRepository get authentication => ServiceLocator.instance.find();

  ///
  static TrendingRepository get trending => ServiceLocator.instance.find();

  ///
  static MoviesRepository get movies => ServiceLocator.instance.find();

  ///
  ///
  static SeriesRepository get series => ServiceLocator.instance.find();
}
