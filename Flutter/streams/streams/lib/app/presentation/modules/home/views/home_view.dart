import 'dart:async';

import 'package:flutter/material.dart';
import 'package:strams/app/domain/models/app_notification.dart';
import 'package:strams/app/domain/repositories/notification_repository.dart';
import 'package:strams/main.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  AppNotification? _appNotification;
  StreamSubscription? _subscription;
  NotificationRepository? _notificationRepository;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _init();
      },
    );
  }

  void _init() {
    _notificationRepository = Provider.of(context).notificationRepository;
    _subscription = _notificationRepository?.onNotification.listen(
      (event) {
        setState(
          () {
            _appNotification = event;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _notificationRepository?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          actions: [
            IconButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(),
                ),
              ),
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_appNotification != null)
                StreamBuilder<AppNotification>(
                  stream: Provider.of(context).notificationRepository.onNotification,
                  builder: (_, snapshot) {
                    if (snapshot.data != null) {
                      return ListTile(
                        title: Text(snapshot.data!.title),
                        subtitle: Text(snapshot.data!.body),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
            ],
          ),
        ));
  }
}
