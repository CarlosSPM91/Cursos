import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: DefaultTextStyle(
        style: TextStyle(),
        child: Container(
          // width: 200,
          // height: 200,
          color: Colors.red,
          margin: EdgeInsets.symmetric(horizontal: 20),
          // alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 30,
          ),
          // decoration: BoxDecoration(
          // shape: BoxShape.circle,
          // gradient: LinearGradient(
          //   colors: const [
          //     Colors.blueAccent,
          //     Colors.cyanAccent,
          //     Colors.greenAccent,
          //   ],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   stops: const [
          //     0.05,
          //     0.5,
          //     0.95,
          //   ],
          // gradient: RadialGradient(
          //   colors: [
          //     Colors.white,
          //     Colors.cyanAccent.withOpacity(.2),
          //     Colors.cyanAccent,
          //   ],
          //   stops: const [
          //     0.75,
          //     0.95,
          //     1,
          //   ],
          // ),
          // boxShadow: [
          // BoxShadow(
          //   color: Colors.blue.withOpacity(.5),
          //   blurRadius: 10,
          //   // spreadRadius: 5 , aumentar la longitud de la sombra
          //   offset: Offset(-3, -5), //mover la sombra
          // ),
          // BoxShadow(
          //   color: Colors.red.withOpacity(0.5),
          //   blurRadius: 10,
          // ),
          // ],
          child: Text(
            "Carlos",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
