

import 'package:vendor/core/model/vendor_model.dart';

abstract class AuthBase {
  Future<VendorModel?> getCurrentVendor();
  Future<Object?> signInWithEmailAndPassword(String email,String password);
  Future<Object?> sendPasswordResetEmail(String email);
  Future signOut();
}
