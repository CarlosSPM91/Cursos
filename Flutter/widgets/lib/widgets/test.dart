import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(),
        child: Text(
          "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto."
          "Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500,"
          "cuando un impresor (N. del T. persona que se dedica a la imprenta) ",
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
