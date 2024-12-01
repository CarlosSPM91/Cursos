import 'package:flutter/material.dart';

class MyAspectRatio extends StatelessWidget {
  const MyAspectRatio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 16/9,
          child: Image.network(
            "https://th.bing.com/th/id/OIP.kSikzyUhe6MeYbfGe9jKKQHaEo?w=279&h=180&c=7&r=0&o=5&dpr=2&pid=1.7",
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
