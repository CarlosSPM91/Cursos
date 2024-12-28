import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/domain/either.dart';
import 'package:tv_ratting_app/app/domain/failures/sign_in/sign_in_failure.dart';

class AutenthicationAPI {
  // final _apiKey = "fb9888dbd1f188ef5dcc0b4ead5bcfa8";
  // final String _baseUrl = "https://api.themoviedb.org/3";
  AutenthicationAPI(this._http);
  final Http _http;

  Either<SignInFailure, String> _handleFailure(HttpFailure failure) {
    if (failure.statusCode != null) {
      if (failure.exception is NetworkException) {
        return Either.left(SignInFailure.network());
      }
      switch (failure.statusCode) {
        case 401:
          return Either.left(SignInFailure.unauthorized(),);
        case 402:
          return Either.left(SignInFailure.notFound(),);
      }
    }
    return Either.left(SignInFailure.unkown());
  }

  Future<Either<SignInFailure, String>> createRequestToken() async {
    final result = await _http.request("/authentication/token/new",
        onSucces: (responseBody) {
      final json = responseBody as Map;
      return json["request_token"] as String;
    });

    return result.when(
      left: _handleFailure,
      right: (requestToken) => Either.right(requestToken),
    );
  }

  Future<Either<SignInFailure, String>> createSessionwithLogin(
      {required String username,
      required String password,
      required String requestToken}) async {
    final result = await _http.request(
      "/authentication/token/validate_with_login",
      onSucces: (responseBody) {
        final json = responseBody as Map;
        return json["request_token"] as String;
      },
      method: HttpMethod.post,
      body: {
        "username": username,
        "password": password,
        "request_token": requestToken
      },
    );

    return result.when(
      left: _handleFailure,
      right: (requestToken) => Either.right(requestToken),
    );
  }

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    final result = await _http.request("/authentication/session/new",
        onSucces: (responseBody) {
      final json = responseBody as Map;
      return json["session_id"] as String;
    }, method: HttpMethod.post, body: {"request_token": requestToken});

    return result.when(
      left: _handleFailure,
      right: (sessionId) => Either.right(sessionId),
    );
  }
}
