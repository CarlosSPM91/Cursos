import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/presentation/utils/get_image_url.dart';
import 'package:tv_ratting_app/app/presentation/utils/go_to_media_detail.dart';

class FavoritesList extends StatefulWidget {
  final List<Media> items;
  const FavoritesList({
    super.key,
    required this.items,
  });

  @override
  State<FavoritesList> createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (_, index) {
          final item = widget.items[index];

          return MaterialButton(
            onPressed: () {
              goToMediaDetails(context, item);
            },
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                ExtendedImage.network(
                  getImageUrl(
                    item.posterPath,
                  ),
                  width: 60,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        item.overview,
                        maxLines: 3,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
