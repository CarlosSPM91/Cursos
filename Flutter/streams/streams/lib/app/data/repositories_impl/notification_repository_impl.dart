import 'dart:async';

import 'package:faker/faker.dart';
import 'package:strams/app/domain/models/app_notification.dart';
import 'package:strams/app/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final _controller = StreamController<AppNotification>.broadcast();
  Timer? _timer;

  NotificationRepositoryImpl() {
    _init();
  }

  void _init() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (_) {
        final faker = Faker();
        if (_controller.hasListener && !_controller.isClosed) {
          _controller.add(
            AppNotification(
              title: faker.food.dish(),
              body: faker.lorem.sentence(),
              createdAt: DateTime.now(),
            ),
          );
        }
      },
    );
  }

  @override
  Stream<AppNotification> get onNotification => _controller.stream;

  @override
  Future<void> dispose() {
    _timer?.cancel();
    return _controller.close();
  }
}
