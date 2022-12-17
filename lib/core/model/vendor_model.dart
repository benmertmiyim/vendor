class VendorModel {
  final String vendorID;
  final String email;
  final String parkName;
  final String managerName;
  final String iban;
  final String vkn;
  final String phone;
  bool active;
  List<String>? imgList;
  double? longitude;
  double? latitude;
  double rating;
  double startPrice;
  double hourlyPrice;
  double accessibility;
  double security;
  double serviceQuality;

  VendorModel({
    required this.vendorID,
    required this.email,
    required this.parkName,
    required this.managerName,
    required this.active,
    required this.iban,
    required this.vkn,
    required this.phone,
    required this.rating,
    required this.accessibility,
    required this.security,
    required this.serviceQuality,
    this.imgList,
    this.latitude,
    this.longitude,
    required this.hourlyPrice,
    required this.startPrice,
  });

  @override
  String toString() {
    return 'VendorModel{vendorID: $vendorID, email: $email, parkName: $parkName, managerName: $managerName, iban: $iban, vkn: $vkn, phone: $phone, active: $active, imgList: $imgList, longitude: $longitude, latitude: $latitude, rating: $rating, startPrice: $startPrice, hourlyPrice: $hourlyPrice}';
  }
}
