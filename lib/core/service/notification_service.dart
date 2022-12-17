import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/core/base/notification_base.dart';
import 'package:vendor/core/model/notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class NotificationService implements NotificationBase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<List<NotificationModel>?> getNotifications() async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection(
              "vendors/${firebaseAuth.currentUser!.uid}/notifications")
          .orderBy("date", descending: true)
          .get();
      List<NotificationModel> list = [];
      for (int i = 0; i < querySnapshot.size; i++) {
        Map<String, dynamic> notification =
            querySnapshot.docs[i].data() as Map<String, dynamic>;
        list.add(NotificationModel.fromMap(notification));
      }
      return list;
    } catch (e) {
      debugPrint(
        "NotificationService - Exception - Get Notifications : ${e.toString()}",
      );
      return null;
    }
  }

  @override
  Future deleteNotification(String id) async {
    try {
      await firebaseFirestore
          .collection(
              "vendors/${firebaseAuth.currentUser!.uid}/notifications")
          .doc(id)
          .delete();
    } catch (e) {
      debugPrint(
        "NotificationService - Exception - Delete Notifications : ${e.toString()}",
      );
    }
  }
}
