import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:navigation/pages/color_picker.dart';

import '../routes.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  MaterialColor _color = Colors.red;

  void _onTap(BuildContext context) {
    final faker = Faker();
    final email = faker.internet.email();
    // final route = MaterialPageRoute(
    //   builder: (_) => LoginPage(email: email),
    // );
    // final route = MaterialPageRoute(
    //   settings: RouteSettings(
    //     arguments: faker.internet.email(),
    //   ),
    //   builder: (_) => LoginPage(),
    // );
    Navigator.pushNamed(
      context,
      Routes.login,
      arguments: email,
    );
    // Navigator.pushReplacement(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => _onTap(context),
            title: const Text("Go to Login"),
            trailing: const Icon(Icons.arrow_right_alt_outlined),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.counter);
            },
            title: const Text("Go to Counter"),
            trailing: const Icon(Icons.arrow_right_alt_outlined),
          ),
          ListTile(
            onTap: () async {
              // final route = MaterialPageRoute<MaterialColor>(
              //   builder: (_) => const ColorPicker(),
              // );
              // final  result = await Navigator.push(context, route);
              // print(result);
              final result =
                  await Navigator.pushNamed(context, Routes.colorPicker)
                      as MaterialColor?;

              if (result != null) {
                _color = result;
                setState(() {});
              }
            },
            title: const Text("Go to Pick Color"),
            trailing: const Icon(Icons.arrow_right_alt_outlined),
          ),
        ],
      ),
    );
  }
}
