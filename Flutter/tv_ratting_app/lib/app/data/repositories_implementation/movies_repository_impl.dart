import 'package:tv_ratting_app/app/data/services/remote/movies_api.dart';
import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/movie/movie.dart';
import 'package:tv_ratting_app/app/domain/model/performer/performer.dart';
import 'package:tv_ratting_app/app/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesApi _moviesApi;

  MoviesRepositoryImpl({
    required MoviesApi moviesApi,
  }) : _moviesApi = moviesApi;

  @override
  Future<Either<HttpRequestFailure, Movie>> getMovieById(int id) {
    return _moviesApi.getMoviebyId(id);
  }

  @override
  Future<Either<HttpRequestFailure, List<Performer>>> getCastByMovie(int movieId) {
    return _moviesApi.getCastByMovie(movieId);
  }
}
