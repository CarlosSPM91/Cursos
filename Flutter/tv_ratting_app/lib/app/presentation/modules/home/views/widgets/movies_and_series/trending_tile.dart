import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/presentation/utils/get_image_url.dart';
import 'package:tv_ratting_app/app/presentation/utils/go_to_media_detail.dart';

class TrendingTile extends StatelessWidget {
  const TrendingTile({
    super.key,
    required this.media,
    required this.width,
    this.showData = true,
  });
  final Media media;
  final double width;
  final bool showData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goToMediaDetails(context, media);
        
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: SizedBox(
          width: width,
          child: Stack(
            children: [
              Positioned.fill(
                child: ExtendedImage.network(
                  loadStateChanged: (state) {
                    if (state.extendedImageLoadState == LoadState.loading) {
                      return Container(
                        color: Colors.black12,
                      );
                    }
                    return state.completedWidget;
                  },
                  getImageUrl(media.posterPath),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Opacity(
                  opacity: 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Chip(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        label: Icon(
                          media.type == MediaType.movie ? Icons.movie : Icons.tv,
                          size: 10,
                        ),
                      ),
                      SizedBox(height: width * 0.9),
                      Chip(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        label: Text(
                          media.voteAverage.toStringAsFixed(1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
