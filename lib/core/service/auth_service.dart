import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendor/core/base/auth_base.dart';
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
            managerName: map["manager_name"],
            imgList: List.from(map['img_list']),
            description: map["park_description"],
            rating: map['rating'].toDouble(),
            latitude: map['latitude'].toDouble(),
            longitude: map['longitude'].toDouble(),
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
  Future<Object?> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
