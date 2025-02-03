import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/authentication_repository_implementation.dart';
import 'package:tv_ratting_app/app/data/services/local/language_service.dart';
import 'package:tv_ratting_app/app/data/services/local/session_service.dart';
import 'package:tv_ratting_app/app/data/services/remote/account_api.dart';
import 'package:tv_ratting_app/app/data/services/remote/authentication_api.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';

import '../../../../mocks/mocks.dart';

void main() {
  group("AuthenticationRepositoryImpl - ", () {
    late AuthenticationRepository repository;
    late MockFlutterSecureStorage secureStorage;
    late MockClient client;

    setUp(() {
      secureStorage = MockFlutterSecureStorage();
      client = MockClient();

      final http = Http(
        client: client,
        baseURL: 'https://api.themoviedb.org/3',
        apiKey: '4248991ee7e5702debde74e854effa57',
      );
      final sessionService = SessionService(secureStorage);

      final autenthicationAPI = AutenthicationAPI(http);

      final accountApi = AccountApi(
        http,
        sessionService,
        LanguageService("es"),
      );

      repository = AuthenticationRepositoryImpl(
        sessionService,
        autenthicationAPI,
        accountApi,
      );
    });

    test("isSignedIn - true", () async {
      when(
        secureStorage.read(key: anyNamed('key')),
      ).thenAnswer(
        (_) async => "true",
      );

      final isSignedIn = await repository.isSignedIn;
      expect(isSignedIn, true);
    });

    test("isSignedIn - false", () async {
      when(
        secureStorage.read(key: anyNamed('key')),
      ).thenAnswer(
        (_) async => null,
      );

      final isSignedIn = await repository.isSignedIn;
      expect(isSignedIn, false);
    });

    test("signOut - true", () async {
      String? sessionId = "lala";

      when(
        secureStorage.read(
          key: anyNamed('key'),
        ),
      ).thenAnswer(
        (_) async => sessionId,
      );

      when(
        secureStorage.deleteAll(),
      ).thenAnswer(
        (_) async {
          sessionId = null;
        },
      );

      expect(
        await repository.isSignedIn,
        true,
      );

      repository.signOut();

      expect(
        await repository.isSignedIn,
        false,
      );
    });
  });

  ///
}
