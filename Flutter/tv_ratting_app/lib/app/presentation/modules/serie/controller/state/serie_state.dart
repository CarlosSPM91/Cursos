import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tv_ratting_app/app/domain/model/serie/serie.dart';

part 'serie_state.freezed.dart';

@freezed
class SerieState with _$SerieState {
  factory SerieState.loading() = SerieStateLoading;
  factory SerieState.failed() = SerieStateFailed;
  factory SerieState.loaded(Serie serie) = SerieStateLoaded;
}
