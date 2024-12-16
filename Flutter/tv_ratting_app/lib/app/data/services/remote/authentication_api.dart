import 'dart:convert';

import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/domain/either.dart';
import 'package:tv_ratting_app/app/domain/enums.dart';

class AutenthicationAPI {
  // final _apiKey = "fb9888dbd1f188ef5dcc0b4ead5bcfa8";
  // final String _baseUrl = "https://api.themoviedb.org/3";
  AutenthicationAPI(this._http);
  final Http _http;

  Future<Either<SignInFailure, String>> createRequestToken() async {
    final result = await _http.request(
      "/authentication/token/new",
    );

    return result.when(
      (failure) {
        if (failure.exception is NetworkException) {
          return Either.left(SignInFailure.network);
        }
        return Either.left(SignInFailure.unknown);
      },
      (responseBody) {
        final json = Map<String, dynamic>.from(jsonDecode(responseBody));
        return Either.right(["request_token"] as String);
      },
    );
  }

  Future<Either<SignInFailure, String>> createSessionwithLogin(
      {required String username,
      required String password,
      required String requestToken}) async {
    final result = await _http.request(
      "/authentication/token/validate_with_login",
      method: HttpMethod.post,
      body: {
        "username": username,
        "password": password,
        "request_token": requestToken
      },
    );

    return result.when(
      (failure) {
        if (failure.statusCode != null) {
          if (failure.exception is NetworkException) {
            return Either.left(SignInFailure.network);
          }
          switch (failure.statusCode) {
            case 401:
              return Either.left(SignInFailure.unAuthorized);
            case 402:
              return Either.left(SignInFailure.notFound);
          }
        }
        return Either.left(SignInFailure.unknown);
      },
      (responseBody) {
        final json = Map<String, dynamic>.from(jsonDecode(responseBody));
        final newRequestToken = json["request_token"] as String;
        return Either.right(newRequestToken);
      },
    );
  }

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    final result = await _http.request("/authentication/session/new",
        method: HttpMethod.post, body: {"request_token": requestToken});

    return result.when(
      (failure) {
        if (failure.exception is NetworkException) {
          return Either.left(SignInFailure.network);
        }
        return Either.left(SignInFailure.unknown);
      },
      (responseBody) {
        final json = Map<String, dynamic>.from(jsonDecode(responseBody));

        final sessionId = json["session_id"] as String;
        return Either.right(sessionId);
      },
    );
  }
}
