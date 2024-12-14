import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/authentication_repository_implementation.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'package:tv_ratting_app/app/data/services/remote/internet_checker.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/connectivity_repository.dart';
import 'package:tv_ratting_app/app/my_app.dart';

void main() {
  runApp(Injector(
    connectivityRepository: ConnectivityRepositoryImpl(
      Connectivity(),
      InternetChecker(),
    ),
    authenticationRepository: AuthenticationRepositoryImpl(const FlutterSecureStorage()),
    child: const MyApp(),
  ));
}

class Injector extends InheritedWidget {
  const Injector({
    super.key,
    required super.child,
    required this.connectivityRepository,
    required this.authenticationRepository,
  });

  final ConnectivityRepository connectivityRepository;
  final AuthenticationRepository authenticationRepository;

  @override
  // ignore: avoid_renaming_method_parameters
  bool updateShouldNotify(_) => false;

  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, "Injector could not be found");
    return injector!;
  }
}
