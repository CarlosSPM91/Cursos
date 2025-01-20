import 'package:tv_ratting_app/app/domain/either/either.dart';
import 'package:tv_ratting_app/app/domain/failures/http_request/http_request_failure.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/domain/repositories/account_repository.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/favorites/state/favorites_state.dart';
import 'package:tv_ratting_app/app/presentation/global/state_notifier.dart';

class FavoritesController extends StateNotifier<FavoritesState> {
  final AccountRepository accountRepository;

  FavoritesController(
    super.stat, {
    required this.accountRepository,
  });

  Future<void> init() async {
    state = FavoritesState.loading();
    final moviesResult = await accountRepository.getFavorites(
      MediaType.movie,
    );

    state = await moviesResult.when(
      left: (_) => state = FavoritesState.failed(),
      right: (movies) async {
        final seriesResult = await accountRepository.getFavorites(
          MediaType.tv,
        );

        return seriesResult.when(
          left: (_) => state = FavoritesState.failed(),
          right: (series) => FavoritesState.loaded(
            movies: movies,
            series: series,
          ),
        );
      },
    );
  }

  Future<Either<HttpRequestFailure, void>> markAsFavorite(Media media) async {
    assert(state is FavoritesStateLoaded);
    final loadedState = state as FavoritesStateLoaded;

    final isMovie = media.type == MediaType.movie;
    final map = isMovie ? {...loadedState.movies} : {...loadedState.series};
    final favorite = !map.keys.contains(media.id);
    final result = await accountRepository.markAsFavorite(
      mediaId: media.id,
      type: media.type,
      favorite: favorite,
    );

    result.whenOrNull(
      right: (_) {
        if (favorite) {
          map[media.id] = media;
        } else {
          map.remove(media.id);
        }
        state = isMovie ? loadedState.copyWith(movies: map) : loadedState.copyWith(series: map);
      },
    );
    return result;
  }
}
