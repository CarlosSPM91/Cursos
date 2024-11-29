import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:widgets/icons/house_custom_icons.dart';

class CustomIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              HouseCustom.image2vector,
              size: 100,
            ),
            Icon(
              CupertinoIcons.arrow_down_right_arrow_up_left,
              size: 50,
              color: Colors.amber,
              semanticLabel: "icono reloj",
            ),
          ],
        ),
      ),
    );
  }
}
