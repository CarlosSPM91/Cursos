import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tv_ratting_app/app/inject_repositories.dart';
import 'package:tv_ratting_app/app/presentation/routes/routes.dart';

class OfflineView extends StatefulWidget {
  const OfflineView({super.key});

  @override
  State<OfflineView> createState() => _OfflineViewState();
}

class _OfflineViewState extends State<OfflineView> {
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Repositories.connectivity.onInternetChanged.listen(
      (connected) {
        if (connected) {
          Navigator.of(context).pushReplacementNamed(Routes.splash);
        }
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Center(
          child: Text("Offline"),
        ),
      ),
    );
  }
}
