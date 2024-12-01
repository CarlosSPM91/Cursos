import 'package:flutter/material.dart';
import 'package:widgets/facebook_ui/widgets/avatar.dart';
import 'package:widgets/models/story.dart';

import 'story_item.dart';

class Stories extends StatelessWidget {
  final _stories = [
    Story(
      bg: "assets/wallpapers/1.jpeg",
      avatar: "assets/users/1.jpg",
      username: "Laura",
    ),
    Story(
      bg: "assets/wallpapers/2.jpeg",
      avatar: "assets/users/2.jpg",
      username: "Alix",
    ),
    Story(
      bg: "assets/wallpapers/3.jpeg",
      avatar: "assets/users/3.jpg",
      username: "Moa",
    ),
    Story(
      bg: "assets/wallpapers/4.jpeg",
      avatar: "assets/users/4.jpg",
      username: "Lucie",
    ),
    Story(
      bg: "assets/wallpapers/5.jpeg",
      avatar: "assets/users/5.jpg",
      username: "Pepe",
    ),
  ];

  Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final story = _stories[index];
          return StoryItem(
            story: story,
            isFirst: index == 0,
          );
        },
        itemCount: _stories.length,
      ),
    );
  }
}

