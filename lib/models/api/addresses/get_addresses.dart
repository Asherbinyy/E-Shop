class GetAddressModel {
  bool? status;
  AddressesDataInfo? data;

  GetAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data =
        json['data'] != null ? AddressesDataInfo.fromJson(json['data']) : null;
  }
}

class AddressesDataInfo {
  List<AddressData>? data = [];
  int? total;

  AddressesDataInfo.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data?.add(AddressData.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class AddressData {
  int? id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  double? latitude;
  double? longitude;

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }
}
