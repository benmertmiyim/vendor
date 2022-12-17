import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/core/model/enums.dart';

class RequestModel {
  final String vendorId;
  String? requestId;
  final String uid;
  final String customerName;
  final String customerImage;
  final String parkName;
  final double hourlyPrice;
  final double startPrice;
  final Timestamp requestTime;
  Timestamp? responseTime;
  Timestamp? closedTime;
  Status status;
  int? totalTime;
  double? totalPrice;

  RequestModel({
    required this.vendorId,
    required this.uid,
    required this.customerName,
    required this.customerImage,
    required this.parkName,
    required this.hourlyPrice,
    required this.startPrice,
    required this.requestTime,
     this.responseTime,
     this.closedTime,
     this.requestId,
     required this.status,
     this.totalTime,
     this.totalPrice,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      vendorId: json["vendorId"],
      requestId: json["requestId"],
      uid: json["uid"],
      customerName: json["customerName"],
      customerImage: json["customerImage"],
      parkName: json["parkName"],
      hourlyPrice: json["hourlyPrice"].toDouble(),
      startPrice: json["startPrice"].toDouble(),
      requestTime: json["requestTime"] as Timestamp,
      responseTime: json["responseTime"] as Timestamp,
      status: statusConvert(json["status"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "vendorId": this.vendorId,
      "requestId": this.requestId,
      "uid": this.uid,
      "customerName": this.customerName,
      "customerImage": this.customerImage,
      "parkName": this.parkName,
      "hourlyPrice": this.hourlyPrice,
      "startPrice": this.startPrice,
      "requestTime": this.requestTime,
      "responseTime": responseTime,
      "status": statusConvert2(status),
    };
  }
  Map<String, dynamic> toJsonForClose() {
    return {
      "vendorId": this.vendorId,
      "requestId": this.requestId,
      "uid": this.uid,
      "customerName": this.customerName,
      "customerImage": this.customerImage,
      "parkName": this.parkName,
      "hourlyPrice": this.hourlyPrice,
      "startPrice": this.startPrice,
      "requestTime": this.requestTime,
      "responseTime": this.responseTime,
      "closedTime": this.closedTime,
      "status": statusConvert2(this.status),
      "totalTime": this.totalTime,
      "totalPrice": this.totalPrice,
    };
  }
}
