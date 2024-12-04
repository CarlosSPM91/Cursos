import 'package:flutter/material.dart';

class KeyboardTypesPage extends StatelessWidget {
  const KeyboardTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(25),
        children: [
          const TextField(
            keyboardType: TextInputType.emailAddress,
            enabled: true,
            decoration: InputDecoration(
              label: Text("Email"),
              border: OutlineInputBorder(),
              disabledBorder: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 20,
          ),
          const TextField(
            keyboardType: TextInputType.phone,
            enabled: true,
            decoration: InputDecoration(
              label: Text("Phone"),
              border: OutlineInputBorder(),
              disabledBorder: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const TextField(
            keyboardType: TextInputType.numberWithOptions(signed: true),
            enabled: true,
            decoration: InputDecoration(
              label: Text("Price"),
              border: OutlineInputBorder(),
              disabledBorder: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            autocorrect: false,
            enableSuggestions: true,
            keyboardType: TextInputType.name,
            enabled: true,
            decoration: const InputDecoration(
              label: Text("Name"),
              border: OutlineInputBorder(),
              disabledBorder: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (_) {
              print(" ==)");
            },
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Send"),
          ),
        ],
      ),
    );
  }
}
