import 'package:flutter/material.dart';

class MyStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.black),
        child: Container(
          color: Colors.white,
          child: Center(
            child: Container(
              color: Colors.grey,
              width: 400,
              height: 400,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.green,
                      child: Text("data"),
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.blue,
                  ),
                  const Text("hi"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
