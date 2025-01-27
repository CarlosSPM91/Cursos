import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';
import 'package:tv_ratting_app/app/generated/translations.g.dart';
import 'package:tv_ratting_app/app/presentation/modules/sign_in/views/controller/sign_in_cotroller.dart';
import 'package:tv_ratting_app/app/presentation/modules/sign_in/views/controller/state/sign_in_state.dart';
import 'package:tv_ratting_app/app/presentation/modules/sign_in/widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInCotroller>(
      create: (_) => SignInCotroller(
        const SignInState(),
        authenticationRepository: context.read<AuthenticationRepository>(),
        sessionController: context.read(),
        favoritesController: context.read(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Builder(
                builder: (context) {
                  final SignInCotroller controller = Provider.of(context, listen: true);
                  return AbsorbPointer(
                    absorbing: controller.state.fetching,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(hintText: texts.signIn.username),
                          onChanged: (text) {
                            controller.onUsernameChanged(text);
                          },
                          validator: (text) {
                            text = text?.trim().toLowerCase() ?? "";
                            if (text.isEmpty) {
                              return texts.signIn.errors.username;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(hintText: texts.signIn.password),
                          onChanged: (text) {
                            controller.onPasswordChanged(text);
                          },
                          validator: (text) {
                            text = text?.replaceAll(" ", "") ?? "";
                            if (text.length < 4) {
                              return texts.signIn.errors.password;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        const SubmitButton(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
