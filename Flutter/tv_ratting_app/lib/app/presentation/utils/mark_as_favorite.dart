import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/favorites/favorites_controller.dart';

Future<void> markAsFavorite({
  required BuildContext context,
  required Media media,
  required bool Function() mounted
}) async {
  final FavoritesController favoritesController = context.read();
  final result = await favoritesController.markAsFavorite(media);
  if(!mounted()){
    return;
  }
  result.whenOrNull(
    left: (failure) {
      final errorMessage = failure.when(
        notFound: () => "Resource not Found",
        network: () => "Network Error",
        unauthorized: () => "Unauthorized",
        unknown: () => "Unkown error",
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    },
  );
}
