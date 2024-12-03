import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import '../routes.dart';

class PageData {
  final String name;
  final String label;
  final Object? arguments;
  final void Function(Object?)? onResult;

  const PageData({
    required this.name,
    required this.label,
    this.arguments,
    this.onResult,
  });
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  MaterialColor _color = Colors.red;

  // void _onTap(BuildContext context) {
  // final faker = Faker();
  // final email = faker.internet.email();
  // final route = MaterialPageRoute(
  //   builder: (_) => LoginPage(email: email),
  // );
  // final route = MaterialPageRoute(
  //   settings: RouteSettings(
  //     arguments: faker.internet.email(),
  //   ),
  //   builder: (_) => LoginPage(),
  // );
  // Navigator.pushNamed(
  //   context,
  //   Routes.login,
  //   arguments: email,
  // );
  // Navigator.pushReplacement(context, route);
  // }

  @override
  void initState() {
    super.initState();
    _pages = <PageData>[
      const PageData(
        name: Routes.login,
        label: "Go to Login",
        arguments: "test@test.com",
      ),
      const PageData(
        name: Routes.counter,
        label: "Go to counter",
      ),
      PageData(
        name: Routes.colorPicker,
        label: "Pick color",
        onResult: (result) {
          if (result is MaterialColor) {
            _color = result;
            setState(() {});
          }
        },
      ),
      const PageData(
        name: Routes.dialogs,
        label: "Go to dialogs",
      ),
    ];
  }

  late final List<PageData> _pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          final data = _pages[index];
          return ListTile(
            title: Text(data.label),
            onTap: () async {
              final result = await Navigator.pushNamed(context, data.name,
                  arguments: data.arguments);
                  if(data.onResult != null){ data.onResult!(result);}
            },
          );
        },
        itemCount: _pages.length,
      ),
    );
  }
}
