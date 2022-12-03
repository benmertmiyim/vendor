import 'package:flutter/material.dart';
import 'package:vendor/core/base/auth_base.dart';
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
      if(vendorModel != null){
        authState = AuthState.authorized;
      }else{

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
      if(res is VendorModel){
        vendorModel = res;
        if(vendorModel != null){
          authState = AuthState.authorized;
        }else{
          signOut();
        }
        debugPrint(
          "AuthView - signInWithEmailAndPassword : $vendorModel",
        );
      }else{
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
      authProcess = AuthProcess.busy;
      await authService.signOut();
      vendorModel = null;
      authState = AuthState.signIn;
      debugPrint(
        "AuthView - signOut : $vendorModel",
      );
    } catch (e) {
      debugPrint(
        "AuthView - Exception - signOut : ${e.toString()}",
      );
    } finally {
      authProcess = AuthProcess.idle;
    }
    return vendorModel;
  }

  @override
  Future<Object?> sendPasswordResetEmail(String email) async {
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.sendPasswordResetEmail( email);
      if(result is bool){
        return true;
      }else{
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
}
