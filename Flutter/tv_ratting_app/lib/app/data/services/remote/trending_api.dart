import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/data/services/utils/handle_failure.dart';
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/domain/model/performer/performer.dart';
import 'package:tv_ratting_app/app/domain/time_window.dart';
import 'package:tv_ratting_app/app/domain/typedefs.dart';

class TrendingApi {
  final Http _http;

  TrendingApi(this._http);

  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(TimeWindow timeWindow) async {
    final result = await _http.request(
      "/trending/all/${timeWindow.name}",
      onSucces: (json) {
        final list = List<Json>.from(json["results"]);
        // final List<Media> items = [];
        // for (final item in list) {
        //   items.add(
        //     Media.fromJson(item),
        //   );
        // }
        return getMediaList(list);
      },
    );

    return result.when(
      left: handleHttpFailure,
      right: (list) => Either.right(list),
    );
  }

  Future<Either<HttpRequestFailure, List<Performer>>> getPerformers(TimeWindow timeWindow) async {
    final result = await _http.request(
      "/trending/person/${timeWindow.name}",
      onSucces: (json) {
        final list = List<Json>.from(json["results"]);
        return list
            .where(
              (i) =>
              i["known_for_department"] == "Acting" &&
              i["profile_path"] != null,
            )
            .map((e) => Performer.fromJson(e)).toList();
      },
    );

    return result.when(
      left: handleHttpFailure,
      right: (list) => Either.right(list),
    );
  }
}
