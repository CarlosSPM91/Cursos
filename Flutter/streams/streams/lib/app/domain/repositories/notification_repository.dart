import 'package:strams/app/domain/models/app_notification.dart';

abstract class NotificationRepository {
  Stream<AppNotification> get onNotification;
  Future<void> dispose();
}