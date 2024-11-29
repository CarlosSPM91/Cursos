import 'package:flutter/material.dart';

class MySingleChildScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        
        padding: EdgeInsets.all(10),
        child: Column(
          children: List.generate(
            18,
            (index) => Container(
              height: 100,
              color: Colors.primaries[index],
            ),
          ),
        ),
      ),
    );
  }
}
