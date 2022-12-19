import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendor/core/model/comment_model.dart';
import 'package:vendor/core/model/vendor_model.dart';

abstract class AuthBase {
  Future<VendorModel?> getCurrentVendor();
  Future<Object?> signInWithEmailAndPassword(String email,String password);
  Future<Object?> sendPasswordResetEmail(String email);
  Future signOut();
  Future<bool> changeStatus(bool status);
  Future<bool> setHourlyPrice(double price);
  Future<bool> setStartPrice(double price);
  Stream<QuerySnapshot> getComments();
}
