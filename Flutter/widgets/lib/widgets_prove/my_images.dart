import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // Container(
            //   color: Colors.blue,
            //   child: Image.asset(
            //     "assets/images/arale.png",
            //     // width: 200,
            //     height: 300,
            //     // fit: BoxFit.fill,
            //   ),
            // ),
            Container(
              color: Colors.grey,
              child: Image.network(
                "https://th.bing.com/th/id/OIP.9DRV9YP8LCtEWQ0aqXQjBQHaFS?w=227&h=180&c=7&r=0&o=5&dpr=2&pid=1.7",
                loadingBuilder: (_, child, event) {
                  if (event == null) {
                    return child;
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Container(
              color: Colors.grey,
              child: CachedNetworkImage(
                imageUrl: "https://th.bing.com/th/id/OIP.9DRV9YP8LCtEWQ0aqXQjBQHaFS?w=227&h=180&c=7&r=0&o=5&dpr=2&pid=1.7",
                placeholder: (_, __) => const CircularProgressIndicator(),
                errorWidget: (_, __, error) => const Icon(Icons.error),
              ),
            )
          ],
        ),
      ),
    );
  }
}
