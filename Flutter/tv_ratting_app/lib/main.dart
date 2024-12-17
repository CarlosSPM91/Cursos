import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/data/http/http.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/account_repository_impl.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/authentication_repository_implementation.dart';
import 'package:tv_ratting_app/app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'package:tv_ratting_app/app/data/services/remote/authentication_api.dart';
import 'package:tv_ratting_app/app/data/services/remote/internet_checker.dart';
import 'package:tv_ratting_app/app/domain/repositories/acount_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/connectivity_repository.dart';
import 'package:tv_ratting_app/app/my_app.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      Provider<AcountRepository>(
        create: (_) => AccountRepositoryImpl(),
      ),
      Provider<ConnectivityRepository>(
        create: (_) => ConnectivityRepositoryImpl(
          Connectivity(),
          InternetChecker(),
        ),
      ),
      Provider<AuthenticationRepository>(
        create: (_) => AuthenticationRepositoryImpl(
          const FlutterSecureStorage(),
          AutenthicationAPI(
            Http(
              baseURL: "https://api.themoviedb.org/3",
              apiKey: "fb9888dbd1f188ef5dcc0b4ead5bcfa8",
              client: http.Client(),
            ),
          ),
        ),
      ),
    ], child: const MyApp()),
  );
}

// class Injector extends InheritedWidget {
//   const Injector({
//     super.key,
//     required super.child,
//     required this.authenticationRepository,
//   });

//   final AuthenticationRepository authenticationRepository;

//   @override
//   // ignore: avoid_renaming_method_parameters
//   bool updateShouldNotify(_) => false;

//   static Injector of(BuildContext context) {
//     final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
//     assert(injector != null, "Injector could not be found");
//     return injector!;
//   }
// }
