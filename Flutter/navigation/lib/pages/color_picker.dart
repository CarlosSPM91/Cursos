import 'package:flutter/material.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: Colors.primaries.length,
          itemBuilder: (_, index) {
            final color = Colors.primaries[index];
            return GestureDetector(
              onTap: (){
                Navigator.pop(context, color);
              },
              child: Container(
                height: 70,
                color: Colors.primaries[index],
              ),
            );
          }),
    );
  }
}
