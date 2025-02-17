import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/data/services/local/language_service.dart';
import 'package:tv_ratting_app/app/data/services/utils/handle_failure.dart';
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/movie/movie.dart';
import 'package:tv_ratting_app/app/domain/model/performer/performer.dart';

class MoviesApi {
  final Http _http;
  final LanguageService _languageService;

  MoviesApi(
    this._http,
    this._languageService,
  );

  Future<Either<HttpRequestFailure, Movie>> getMoviebyId(int id) async {
    final result = await _http.request(
      "/movie/$id",
      languageCode: _languageService.languageCode,
      onSucces: (json) {
        return Movie.fromJson(json);
      },
    );
    return result.when(
      left: handleHttpFailure,
      right: (movie) => Either.right(movie),
    );
  }

  Future<Either<HttpRequestFailure, List<Performer>>> getCastByMovie(
    int movieId,
  ) async {
    final result = await _http.request(
      "/movie/$movieId/credits",
      languageCode: _languageService.languageCode,
      onSucces: (json) {
        final list = json["cast"] as List;
        return list
            .where(
              (e) => e["known_for_department"] == "Acting" && e["profile_path"] != null,
            )
            .map(
              (e) => Performer.fromJson(e),
            )
            .toList();
      },
    );

    return result.when(
      left: handleHttpFailure,
      right: (cast) => Either.right(cast),
    );
  }
}
