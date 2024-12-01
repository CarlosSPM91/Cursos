import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Avatar extends StatelessWidget {
  final double size;
  final String asset;
  final double borderWidht;

  const Avatar({
    super.key,
    required this.size,
    required this.asset,
    this.borderWidht = 0,
  });

  @override
  Widget build(BuildContext context) {
    final bool fromNetwork = asset.startsWith("http://") || asset.startsWith("https://");
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: borderWidht, color: Colors.white),
        image: DecorationImage(
          image: fromNetwork? CachedNetworkImageProvider(asset): AssetImage(asset),
          fit: BoxFit.cover,
        ),
      ),
    );
    // Otra opcion
    // return Center(
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(size * 0.5),
    //     child: Image.asset(
    //       asset,
    //       width: size,
    //       height: size,
    //     ),
    //   ),
    // );
  }
}
