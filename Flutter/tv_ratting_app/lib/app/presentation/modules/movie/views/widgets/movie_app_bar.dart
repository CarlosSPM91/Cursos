import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/favorites/favorites_controller.dart';
import 'package:tv_ratting_app/app/presentation/modules/movie/controller/movie_controller.dart';
import 'package:tv_ratting_app/app/presentation/utils/mark_as_favorite.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MovieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MovieController controller = context.watch();
    final FavoritesController favoritesController = context.watch();
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actions: controller.state.mapOrNull(
        loaded: (movieState) => [
          favoritesController.state.maybeMap(
            orElse: () => Container(
              width: 20,
              height: 10,
              color: Colors.red,
            ),
            loaded: (favoriteState) => IconButton(
              key: const Key('favorite-button'),
              onPressed: () => markAsFavorite(
                context: context,
                media: movieState.movie.toMedia(),
                mounted: () => controller.mounted,
              ),
              icon: Icon(
                favoriteState.movies.containsKey(
                  movieState.movie.id,
                )
                    ? Icons.favorite
                    : Icons.favorite_outline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
