import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';

void goToMediaDetails(
  BuildContext context,
  Media media,
) async {
  if (media.type == MediaType.movie) {
    context.pushNamed(
      Routes.movie,
      pathParameters: {"id": "${media.id}"},
    );
  } else {
    context.pushNamed(
      Routes.serie,
      pathParameters: {"id": "${media.id}"},
    );
  }
}
