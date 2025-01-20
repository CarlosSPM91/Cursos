import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/presentation/modules/movie/views/movie_view.dart';

Future<void> goToMediaDetails(BuildContext context, Media media) async {
  if (media.type == MediaType.movie) {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MovieView(
          movieId: media.id,
        ),
      ),
    );
  }
}
