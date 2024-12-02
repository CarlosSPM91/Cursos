import 'package:flutter/material.dart';

import '../routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: Container(),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            // Navigator.popUntil(context, (route) {
            //   return (route.settings.name == Routes.initialRoute)? true : false;
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.initialRoute,
              (route) => false,
              // {
              //   return route.settings.name == Routes.home;
              // },
            );
          },
          child: const Text("LOG OUT"),
        ),
      ),
    );
  }
}
