import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/generated/translations.g.dart';
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
      child: Text(texts.signIn.signIn),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final SignInCotroller controller = context.read();

    final result = await controller.submit();

    if (!controller.mounted) {
      return;
    }
    result.when(
      left: (failure) {
        final message = failure.when(
          notFound: () => texts.signIn.errors.submit.notFound,
          network: () => texts.signIn.errors.submit.network,
          unkown: () => texts.signIn.errors.submit.unkown,
          unauthorized: () => texts.signIn.errors.submit.unauthorized,
          notVerified: () => texts.signIn.errors.submit.notVerified,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
      right: (user) => context.goNamed(
        Routes.home,
      ),
    );
  }
}
