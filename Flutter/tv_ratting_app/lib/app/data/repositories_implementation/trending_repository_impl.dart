import 'package:tv_ratting_app/app/data/services/remote/trending_api.dart';
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/domain/repositories/trending_repository.dart';
import 'package:tv_ratting_app/app/domain/time_window.dart';

class TrendingRepositoryImpl extends TrendingRepository {
  final TrendingApi _trendingApi;

  TrendingRepositoryImpl(this._trendingApi);

  @override
  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(TimeWindow timeWindow) {
    return _trendingApi.getMoviesAndSeries(timeWindow);
  }
}
