import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/data/services/local/language_service.dart';
import 'package:tv_ratting_app/app/data/services/utils/handle_failure.dart';
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/performer/performer.dart';
import 'package:tv_ratting_app/app/domain/model/serie/serie.dart';

class SeriesApi {
  final Http _http;
  final LanguageService _languageService;

  SeriesApi(
    this._http,
    this._languageService,
  );

  Future<Either<HttpRequestFailure, Serie>> getSeriebyId(int serieId) async {
    final result = await _http.request(
      "/tv/$serieId",
      languageCode: _languageService.languageCode,
      onSucces: (json) {
        return Serie.fromJson(json);
      },
    );
    return result.when(
      left: handleHttpFailure,
      right: (serie) => Either.right(serie),
    );
  }

  Future<Either<HttpRequestFailure, List<Performer>>> getCastBySerie(
    int serieId,
  ) async {
    final result = await _http.request(
      "/tv/$serieId/credits",
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
