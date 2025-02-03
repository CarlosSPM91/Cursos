import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/authentication_repository_implementation.dart';
import 'package:tv_ratting_app/app/data/services/local/language_service.dart';
import 'package:tv_ratting_app/app/data/services/local/session_service.dart';
import 'package:tv_ratting_app/app/data/services/remote/account_api.dart';
import 'package:tv_ratting_app/app/data/services/remote/authentication_api.dart';
import 'package:tv_ratting_app/app/domain/failures/sign_in/sign_in_failure.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';

import '../../../../mocks/mocks.dart';

void main() {
  group(
    "AuthenticationRepositoryImpl - ",
    () {
      late AuthenticationRepository repository;
      late MockFlutterSecureStorage secureStorage;
      late MockClient client;

      setUp(
        () {
          client = MockClient();
          secureStorage = MockFlutterSecureStorage();

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
        },
      );

      Future<void> mockGet({
        required String path,
        required int statusCode,
        required Map<String, dynamic> response,
      }) {
        final completer = Completer();
        when(
          client.get(
            Uri.parse(path),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer(
          (_) async {
            completer.complete();
            return Response(
              jsonEncode(response),
              statusCode,
            );
          },
        );
        return completer.future;
      }

      Future<void> mockPost({
        required String path,
        required int statusCode,
        required Map<String, dynamic> response,
      }) {
        final completer = Completer();
        when(
          client.post(
            Uri.parse(path),
            headers: anyNamed("headers"),
            body: anyNamed("body"),
          ),
        ).thenAnswer(
          (_) async {
            completer.complete();
            return Response(
              jsonEncode(response),
              statusCode,
            );
          },
        );
        return completer.future;
      }

      test(
        "signIn - CreateRequestToken - fail",
        () async {
          mockGet(
            path: "/authentication/token/new?api_key",
            statusCode: 401,
            response: {
              "status_code": 3,
              "status_message": "",
            },
          );

          final result = await repository.signIn(
            "username",
            "password",
          );

          expect(
            result.value,
            isA<SignInFailure>(),
          );
        },
      );

      test(
        "signIn - CreateSessionWithLogin - fail",
        () async {
          mockGet(
            path: "/authentication/token/new?api_key=apiKey&language=en",
            statusCode: 200,
            response: {
              'success': true,
              'expires_at': '2025-08-26 17:04:39 UTC',
              'request_token': 'ff5c7eeb5a8870efe3cd7fc5c282cffd26800ecd',
            },
          );

          final future = mockPost(
            path: "/authentication/token/validate_with_login?api_key=apiKey&language=en",
            statusCode: 401,
            response: {
              'status_message': '',
              'success': false,
              'status_code': 32,
            },
          );

          final result = await repository.signIn(
            "username",
            "password",
          );
          await future;
          expect(result.value, isA<SignInFailure>());
        },
      );
    },
  );

  ///
}
