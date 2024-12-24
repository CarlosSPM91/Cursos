import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/session_controller.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final SessionController sessionController = Provider.of(context);
    final user = sessionController.state!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.id.toString() ?? "",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              user.username ?? "",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            TextButton(
              onPressed: () async {
                await sessionController.signOut();
                if (mounted) Navigator.of(context).pushReplacementNamed(Routes.signIn);
              },
              child: const Text("SignOut"),
            ),
          ],
        ),
      ),
    );
  }
}
