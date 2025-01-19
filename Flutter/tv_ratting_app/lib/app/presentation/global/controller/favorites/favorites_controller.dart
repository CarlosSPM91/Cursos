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
}
