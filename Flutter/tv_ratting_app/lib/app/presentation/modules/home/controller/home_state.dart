import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/domain/model/performer/performer.dart';
import 'package:tv_ratting_app/app/domain/time_window.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(
      MoviesAndSeriesState.loading(
        TimeWindow.day,
      ),
    )
    MoviesAndSeriesState moviesAndSeries,
    @Default(
      PerformersState.loading(),
    )
    PerformersState performers,
  }) = _HomeState;
}

@freezed
class MoviesAndSeriesState with _$MoviesAndSeriesState {
  const factory MoviesAndSeriesState.loading(
    TimeWindow timeWindow,
  ) = MoviesAndSeriesStateLoading;
  const factory MoviesAndSeriesState.failed(
    TimeWindow timeWindow,
  ) = MoviesAndSeriesStateFailed;
  const factory MoviesAndSeriesState.loaded({
    required List<Media> list,
    required TimeWindow timeWindow,
  }) = MoviesAndSeriesStateLoaded;
}

@freezed
class PerformersState with _$PerformersState {
  const factory PerformersState.loading() = PerformersStateLoading;
  const factory PerformersState.failed() = PerformersStatFailed;
  const factory PerformersState.loaded(
    List<Performer> list,
  ) = PerformersStateLoaded;
}
