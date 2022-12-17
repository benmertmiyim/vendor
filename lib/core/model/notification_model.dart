import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String title;
  final String id;
  final String message;
  final DateTime dateTime;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.dateTime,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      title: map['title'] as String,
      id: map['id'] as String,
      message: map['message'] as String,
      dateTime: (map['date'] as Timestamp).toDate(),
    );
  }
}
