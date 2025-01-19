import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/presentation/global/widgets/request_failed.dart';
import 'package:tv_ratting_app/app/presentation/modules/movie/controller/movie_controller.dart';
import 'package:tv_ratting_app/app/presentation/modules/movie/controller/state/movie_state.dart';
import 'package:tv_ratting_app/app/presentation/modules/movie/views/widgets/movie_app_bar.dart';
import 'package:tv_ratting_app/app/presentation/modules/movie/views/widgets/movie_content.dart';

class MovieView extends StatelessWidget {
  const MovieView({
    super.key,
    required this.movieId,
  });

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieController(
        MovieState.loading(),
        movieId: movieId,
        moviesRepository: context.read(),
      )..init(),
      builder: (context, _) {
        final MovieController controller = context.watch();
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: const MovieAppBar(),
          body: controller.state.map(
            loading: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
            failed: (_) => RequestFailed(
              onRetry: () => controller.init(),
            ),
            loaded: (state) => MovieContent(
              state: state,
            ),
          ),
        );
      },
    );
  }
}
