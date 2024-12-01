import 'package:faker/faker.dart' as fake;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets/facebook_ui/widgets/publication_item.dart';
import 'package:widgets/facebook_ui/widgets/quick_actions.dart';
import 'package:widgets/facebook_ui/widgets/stories.dart';
import 'package:widgets/facebook_ui/widgets/whats_on_your_mind.dart';
import 'package:widgets/icons/custom_icons_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widgets/models/publication.dart';
import './widgets/circle_button.dart';

class FacebookUi extends StatelessWidget {
  @override
  Widget build(Object context) {
    final faker = fake.Faker();
    final publications = <Publication>[];

    for (int i = 0; i < 50; i++) {
      final random = faker.randomGenerator;
      final reactioIndex = random.integer(Reaction.values.length - 1);

      final publication = Publication(
        currentUser: User(
          avatar: faker.image.loremPicsum(),
          username: faker.person.name(),
        ),
        title: faker.lorem.sentence(),
        createdAt: faker.date.dateTime(),
        imageUrl: faker.image.loremPicsum(),
        commentsCount: random.integer(50000),
        sharesCount: random.integer(50000),
        currenReaction: Reaction.values[reactioIndex],
      );
      publications.add(publication);
    }

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
          const SizedBox(height: 10),
          const WhatIsOnYourMind(),
          const SizedBox(height: 20),
          const QuickActions(),
          const SizedBox(height: 20),
          Stories(),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) => PublicationItem(
              publication: publications[index],
            ),
            itemCount: publications.length,
          ),
        ],
      ),
    );
  }
}
