import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: TextButton(
            onPressed: () {
              Provider.of<AuthenticationRepository>(context, listen: false).signOut();
              Navigator.of(context).pushReplacementNamed(Routes.signIn);
            },
            child: const Text("SignOut"),
          ),
        ),
      ),
    );
  }
}
