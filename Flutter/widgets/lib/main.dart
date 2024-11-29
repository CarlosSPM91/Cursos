import 'package:flutter/material.dart';
import 'package:widgets/widgets/stack.dart';
import '/widgets/row.dart';
import '/widgets/column.dart';
import '/widgets/container.dart';
import '/widgets/stack.dart';
import '/widgets/scaffold.dart';
import '/widgets/safe_area.dart';
import '/widgets/single_child_scroll_view.dart';
import '/widgets/custom_icon.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomIcons(),
      
    );
  }
}
