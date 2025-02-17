import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  final int initialValue;

  CounterPage({
    required this.initialValue,
  });

  @override
  State<CounterPage> createState() {
    return CounterPageState();
  }
}

class CounterPageState extends State<CounterPage> {
  late int counter;

  @override
  void initState() {
    super.initState();
    counter = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          "$counter",
          style: const TextStyle(
            fontSize: 40,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter++;
          setState(() {});
        },
      ),
    );
  }
}
