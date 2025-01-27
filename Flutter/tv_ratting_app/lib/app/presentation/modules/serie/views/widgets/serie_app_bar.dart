import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/favorites/favorites_controller.dart';
import 'package:tv_ratting_app/app/presentation/modules/serie/controller/serie_controller.dart';
import 'package:tv_ratting_app/app/presentation/utils/mark_as_favorite.dart';

class SerieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SerieAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final SerieController controller = context.watch();
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
              onPressed: () => markAsFavorite(
                context: context,
                media: movieState.serie.toMedia(),
                mounted: () => controller.mounted,
              ),
              icon: Icon(
                favoriteState.movies.containsKey(
                  movieState.serie.id,
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
