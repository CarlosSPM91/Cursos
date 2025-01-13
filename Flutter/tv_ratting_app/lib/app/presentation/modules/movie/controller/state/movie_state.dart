import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tv_ratting_app/app/domain/model/movie/movie.dart';

part 'movie_state.freezed.dart';

@freezed
class MovieState with _$MovieState {
  factory MovieState.loading() = MovieStateLoading;
  factory MovieState.failed() = MovieStateFailed;
  factory MovieState.loaded(Movie movie) = MovieStateLoaded;
}
