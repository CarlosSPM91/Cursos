import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/presentation/app_routes.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        initialRoute: Routes.splash,
        routes: appRoutes,
      ),
    );
  }
}
