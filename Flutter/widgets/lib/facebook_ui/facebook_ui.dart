import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets/facebook_ui/widgets/quick_actions.dart';
import 'package:widgets/facebook_ui/widgets/stories.dart';
import 'package:widgets/facebook_ui/widgets/whats_on_your_mind.dart';
import 'package:widgets/icons/custom_icons_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './widgets/circle_button.dart';

class FacebookUi extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 150,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        leading: SvgPicture.asset(
          'assets/logos/facebook.svg',
          colorFilter: ColorFilter.mode(Colors.blueAccent, BlendMode.srcIn),
          width: 150,
        ),
        actions: const [
          CircleButton(
            color: Color(0xffBFBFBF),
            iconData: CustomIcons.search,
          ),
          SizedBox(
            width: 15,
          ),
          CircleButton(
            color: Color(0xffFE7574),
            iconData: CustomIcons.bell,
          ),
          SizedBox(
            width: 15,
          ),
          CircleButton(
            color: Color(0xff7BBAFF),
            iconData: CustomIcons.user_friends,
            showBadge: true,
          ),
          SizedBox(
            width: 15,
          ),
          CircleButton(
            color: Color(0xff1C86E4),
            iconData: CustomIcons.messenger,
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          WhatIsOnYourMind(),
          SizedBox(height: 20),
          QuickActions(),
          SizedBox(height: 20),
          Stories(),
        ],
      ),
    );
  }
}
