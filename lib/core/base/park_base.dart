
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ParkBase {
  Future<Object> sendRequest(String uid);
  Stream<QuerySnapshot> getParks();
}
