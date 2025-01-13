import 'package:tv_ratting_app/app/domain/repositories/trending_repository.dart';
import 'package:tv_ratting_app/app/domain/time_window.dart';
import 'package:tv_ratting_app/app/presentation/global/state_notifier.dart';
import 'package:tv_ratting_app/app/presentation/modules/home/controller/home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController(
    super.state, {
    required this.trendingRepository,
  });
  final TrendingRepository trendingRepository;

  Future<void> init() async {
    loadMoviesAndSeries();
    loadPerformers();
  }

  void onTimeWindowChanged(TimeWindow timeWindow) {
    if (state.moviesAndSeries.timeWindow != timeWindow) {
      state = state.copyWith(
        moviesAndSeries: MoviesAndSeriesState.loading(timeWindow),
      );
      loadMoviesAndSeries();
    }
  }

  Future<void> loadPerformers({
    PerformersState? performers,
  }) async {
    if (performers != null) {
      state = state.copyWith(performers: performers);
    }
    final result = await trendingRepository.getPerformers();
    state = result.when(
        left: (_) => state.copyWith(
              performers: const PerformersState.failed(),
            ),
        right: (list) => state = state.copyWith(
              performers: PerformersState.loaded(list),
            ));
  }

  Future<void> loadMoviesAndSeries({
    MoviesAndSeriesState? moviesAndSeries,
  }) async {
    if (moviesAndSeries != null) {
      state = state.copyWith(moviesAndSeries: moviesAndSeries);
    }
    final result = await trendingRepository.getMoviesAndSeries(
      state.moviesAndSeries.timeWindow,
    );
    state = result.when(
      left: (_) => state.copyWith(
        moviesAndSeries: MoviesAndSeriesState.failed(state.moviesAndSeries.timeWindow),
      ),
      right: (list) => state.copyWith(
        moviesAndSeries: MoviesAndSeriesState.loaded(
          list: list,
          timeWindow: state.moviesAndSeries.timeWindow,
        ),
      ),
    );
  }
}
