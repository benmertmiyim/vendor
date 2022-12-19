import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor/core/base/auth_base.dart';
import 'package:vendor/core/model/comment_model.dart';
import 'package:vendor/core/model/vendor_model.dart';
import 'package:vendor/core/service/auth_service.dart';
import 'package:vendor/locator.dart';

enum AuthProcess {
  idle,
  busy,
}

enum AuthState {
  authorized,
  signIn,
  landing,
  forgot,
}

class AuthView with ChangeNotifier implements AuthBase {
  AuthProcess _authProcess = AuthProcess.idle;
  AuthState _authState = AuthState.landing;
  AuthService authService = locator<AuthService>();
  VendorModel? vendorModel;
  bool status = false;
  List<RateModel> ratingList = [];
  StreamSubscription? rateListener;

  AuthProcess get authProcess => _authProcess;

  set authProcess(AuthProcess value) {
    _authProcess = value;
    notifyListeners();
  }

  AuthState get authState => _authState;

  set authState(AuthState value) {
    _authState = value;
    notifyListeners();
  }

  AuthView() {
    getCurrentVendor();
  }

  @override
  Future<VendorModel?> getCurrentVendor() async {
    try {
      authProcess = AuthProcess.busy;
      vendorModel = await authService.getCurrentVendor();
      await Future.delayed(const Duration(seconds: 2)); //TODO
      if (vendorModel != null) {
        authState = AuthState.authorized;
        status = vendorModel!.active;
        getComments();
      } else {
        authState = AuthState.signIn;
      }
      debugPrint(
        "AuthView - Current Vendor : $vendorModel",
      );
    } catch (e) {
      debugPrint(
        "AuthView - Exception - Get Current Vendor : ${e.toString()}",
      );
    } finally {
      authProcess = AuthProcess.idle;
    }
    return vendorModel;
  }

  @override
  Future<Object?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      authProcess = AuthProcess.busy;
      var res = await authService.signInWithEmailAndPassword(email, password);
      if (res is VendorModel) {
        vendorModel = res;
        if (vendorModel != null) {
          authState = AuthState.authorized;
        } else {
          signOut();
        }
        debugPrint(
          "AuthView - signInWithEmailAndPassword : $vendorModel",
        );
      } else {
        return res;
      }
    } catch (e) {
      debugPrint(
        "AuthView - Exception - signInWithEmailAndPassword : ${e.toString()}",
      );
    } finally {
      authProcess = AuthProcess.idle;
    }
    return vendorModel;
  }

  @override
  Future signOut() async {
    try {
      await authService.signOut();
      vendorModel = null;
      authState = AuthState.signIn;
      rateListener!.cancel();
      debugPrint(
        "AuthView - signOut : $vendorModel",
      );
    } catch (e) {
      debugPrint(
        "AuthView - Exception - signOut : ${e.toString()}",
      );
    }
    return vendorModel;
  }

  @override
  Future<Object?> sendPasswordResetEmail(String email) async {
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.sendPasswordResetEmail(email);
      if (result is bool) {
        return true;
      } else {
        return result;
      }
    } catch (e) {
      debugPrint(
        "AuthView - Exception - sendPasswordResetEmail : ${e.toString()}",
      );
      return null;
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<bool> changeStatus(bool statuss) async {
    try {
      authProcess = AuthProcess.busy;
      bool res = await authService.changeStatus(statuss);
      if(res){
        vendorModel!.active = statuss;
        status = statuss;
      }
      return res;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - changeStatus : ${e.toString()}",
      );
      return false;
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<bool> setHourlyPrice(double price) async {
    try {
      authProcess = AuthProcess.busy;
      bool res = await authService.setHourlyPrice(price);
      if(res){
        vendorModel!.hourlyPrice = price;
      }
      return res;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - setHourlyPrice : ${e.toString()}",
      );
      return false;
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Future<bool> setStartPrice(double price) async {
    try {
      authProcess = AuthProcess.busy;
      bool res = await authService.setStartPrice(price);
      if(res){
        vendorModel!.startPrice = price;
      }
      return res;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - setStartPrice : ${e.toString()}",
      );
      return false;
    } finally {
      authProcess = AuthProcess.idle;
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getComments()  {
    var querySnapshot = authService.getComments();
    rateListener = querySnapshot.listen((event) {
      ratingList = [];

      for (var doc in event.docs) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        ratingList.add(RateModel.fromJson(map));
      }
      notifyListeners();
    });
    return querySnapshot;
  }
}
