import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/presentation/modules/movie/controller/state/movie_state.dart';
import 'package:tv_ratting_app/app/presentation/modules/movie/views/widgets/movie_cast.dart';
import 'package:tv_ratting_app/app/presentation/modules/movie/views/widgets/movie_header.dart';

class MovieContent extends StatelessWidget {
  const MovieContent({
    super.key,
    required this.state,
  });

  final MovieStateLoaded state;

  @override
  Widget build(BuildContext context) {
    final movie = state.movie;
    return SingleChildScrollView(
      child: Column(
        children: [
          MovieHeader(movie: movie),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(movie.overview),
          ),
          MovieCast(movieId: movie.id),
        ],
      ),
    );
  }
}
