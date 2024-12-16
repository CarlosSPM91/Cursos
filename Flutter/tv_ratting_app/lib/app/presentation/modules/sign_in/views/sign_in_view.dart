import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/domain/enums.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';
import 'package:tv_ratting_app/main.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _username = "", _password = "";
  bool _fetching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            child: AbsorbPointer(
              absorbing: _fetching,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(hintText: "Username"),
                    onChanged: (text) {
                      setState(() {
                        _username = text.trim();
                      });
                    },
                    validator: (text) {
                      text = text?.trim().toLowerCase() ?? "";
                      if (text.isEmpty) {
                        return "invalid Username";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(hintText: "Password"),
                    onChanged: (text) {
                      setState(() {
                        _password = text.replaceAll(" ", "");
                      });
                    },
                    validator: (text) {
                      text = text?.replaceAll(" ", "") ?? "";
                      if (text.length < 4) {
                        return "invalid Password";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Builder(
                          builder: (context) {
                            if(_fetching){
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
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    setState(() {
      _fetching = true;
    });
    final result = await Injector.of(context)
        .authenticationRepository
        .signIn(_username, _password);

    if (!mounted) {
      return;
    }
    result.when(
      (failure) {
        setState(() {
          _fetching = false;
        });
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
