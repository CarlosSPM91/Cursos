import 'package:flutter/material.dart';

class RadioButtonPage extends StatefulWidget {
  const RadioButtonPage({super.key});

  @override
  State<RadioButtonPage> createState() => _RadioButtonPageState();
}

class _RadioButtonPageState extends State<RadioButtonPage> {
  String? _better;
  String? _gender;

  void _onBetterChanged(String? value) {
    setState(() {
      _better = value;
    });
  }

  void _onGenderChanged(String? value) {
    setState(() {
      _gender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const Text("Witch is better?"),
            Row(
              children: [
                Radio<String>(
                  value: "Flutter",
                  groupValue: _better,
                  onChanged: _onBetterChanged,
                ),
                const Text("Flutter"),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: "React Native",
                  groupValue: _better,
                  onChanged: _onBetterChanged,
                ),
                const Text("React Native")
              ],
            ),
            const Divider(),
            const Text("What is your gender?"),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text("Male"),
                  value: "Male",
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  groupValue: _gender,
                  onChanged: _onGenderChanged,
                ),
                RadioListTile<String>(
                  title: const Text("Famele"),
                  value: "Famale",
                  contentPadding: EdgeInsets.zero,
                  groupValue: _gender,
                  dense: true,
                  onChanged: _onGenderChanged,
                  activeColor: Colors.black,
                ),
                RadioListTile<String>(
                  title: const Text("Other"),
                  value: "Other",
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  groupValue: _gender,
                  onChanged: _onGenderChanged,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
