import 'package:flutter/material.dart';

class FavoritesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FavoritesAppBar({
    super.key,
    required this.tabController,
  });
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      title: const Text("Favorites"),
      centerTitle: true,
      bottom: TabBar(
        labelPadding: const EdgeInsets.symmetric(vertical: 10),
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: const _Decoration(
          color: Colors.amber,
          width: 20,
        ),
        tabs: const [
          Tab(
            text: "Movies",
          ),
          Tab(
            text: "Series",
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}

class _Decoration extends Decoration {
  final Color color;
  final double width;

  const _Decoration({
    required this.color,
    required this.width,
  });
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _Painter(color: color, width: width);
}

class _Painter extends BoxPainter {
  final Color color;
  final double width;

  _Painter({
    required this.color,
    required this.width,
  });

  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final paint = Paint()..color = color;
    final size = configuration.size ?? Size.zero;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.5 + offset.dx - width * 0.5,
          size.height * 0.75,
          width,
          width * 0.4,
        ),
        const Radius.circular(4),
      ),
      paint,
    );

    // canvas.drawCircle(
    //   Offset(size.width * 0.5 + offset.dx, size.height * 0.8),
    //   4,
    //   paint,
    // );
  }
}
