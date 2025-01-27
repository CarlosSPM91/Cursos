
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/performer/performer.dart';
import 'package:tv_ratting_app/app/domain/model/serie/serie.dart';

abstract class SeriesRepository {
  Future<Either<HttpRequestFailure, Serie>> getSerieById(int serieId);
  Future<Either<HttpRequestFailure, List<Performer>>> getCastBySerie(int serieId);
}