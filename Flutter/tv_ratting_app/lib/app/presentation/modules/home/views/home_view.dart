import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';
import 'package:tv_ratting_app/main.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: TextButton(
            onPressed: () {
              Injector.of(context).authenticationRepository.signOut();
              Navigator.of(context).pushReplacementNamed(Routes.signIn);
            },
            child: const Text("SignOut"),
          ),
        ),
      ),
    );
  }
}
