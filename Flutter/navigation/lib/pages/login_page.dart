import 'package:flutter/material.dart';
import 'package:navigation/pages/profile_page.dart';

class LoginPage extends StatelessWidget {
  final String email;
  const LoginPage({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    // final modalRoute = ModalRoute.of(context)!;
    // final email = modalRoute.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(Icons.arrow_back),
        // ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          MaterialButton(
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (_) => const ProfilePage(),
                settings: const RouteSettings(),
              );
              Navigator.push(context, route);
            },
            child: Text("LOGIN PAGE $email"),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: Colors.primaries.length,
                itemBuilder: (_, index) {
                  return Container(
                    height: 70,
                    color: Colors.primaries[index],
                  );
                }),
          ),
        ],
      )),
    );
  }
}
