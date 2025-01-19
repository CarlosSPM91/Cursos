import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/presentation/modules/favorites/views/favorites_view.dart';
import 'package:tv_ratting_app/app/presentation/modules/home/views/home_view.dart';
import 'package:tv_ratting_app/app/presentation/modules/offline/views/ofline_view.dart';
import 'package:tv_ratting_app/app/presentation/modules/sign_in/views/sign_in_view.dart';
import 'package:tv_ratting_app/app/presentation/modules/splash/views/splash_view.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.signIn: (context) => const SignInView(),
    Routes.home: (context) => const HomeView(),
    Routes.offline: (context) => const OfflineView(),
    Routes.favorites: (context) => const FavoritesView(),
  };
}
