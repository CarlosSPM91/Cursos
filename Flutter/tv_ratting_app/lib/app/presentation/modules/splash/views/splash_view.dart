import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_ratting_app/app/domain/repositories/authentication_repository.dart';
import 'package:tv_ratting_app/app/domain/repositories/connectivity_repository.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    final connectivityRepository = Provider.of<ConnectivityRepository>(
      context,
      listen: false,
    );

    final hasInternet = await connectivityRepository.hasInternet;

    if (hasInternet) {
      if (mounted) {
        final AuthenticationRepository authenticationRepository =
            context.read();

        if (await authenticationRepository.isSignedIn) {
          final user = await authenticationRepository.getUserData();
          if (user != null) {
            //All ok
            _goTo(Routes.home);
          } else {
            //no User
            if (mounted) {
              _goTo(Routes.signIn);
            }
          }
        } else if (mounted) {
          //not signed, with connection an rendered view
          _goTo(Routes.signIn);
        }
      } else {
        //no connection
        _goTo(Routes.offline);
      }
    }
  }

  void _goTo(String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
