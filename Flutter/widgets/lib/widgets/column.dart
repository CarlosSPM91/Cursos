import 'package:flutter/material.dart';

class MyColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.black),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Center(
          child: Container(
            color: Colors.grey,
            width: 400,
            child: Column(
              children: [
                 Flexible(
                  child: Container(
                    color: Colors.blue,
                    child: FlutterLogo(
                      size: 100,
                    ),
                  ),
                ),
                const Flexible(
                  child: FlutterLogo(
                    size: 200,
                  ),
                ),
                const Flexible(
                  child: FlutterLogo(
                    size: 300,
                  ),
                ),
                Container(
                  height: 100,
                  width: 300,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
