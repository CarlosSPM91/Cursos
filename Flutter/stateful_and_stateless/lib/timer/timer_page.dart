import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => __HomePagStateState();
}

class __HomePagStateState extends State<HomePage> {
  Color _color = Colors.primaries.first;
  bool _showTimer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (_showTimer) TimerView(color: _color),
            Expanded(
                child: ListView.builder(
              itemBuilder: (_, index) {
                final color = Colors.primaries[index];
                return GestureDetector(
                  onTap: () {
                    _color = color;
                    setState(() {});
                  },
                  child: Container(
                    color: color,
                    height: 50,
                  ),
                );
              },
              itemCount: Colors.primaries.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTimer = !_showTimer;
          setState(() {});
        },
      ),
    );
  }
}

class TimerView extends StatefulWidget {
  final Color color;
  const TimerView({super.key, required this.color});

  @override
  State<TimerView> createState() => TimerViewStateState();
}

class TimerViewStateState extends State<TimerView> {
  int _time = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    print("init :)");
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        _time++;
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    print("dispose");
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TimerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      print(";)");
      _time=0;
    }

  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Text(
      "$_time",
      style: TextStyle(fontSize: 50, color: widget.color),
    );
  }
}
