import 'package:vendor/core/base/notification_base.dart';
import 'package:vendor/core/model/notification_model.dart';
import 'package:vendor/core/service/notification_service.dart';
import 'package:vendor/locator.dart';
import 'package:flutter/material.dart';

enum NotificationProcess {
  idle,
  busy,
}

class NotificationView with ChangeNotifier implements NotificationBase {
  NotificationProcess _notificationProcess = NotificationProcess.idle;
  NotificationService notificationService = locator<NotificationService>();
  List<NotificationModel>? notificationList;


  NotificationProcess get notificationProcess => _notificationProcess;

  set notificationProcess(NotificationProcess value) {
    _notificationProcess = value;
    notifyListeners();
  }


  NotificationView(){
    getNotifications();
  }

  void logout(){
    notificationList = null;
  }


  @override
  Future<List<NotificationModel>?> getNotifications() async {
    try {
      notificationProcess = NotificationProcess.busy;
      notificationList = await notificationService.getNotifications();
    } catch (e) {
      debugPrint(
        "NotificationView - Exception - Get Notifications : ${e.toString()}",
      );
    } finally {
      notificationProcess = NotificationProcess.idle;
    }
    return notificationList;
  }

  @override
  Future deleteNotification(String id) async {
    try {
      await notificationService.deleteNotification(id);
      notificationList?.removeWhere((model) => model.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint(
        "NotificationView - Exception - Delete Notifications : ${e.toString()}",
      );
    }
  }
}
