import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      left: (failure) {
        final message = failure.when(
          notFound: () => "Not Found",
          network: () => "Network Error",
          unkown: () => "Error",
          unauthorized: () => "Invalid Password",
          notVerified: () => "Not Verified",
        );
        // final message = (){
        // if(failure is NotFound){
        //   return "Not Found";
        // }
        // if(failure is Unauthorized){
        //   return "Invalid Password";
        // }
        // if(failure is Network){
        //   return "Network Error";
        // }
        // return "Error";
        // }();
        // controller.submit();
        // final message = {
        //   SignInFailure.notFound: ,
        //   SignInFailure.unAuthorized: ,
        //   SignInFailure.unknown: "Error",
        //   SignInFailure.network: "Network Error",
        // }[failure];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      },
      right: (user) {
        final SessionController sessionController = context.read();
        sessionController.setUser(user);
        Navigator.of(context).pushReplacementNamed(Routes.home);
      },
    );
  }
}
