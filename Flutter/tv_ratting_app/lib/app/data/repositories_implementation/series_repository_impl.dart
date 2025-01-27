import 'package:tv_ratting_app/app/data/services/remote/series_api.dart';
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/performer/performer.dart';
import 'package:tv_ratting_app/app/domain/model/serie/serie.dart';
import 'package:tv_ratting_app/app/domain/repositories/series_repository.dart';

class SeriesRepositoryImpl implements SeriesRepository {
  final SeriesApi _seriesApi;

  SeriesRepositoryImpl({
    required SeriesApi seriesApi,
  }) : _seriesApi = seriesApi;

  @override
  Future<Either<HttpRequestFailure, Serie>> getSerieById(int serieId) {
    return _seriesApi.getSeriebyId(serieId);
  }

  @override
  Future<Either<HttpRequestFailure, List<Performer>>> getCastBySerie(int serieId) {
    return _seriesApi.getCastBySerie(serieId);
  }
}
