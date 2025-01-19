import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/data/services/local/session_service.dart';
import 'package:tv_ratting_app/app/data/services/utils/handle_failure.dart';
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/domain/model/user/user.dart';

class AccountApi {
  final Http _http;
  final SessionService _sessionService;

  AccountApi(
    this._http,
    this._sessionService,
  );

  Future<User?> getAccount(String sessionId) async {
    final result = await _http.request(
      "/account",
      queryParameters: {
        "session_id": sessionId,
      },
      onSucces: (json) {
        return User.fromJson(json);
      },
    );
    return result.when(
      left: (_) => null,
      right: (user) => user,
    );
  }

  Future<Either<HttpRequestFailure, Map<int, Media>>> getFavorites(MediaType type) async {
    final sessionId = await _sessionService.sessionId ?? "";
    final accountId = await _sessionService.accountId;
    final result = await _http.request(
      "/account/$accountId/favorite/${type == MediaType.movie ? "movies" : "tv"}",
      queryParameters: {
        "session_id": sessionId,
      },
      onSucces: (json) {
        try {
          final list = json["results"] as List;
          final iterable = list.map(
            (e) {
              final media = Media.fromJson(
                {...e, "media_type": type.name},
              );
              return MapEntry(media.id, media);
            },
          );
          final Map<int, Media> map = {};
          map.addEntries(iterable);
          return map;
        } catch (e) {
          throw Exception("Error processing JSON: $e");
        }
      },
    );

    return result.when(
      left: handleHttpFailure,
      right: (value) => Either.right(value),
    );
  }
}
