import 'package:vendor/core/view/notification_view.dart';
import 'package:vendor/ui/main/notification_screen/components/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotificationView notificationView = Provider.of<NotificationView>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
      ),
      body: notificationView.notificationProcess == NotificationProcess.idle
          ? (notificationView.notificationList!.isNotEmpty
              ? ListView.builder(
                  itemCount: notificationView.notificationList!.length,
                  itemBuilder: (BuildContext context, int i) {
                    return NotificationWidget(
                      notificationView: notificationView,
                        notificationModel:
                            notificationView.notificationList![i],);
                  })
              : const Center(
                  child: Text("You dont have notifications"),
                ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
