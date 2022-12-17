import 'package:vendor/core/model/notification_model.dart';
import 'package:vendor/core/view/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel notificationModel;
  final NotificationView notificationView;

  const NotificationWidget(
      {Key? key,
      required this.notificationModel,
      required this.notificationView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      margin: EdgeInsets.zero,
      elevation: 2,
      child: ListTile(
        isThreeLine: true,
        title: Text(notificationModel.title),
        subtitle: Text(
            "${notificationModel.message}\n${DateFormat('dd-MM-yyyy – kk:mm').format(notificationModel.dateTime)}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            notificationView.deleteNotification(notificationModel.id);
          },
        ),
      ),
    );
  }
}
