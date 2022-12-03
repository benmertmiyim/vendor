import 'package:google_maps_flutter/google_maps_flutter.dart';

class VendorModel {
  final String vendorID;
  final String email;
  final String parkName;
  final String managerName;
  bool active;
  List<String>? imgList;
  double? longitude;
  double? latitude;
  String? description;
  double rating;

  VendorModel({
    required this.vendorID,
    required this.email,
    required this.parkName,
    required this.managerName,
    required this.active,
    this.rating = 5,
    this.imgList,
    this.latitude,
    this.longitude,
    this.description,
  });

  @override
  String toString() {
    return 'VendorModel{vendorID: $vendorID, email: $email, parkName: $parkName, managerName: $managerName, active: $active, imgList: $imgList, longitude: $longitude, latitude: $latitude, description: $description, rating: $rating}';
  }
}
