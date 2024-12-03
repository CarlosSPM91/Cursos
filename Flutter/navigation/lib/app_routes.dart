import 'package:flutter/material.dart';
import 'package:navigation/pages/color_picker.dart';
import 'package:navigation/pages/counter_page.dart';
import 'package:navigation/pages/dialogs_page.dart';
import 'package:navigation/pages/login_page.dart';
import 'package:navigation/pages/menu_page.dart';
import 'package:navigation/pages/splash_page.dart';
import 'routes.dart';

T getArguments<T>(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as T;
}

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.home: (context) => const MenuPage(),
    Routes.splash: (context) => const SplashPage(),
    Routes.counter: (context) => const CounterPage(),
    Routes.colorPicker: (context) => const ColorPicker(),
    Routes.dialogs: (context) => const DialogsPage(),
    Routes.login: (context) {
      final email = getArguments<String>(context);
      return LoginPage(email: email);
    },
  };
}
