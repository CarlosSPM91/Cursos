import 'package:flutter/material.dart';
import 'package:widgets/icons/custom_icons_icons.dart';
import 'circle_button.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          children: const [
            _QuickButton(
              label: 'Gallery',
              iconData: CustomIcons.photos,
              color: Color(0xffbaddac),
            ),
            SizedBox(width: 15,),
            _QuickButton(
              label: 'Tag Friends',
              iconData: CustomIcons.user_friends,
              color: Color(0xff92bbee),
            ),
            SizedBox(width: 15,),
            _QuickButton(
              label: 'Live',
              iconData: CustomIcons.video_camera,
              color: Color(0xffefa498),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickButton extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final String label;

  const _QuickButton({
    super.key,
    required this.color,
    required this.iconData,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color.withOpacity(0.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleButton(color: color.withOpacity(0.8), iconData: iconData),
          SizedBox(
            width: 15,
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
