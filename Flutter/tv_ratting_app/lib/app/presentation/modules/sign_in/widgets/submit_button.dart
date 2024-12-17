import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/domain/enums.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';
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

    controller.onFetchingChanged(true);

    final result =
        await Provider.of<AuthenticationRepository>(context, listen: false)
            .signIn(controller.state.username, controller.state.password);

    if (!controller.mounted) {
      return;
    }
    result.when(
      (failure) {
        controller.onFetchingChanged(false);
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
        Navigator.of(context).pushReplacementNamed(Routes.home);
      },
    );
  }
}
