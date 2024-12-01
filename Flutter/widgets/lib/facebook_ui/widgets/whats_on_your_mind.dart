import 'package:flutter/material.dart';
import 'package:widgets/facebook_ui/widgets/avatar.dart';

class WhatIsOnYourMind extends StatelessWidget {
  const WhatIsOnYourMind({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: const [
          Avatar(size: 40, asset: "assets/users/1.jpg"),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: Text(
              "What's on yout mind, Lisa?",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
