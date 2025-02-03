import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/session_controller.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/theme_controller.dart';
import 'package:tv_ratting_app/app/presentation/global/extensions/build_context_extension.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SwitchListTile(
                value: context.darkMode,
                title: const Text("Dark Mode"),
                onChanged: (value) {
                  context.read<ThemeController>().onChanged(value);
                },
              ),
              ListTile(
                onTap: () {
                  context.read<SessionController>().signOut();
                  context.goNamed(
                    Routes.signIn,
                  );
                },
                title: const Text("Sign out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
