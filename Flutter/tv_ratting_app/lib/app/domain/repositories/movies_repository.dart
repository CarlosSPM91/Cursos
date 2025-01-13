
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/movie/movie.dart';
import 'package:tv_ratting_app/app/domain/model/performer/performer.dart';

abstract class MoviesRepository {
  Future<Either<HttpRequestFailure, Movie>> getMovieById(int id);
  Future<Either<HttpRequestFailure, List<Performer>>> getCastByMovie(int movieId);
}