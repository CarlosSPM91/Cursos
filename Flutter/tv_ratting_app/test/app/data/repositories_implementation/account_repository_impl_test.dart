import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/account_repository_impl.dart';
import 'package:tv_ratting_app/app/data/services/local/language_service.dart';
import 'package:tv_ratting_app/app/data/services/local/session_service.dart';
import 'package:tv_ratting_app/app/data/services/remote/account_api.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';

import '../../../mocks/mocks.dart';

void main() {
  late MockClient client;
  late MockFlutterSecureStorage secureStorage;
  late AccountRepositoryImpl repository;

  setUp(
    () {
      client = MockClient();

      secureStorage = MockFlutterSecureStorage();

      final sessionService = SessionService(
        secureStorage,
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

      repository = AccountRepositoryImpl(
        accountAPI,
        sessionService,
      );
    },
  );

  void mockGet({
    required int statusCode,
    required Map<String, dynamic> json,
  }) {
    when(
      client.get(
        any,
        headers: anyNamed('headers'),
      ),
    ).thenAnswer(
      (_) async => Response(
        jsonEncode(json),
        statusCode,
      ),
    );
  }

  test(
    'AccountRepositoryImpl - getUserData',
    () async {
      mockGet(
        statusCode: 200,
        json: {
          "id": 0,
          "username": "carlo",
          "avatar": {},
        },
      );

      when(
        secureStorage.read(key: anyNamed('key')),
      ).thenAnswer(
        (_) async => 'lala',
      );

      final user = await repository.getUserData();
      expect(user, isNotNull);
    },
  );

  test('AccountRepositoryImpl - getFavorites - fail', () async {
    mockGet(
      statusCode: 401,
      json: {
        "status_code": 3,
        "status_message": "",
      },
    );

    final result = await repository.getFavorites(
      MediaType.movie,
    );

    expect(result.value, isA<HttpRequestFailure>());
  });

  test('AccountRepositoryImpl - getFavorites - exit', () async {
    mockGet(
      statusCode: 200,
      json: {
        "page": 1,
        "results": [
          {
            "backdrop_path": "/vYqt6kb4lcF8wwqsMMaULkP9OEn.jpg",
            "id": 1241982,
            "title": "Moana 2",
            "original_title": "Moana 2",
            "overview":
                "After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she's ever faced.",
            "poster_path": "/aLVkiINlIeCkcZIzb7XHzPYgO6L.jpg",
            "media_type": "movie",
            "adult": false,
            "original_language": "en",
            "genre_ids": [16, 12, 10751, 35, 9648],
            "popularity": 2859.74,
            "vote_average": 8.2,
            "vote_count": 44,
          },
        ],
      },
    );

    final result = await repository.getFavorites(
      MediaType.movie,
    );

    expect(result.value, isA<Map<int, Media>>());
  });
}
