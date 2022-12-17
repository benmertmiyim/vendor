import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor/core/base/park_base.dart';
import 'package:vendor/core/model/enums.dart';
import 'package:vendor/core/model/request_model.dart';

class ParkService implements ParkBase {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<Object> sendRequest(String uid) async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        DocumentSnapshot documentSnapshotCustomer = await firebaseFirestore.collection("customers").doc(uid).get();
        DocumentSnapshot documentSnapshotVendor = await firebaseFirestore.collection("vendors").doc(user.uid).get();

        if (documentSnapshotCustomer.exists && documentSnapshotVendor.exists) {
          Map mapCustomer = documentSnapshotCustomer.data() as Map;
          Map mapVendor = documentSnapshotVendor.data() as Map;

          CollectionReference customerHistoryCollection = firebaseFirestore.collection("customers/$uid/history");
          CollectionReference vendorHistoryCollection = firebaseFirestore.collection("vendors/${user.uid}/history");
          QuerySnapshot customerApprovalQuery = await customerHistoryCollection.where("status",isEqualTo: "approval").get();
          QuerySnapshot customerProcessingQuery = await customerHistoryCollection.where("status",isEqualTo: "processing").get();

          if(customerProcessingQuery.size == 0){
            if(customerApprovalQuery.size == 0){
              var res = await vendorHistoryCollection.add({
                "requestTime": Timestamp.now(),
                "uid": uid,
                "customerImage": mapCustomer["image_url"],
                "customerName": mapCustomer["name_surname"],
                "hourlyPrice": mapVendor["hourly_price"],
                "startPrice": mapVendor["start_price"],
                "vendorId":user.uid,
                "requestId":"000000",
                "parkName":mapVendor["park_name"],
                "status":"approval",
              });
              await vendorHistoryCollection.doc(res.id).update({"requestId":res.id});
              await customerHistoryCollection.doc(res.id).set({
                "requestTime": Timestamp.now(),
                "uid": uid,
                "requestId":res.id,
                "customerImage": mapCustomer["image_url"],
                "customerName": mapCustomer["name_surname"],
                "hourlyPrice": mapVendor["hourly_price"],
                "startPrice": mapVendor["start_price"],
                "vendorId":user.uid,
                "parkName":mapVendor["park_name"],
                "status":"approval",
              });
              return "Request sent.";
            }else{
              return "Bekleyen talep mevcut";
            }
          }
          else{
            Map<String, dynamic> map = customerProcessingQuery.docs[0].data() as Map<String, dynamic>;
            RequestModel requestModel = RequestModel.fromJson(map);
            if(requestModel.vendorId == user.uid){
              requestModel.closedTime = Timestamp.now();
              DateTime dateTime1 = (requestModel.requestTime).toDate();
              DateTime dateTime2 = (requestModel.closedTime!).toDate();
              requestModel.totalTime = dateTime1.difference(dateTime2).inMinutes * -1;
              requestModel.totalPrice = requestModel.startPrice + ((requestModel.hourlyPrice/60) * requestModel.totalTime!);
              requestModel.status = Status.payment;
              await customerHistoryCollection.doc(requestModel.requestId).update(requestModel.toJsonForClose());
              requestModel.status = Status.completed;
              await vendorHistoryCollection.doc(requestModel.requestId).update(requestModel.toJsonForClose());
              return "Process closed...";
            }else{
              return "This user is in another parking lot.";
            }
          }
        }else{
          return "Customer not found !";
        }
      }else{
        return "Vendor not found !";
      }
    } catch (e) {
      debugPrint(
        "sendRequest - Exception - sendRequest : ${e.toString()}",
      );
      return "Something went wrong";
    }

  }

  @override
  Stream<QuerySnapshot<Object?>> getParks() {
    return firebaseFirestore
        .collection(
        "vendors/${firebaseAuth.currentUser!.uid}/history").orderBy("requestTime", descending: true)
        .snapshots();
  }

}