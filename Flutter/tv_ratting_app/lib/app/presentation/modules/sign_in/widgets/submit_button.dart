import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/domain/enums.dart';
import 'package:tv_ratting_app/app/presentation/global/controller/session_controller.dart';
import 'package:tv_ratting_app/app/presentation/modules/sign_in/views/controller/sign_in_cotroller.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInCotroller controller = Provider.of(context);
    if (controller.state.fetching) {
      return const CircularProgressIndicator();
    }
    return MaterialButton(
      onPressed: () {
        final isValid = Form.of(context).validate();
        if (isValid) {
          _submit(context);
        }
      },
      color: Colors.blue,
      child: const Text("Sign In"),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final SignInCotroller controller = context.read();

    final result = await controller.submit();

    if (!controller.mounted) {
      return;
    }
    result.when(
      (failure) {
        controller.submit();
        final message = {
          SignInFailure.notFound: "Not Found",
          SignInFailure.unAuthorized: "Invalid Password",
          SignInFailure.unknown: "Error",
          SignInFailure.network: "Network Error",
        }[failure];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message!)),
        );
      },
      (user) {
        final SessionController sessionController = context.read();
        sessionController.setUser(user);
        Navigator.of(context).pushReplacementNamed(Routes.home);
      },
    );
  }
}
