import 'package:vendor/core/model/notification_model.dart';

abstract class NotificationBase {
  Future<List<NotificationModel>?> getNotifications();
  Future deleteNotification(String id);
}
