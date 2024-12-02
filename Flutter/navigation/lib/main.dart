import 'package:flutter/material.dart';
import 'package:navigation/app_routes.dart';

import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation test',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: Routes.initialRoute,
      routes: appRoutes,
    );
  }
}
