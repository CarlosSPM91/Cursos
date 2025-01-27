import 'package:tv_ratting_app/app/domain/repositories/series_repository.dart';
import 'package:tv_ratting_app/app/presentation/global/state_notifier.dart';
import 'package:tv_ratting_app/app/presentation/modules/serie/controller/state/serie_state.dart';

class SerieController extends StateNotifier<SerieState> {
  final SeriesRepository serieRepository;
  final int serieId;

  SerieController(
    super.state, {
    required this.serieRepository,
    required this.serieId,
  });

  Future<void> init() async {
    state = SerieState.loading();
    final result = await serieRepository.getSerieById(serieId);
    state = result.when(
      left: (_) => state = SerieState.failed(),
      right: (serie) => SerieState.loaded(serie),
    );
  }
}
