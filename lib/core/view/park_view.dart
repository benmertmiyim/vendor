import 'package:flutter/material.dart';
import 'package:vendor/core/base/park_base.dart';
import 'package:vendor/core/service/park_service.dart';
import 'package:vendor/locator.dart';

enum ParkProcess {
  idle,
  busy,
}

class ParkView with ChangeNotifier implements ParkBase {
  ParkProcess _parkProcess = ParkProcess.idle;
  ParkService parkService = locator<ParkService>();

  ParkProcess get parkProcess => _parkProcess;

  set parkProcess(ParkProcess value) {
    _parkProcess = value;
    notifyListeners();
  }

  @override
  Future<Object> sendRequest(String uid) async {
    try {
      parkProcess = ParkProcess.busy;
      return await parkService.sendRequest(uid);
    } catch (e) {
      debugPrint(
        "ParkView - Exception - sendRequest : ${e.toString()}",
      );
      return false;
    }finally{
      parkProcess = ParkProcess.idle;
    }
  }

}