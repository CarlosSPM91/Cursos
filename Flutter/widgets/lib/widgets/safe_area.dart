import 'package:flutter/material.dart';

class MySafeSrea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Text("HELLO"),
              Expanded(
                child: Container(
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
