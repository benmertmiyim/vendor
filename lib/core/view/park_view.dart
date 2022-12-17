import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vendor/core/base/park_base.dart';
import 'package:vendor/core/model/park_history_model.dart';
import 'package:vendor/core/service/park_service.dart';
import 'package:vendor/locator.dart';

enum ParkProcess {
  idle,
  busy,
}

class ParkView with ChangeNotifier implements ParkBase {
  ParkProcess _parkProcess = ParkProcess.idle;
  ParkService parkService = locator<ParkService>();
  List<ParkHistory> parkHistory = [];
  List<ParkHistory> activePark = [];
  List<ParkHistory> approvalPark = [];
  List<ParkHistory> canceledPark = [];
  double totalEarnings = 0;

  ParkProcess get parkProcess => _parkProcess;

  set parkProcess(ParkProcess value) {
    _parkProcess = value;
    notifyListeners();
  }

  ParkView() {
    getParks();
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
    } finally {
      parkProcess = ParkProcess.idle;
    }
  }

  @override
  Stream<QuerySnapshot<Object?>> getParks() {
    var querySnapshot = parkService.getParks();
    querySnapshot.listen((event) {
      activePark = [];
      approvalPark = [];
      parkHistory = [];
      canceledPark = [];
      totalEarnings = 0;

      for (var doc in event.docs) {
        Map<String, dynamic> map = doc.data() as Map<String, dynamic>;
        ParkHistory park;
        if (map["status"] == "processing") {
          park = ParkHistory.fromJsonForProcessing(map);
          activePark.add(park);
        } else if (map["status"] == "approval") {
          park = ParkHistory.fromJsonForRequest(map);
          approvalPark.add(park);
        } else if (map["status"] == "canceled") {
          park = ParkHistory.fromJsonForCanceled(map);
          canceledPark.add(park);
        } else {
          park = ParkHistory.fromJsonForHistory(map);
          parkHistory.add(park);
          totalEarnings += park.totalPrice!;
        }
      }
      notifyListeners();
    });
    return querySnapshot;
  }
}
