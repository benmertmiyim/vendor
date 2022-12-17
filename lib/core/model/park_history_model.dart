import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/core/model/enums.dart';

class ParkHistory {
  Timestamp? closedTime;
  final Timestamp requestTime;
  Timestamp? responseTime;
  final String vendorId;
  final String requestId;
  final String uid;
  final String customerName;
  final String customerImage;
  final String parkName;
  String? paymentId;
  final double hourlyPrice;
  final double startPrice;
  double? totalPrice;
  double? totalTime;
  Status status;

  ParkHistory(
      {this.closedTime,
      required this.requestTime,
      this.responseTime,
      required this.vendorId,
      required this.requestId,
      required this.uid,
      required this.customerName,
      required this.customerImage,
      required this.parkName,
      required this.hourlyPrice,
      required this.startPrice,
      this.totalPrice,
      this.totalTime,
      this.paymentId,
      required this.status});

  factory ParkHistory.fromJsonForRequest(Map<String, dynamic> json) {
    return ParkHistory(
      requestTime: json["requestTime"] as Timestamp,
      vendorId: json["vendorId"],
      requestId: json["requestId"],
      uid: json["uid"],
      customerName: json["customerName"],
      customerImage: json["customerImage"],
      parkName: json["parkName"],
      hourlyPrice: json["hourlyPrice"].toDouble(),
      startPrice: json["startPrice"].toDouble(),
      status: statusConvert(json["status"]),
    );
  }

  factory ParkHistory.fromJsonForProcessing(Map<String, dynamic> json) {
    return ParkHistory(
      requestTime: json["requestTime"] as Timestamp,
      responseTime: json["responseTime"] as Timestamp,
      vendorId: json["vendorId"],
      requestId: json["requestId"],
      uid: json["uid"],
      customerName: json["customerName"],
      customerImage: json["customerImage"],
      parkName: json["parkName"],
      hourlyPrice: json["hourlyPrice"].toDouble(),
      startPrice: json["startPrice"].toDouble(),
      status: statusConvert(json["status"]),
    );
  }

  factory ParkHistory.fromJsonForHistory(Map<String, dynamic> json) {
    return ParkHistory(
      requestTime: json["requestTime"] as Timestamp,
      closedTime: json["closedTime"] as Timestamp,
      responseTime: json["responseTime"] as Timestamp,
      vendorId: json["vendorId"],
      requestId: json["requestId"],
      uid: json["uid"],
      paymentId: json["paymentId"],
      customerName: json["customerName"],
      customerImage: json["customerImage"],
      parkName: json["parkName"],
      hourlyPrice: json["hourlyPrice"].toDouble(),
      startPrice: json["startPrice"].toDouble(),
      totalTime: json["totalTime"].toDouble(),
      totalPrice: json["totalPrice"].toDouble(),
      status: statusConvert(json["status"]),
    );
  }

  factory ParkHistory.fromJsonForCanceled(Map<String, dynamic> json) {
    return ParkHistory(
      requestTime: json["requestTime"] as Timestamp,
      closedTime: json["closedTime"] as Timestamp,
      responseTime: json["responseTime"] as Timestamp,
      vendorId: json["vendorId"],
      requestId: json["requestId"],
      uid: json["uid"],
      customerName: json["customerName"],
      customerImage: json["customerImage"],
      parkName: json["parkName"],
      hourlyPrice: json["hourlyPrice"].toDouble(),
      startPrice: json["startPrice"].toDouble(),
      status: statusConvert(json["status"]),
    );
  }

  factory ParkHistory.fromJsonForPay(Map<String, dynamic> json) {
    return ParkHistory(
      requestTime: json["requestTime"] as Timestamp,
      closedTime: json["closedTime"] as Timestamp,
      responseTime: json["responseTime"] as Timestamp,
      vendorId: json["vendorId"],
      requestId: json["requestId"],
      uid: json["uid"],
      customerName: json["customerName"],
      customerImage: json["customerImage"],
      parkName: json["parkName"],
      hourlyPrice: json["hourlyPrice"].toDouble(),
      startPrice: json["startPrice"].toDouble(),
      totalTime: json["totalTime"].toDouble(),
      totalPrice: json["totalPrice"].toDouble(),
      status: statusConvert(json["status"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "closedTime": this.closedTime,
      "requestTime": this.requestTime,
      "responseTime": this.responseTime,
      "vendorId": this.vendorId,
      "requestId": this.requestId,
      "uid": this.uid,
      "customerName": this.customerName,
      "customerImage": this.customerImage,
      "parkName": this.parkName,
      "paymentId": this.paymentId,
      "hourlyPrice": this.hourlyPrice,
      "startPrice": this.startPrice,
      "totalPrice": this.totalPrice,
      "totalTime": this.totalTime,
      "status": statusConvert2(this.status),
    };
  }
}
