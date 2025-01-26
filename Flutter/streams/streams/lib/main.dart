import 'package:flutter/material.dart';
import 'package:strams/app/data/repositories_impl/notification_repository_impl.dart';
import 'package:strams/app/domain/repositories/notification_repository.dart';
import 'package:strams/app/presentation/modules/home/views/home_view.dart';

void main() {
  runApp(Provider(
    notificationRepository: NotificationRepositoryImpl(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}

class Provider extends InheritedWidget {
  final NotificationRepository notificationRepository;

  Provider({
    super.key,
    required super.child,
    required this.notificationRepository,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static Provider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!;
  }
}
