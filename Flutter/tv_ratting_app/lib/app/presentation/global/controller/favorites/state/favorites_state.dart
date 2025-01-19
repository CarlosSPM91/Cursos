

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {

  factory FavoritesState.loading() = _FavoritesStateLoading;
  factory FavoritesState.failed() = _FavoritesStateFailed;
  factory FavoritesState.loaded({
    required Map<int, Media> movies,
    required Map<int, Media> series,
  }) = _FavoritesStateLoaded;

}