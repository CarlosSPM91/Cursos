import 'package:flutter/material.dart';

import '../../models/story.dart';
import 'avatar.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({
    super.key,
    required this.story,
    required this.isFirst,
  });

  final Story story;
  final bool isFirst;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: isFirst ? 20 : 0, right: 10),
      height: 160,
      width: 90,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 20,
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(story.bg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Avatar(
                    size: 40,
                    asset: story.avatar,
                    borderWidht: 2,
                  ),
                ),
              ],
            ),
          ),
          Text(
            story.username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
