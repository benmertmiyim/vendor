import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor/core/base/auth_base.dart';
import 'package:vendor/core/model/comment_model.dart';
import 'package:vendor/core/model/vendor_model.dart';

class AuthService implements AuthBase {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<VendorModel?> getCurrentVendor() async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null) {
        CollectionReference customer = firebaseFirestore.collection("vendors");
        DocumentSnapshot documentSnapshot = await customer.doc(user.uid).get();

        if (documentSnapshot.exists) {
          Map map = documentSnapshot.data() as Map;
          return VendorModel(
            vendorID: user.uid,
            email: user.email!,
            parkName: map["park_name"],
            iban: map["iban"],
            vkn: map["vkn"],
            phone: map["phone"],
            managerName: map["manager_name"],
            imgList: List.from(map['img_list']),
            rating: map['rating'].toDouble(),
            latitude: map['latitude'].toDouble(),
            longitude: map['longitude'].toDouble(),
            hourlyPrice: map['hourly_price'].toDouble(),
            startPrice: map['start_price'].toDouble(),
            security: map['security'].toDouble(),
            serviceQuality: map['serviceQuality'].toDouble(),
            accessibility: map['accessibility'].toDouble(),
            active: map["active"] as bool,
          );
        }
      }
      return null;
    } catch (e) {
      debugPrint(
        "AuthService - Exception - Get Current Vendor : ${e.toString()}",
      );
      return null;
    }
  }

  @override
  Future<Object?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return getCurrentVendor();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Future signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<bool> changeStatus(bool status) async {
    try{
      User? user = firebaseAuth.currentUser;
      CollectionReference vendorCollection = firebaseFirestore.collection("vendors");
      await vendorCollection.doc(user!.uid).update({"active": status});
      return true;
    }catch(e){
      debugPrint(e.toString(),);
      return false;
    }
  }
  @override
  Future<Object?> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  @override
  Future<bool> setHourlyPrice(double price) async {
    try{
      User? user = firebaseAuth.currentUser;
      CollectionReference vendorCollection = firebaseFirestore.collection("vendors");
      await vendorCollection.doc(user!.uid).update({"hourly_price": price});
      return true;
    }catch(e){
      debugPrint(e.toString(),);
      return false;
    }
  }

  @override
  Future<bool> setStartPrice(double price) async {
    try{
      User? user = firebaseAuth.currentUser;
      CollectionReference vendorCollection = firebaseFirestore.collection("vendors");
      await vendorCollection.doc(user!.uid).update({"start_price": price});
      return true;
    }catch(e){
      debugPrint(e.toString(),);
      return false;
    }
  }

  @override
  Future<List<RateModel>?> getComments() async {
    try {
      QuerySnapshot querySnapshot = await firebaseFirestore
          .collection(
          "vendors/${firebaseAuth.currentUser!.uid}/ratings")
          .orderBy("commentDate", descending: true)
          .get();
      List<RateModel> list = [];
      debugPrint(querySnapshot.docs[0].data().toString());
      for (int i = 0; i < querySnapshot.size; i++) {
        Map<String, dynamic> rating =
        querySnapshot.docs[i].data() as Map<String, dynamic>;
        list.add(RateModel.fromJson(rating));
      }
      return list;
    } catch (e) {
      debugPrint(
        "NotificationService - Exception - getComments : ${e.toString()}",
      );
      return null;
    }
  }


}
