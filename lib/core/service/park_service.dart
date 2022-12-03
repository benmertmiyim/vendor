
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor/core/base/park_base.dart';
import 'package:vendor/core/model/request_model.dart';

class ParkService implements ParkBase {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<Object> sendRequest(String uid) async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        CollectionReference customer =
        firebaseFirestore.collection("customers");
        DocumentSnapshot documentSnapshotCustomer = await customer.doc(uid).get();

        CollectionReference vendor = firebaseFirestore.collection("vendors");
        DocumentSnapshot documentSnapshotVendor = await vendor.doc(user.uid).get();

        if (documentSnapshotCustomer.exists && documentSnapshotVendor.exists) {
          Map mapCustomer = documentSnapshotCustomer.data() as Map;
          Map mapVendor = documentSnapshotVendor.data() as Map;

          CollectionReference customerActive = firebaseFirestore.collection("customers/$uid/active_park");
          QuerySnapshot customerActiveQuery = await customerActive.get();

          if(customerActiveQuery.size == 0){
            CollectionReference vendor = firebaseFirestore.collection("vendors/${user.uid}/awaiting_approval");
            CollectionReference customer = firebaseFirestore.collection("customers/$uid/awaiting_approval");
            QuerySnapshot customerQuery = await customer.get();

            if (customerQuery.size == 0){
              var res =await vendor.add({
                "request_time": Timestamp.now(),
                "uid": uid,
                "customer_image": mapCustomer["image_url"],
                "customer_name": mapCustomer["name_surname"],
                "hourly_price": mapVendor["hourly_price"],
                "start_price": mapVendor["start_price"],
                "vendor_id":user.uid,
                "park_name":mapVendor["park_name"],
                "status":"approval",
              });
              await customer.doc(res.id).set({
                "request_time": Timestamp.now(),
                "uid": uid,
                "customer_image": mapCustomer["image_url"],
                "customer_name": mapCustomer["name_surname"],
                "hourly_price": mapVendor["hourly_price"],
                "start_price": mapVendor["start_price"],
                "vendor_id":user.uid,
                "park_name":mapVendor["park_name"],
                "status":"approval",
              });
            }else{
              return "This user already has a pending request";
            }
          }
          else{
            Map<String, dynamic> map = customerActiveQuery.docs[0].data() as Map<String, dynamic>;
            RequestModel requestModel = RequestModel.fromJson(map);
            if(requestModel.vendorId == user.uid){
              DocumentReference customerApproval = firebaseFirestore.collection("customers/${requestModel.uid}/active_park").doc(requestModel.requestId);
              DocumentReference vendorApproval = firebaseFirestore.collection("vendors/${user.uid}/active_park").doc(requestModel.requestId);
              await customerApproval.delete();
              await vendorApproval.delete();
              requestModel.status = Status.completed;
              requestModel.closedTime = Timestamp.now();
              DateTime dateTime1 = (requestModel.requestTime).toDate();
              DateTime dateTime2 = (requestModel.closedTime!).toDate();
              requestModel.totalTime = dateTime1.difference(dateTime2).inMinutes * -1;
              requestModel.totalPrice = requestModel.startPrice + ((requestModel.hourlyPrice/60) * requestModel.totalTime!);
              CollectionReference customerCollectionReference = firebaseFirestore.collection("customers/${requestModel.uid}/history");
              await customerCollectionReference.doc(requestModel.requestId).set(requestModel.toJsonForClose());
              CollectionReference vendorCollectionReference = firebaseFirestore.collection("vendors/${user.uid}/history");
              await vendorCollectionReference.doc(requestModel.requestId).set(requestModel.toJsonForClose());
            }else{
              return "This user is in another parking lot.";
            }
          }
          return true;
        }
      }
      return false;
    } catch (e) {
      debugPrint(
        "sendRequest - Exception - sendRequest : ${e.toString()}",
      );
      return false;
    }

  }
}