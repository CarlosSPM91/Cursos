import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/domain/model/movie/movie.dart';
import 'package:tv_ratting_app/app/presentation/utils/get_image_url.dart';

class MovieHeader extends StatelessWidget {
  const MovieHeader({
    super.key,
    required this.movie,
  });
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 14,
          child: ExtendedImage.network(
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            getImageUrl(
              movie.posterPath,
              imageQuality: ImageQuality.original,
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black54,
                  Colors.black,
                ],
              ),
            ),
            padding: const EdgeInsets.all(15).copyWith(top: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: movie.genres
                            .map(
                              (e) => Container(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  e.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 50),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: (movie.voteAverage / 10).clamp(
                          0,
                          1.0,
                        ),
                        color: Colors.amber,
                      ),
                    ),
                    Text(
                      movie.voteAverage.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
