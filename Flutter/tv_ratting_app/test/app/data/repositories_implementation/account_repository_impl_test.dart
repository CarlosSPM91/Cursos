import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/account_repository_impl.dart';
import 'package:tv_ratting_app/app/data/services/local/language_service.dart';
import 'package:tv_ratting_app/app/data/services/local/session_service.dart';
import 'package:tv_ratting_app/app/data/services/remote/account_api.dart';

import '../../../mocks/mocks.dart';

void main() {
  test(
    'AccountRepositoryImpl > getUserData',
    () async {
      final client = MockClient();
      final secureStorage = MockFlutterSecureStorage();
      final sessionService = SessionService(
        secureStorage,
      );

      when(
        secureStorage.read(key: anyNamed('key')),
      ).thenAnswer(
        (_) async => 'lala',
      );

      when(
        client.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer(
        (_) async => Response(
          jsonEncode({
            "id": 0,
            "username": "carlo",
            "avatar": {},
          }),
          200,
        ),
      );

      final accountAPI = AccountApi(
        Http(
          client: client,
          baseURL: 'https://api.themoviedb.org/3',
          apiKey: '4248991ee7e5702debde74e854effa57',
        ),
        sessionService,
        LanguageService('en'),
      );

      final repository = AccountRepositoryImpl(
        accountAPI,
        sessionService,
      );

      final user = await repository.getUserData();
      expect(user, isNotNull);
    },
  );
}
