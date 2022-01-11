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
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);
//
// import 'dart:convert';
//
// Address addressFromJson(String str) => Address.fromJson(json.decode(str));
//
// String addressToJson(Address data) => json.encode(data.toJson());
//
// class Address {
//   Address({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   bool status;
//   dynamic message;
//   Data data;
//
//   factory Address.fromJson(Map<String, dynamic> json) => Address(
//     status: json["status"],
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": data.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     this.currentPage,
//     this.data,
//     this.firstPageUrl,
//     this.from,
//     this.lastPage,
//     this.lastPageUrl,
//     this.nextPageUrl,
//     this.path,
//     this.perPage,
//     this.prevPageUrl,
//     this.to,
//     this.total,
//   });
//
//   int currentPage;
//   List<Datum> data;
//   String firstPageUrl;
//   int from;
//   int lastPage;
//   String lastPageUrl;
//   dynamic nextPageUrl;
//   String path;
//   int perPage;
//   dynamic prevPageUrl;
//   int to;
//   int total;
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     currentPage: json["current_page"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     firstPageUrl: json["first_page_url"],
//     from: json["from"],
//     lastPage: json["last_page"],
//     lastPageUrl: json["last_page_url"],
//     nextPageUrl: json["next_page_url"],
//     path: json["path"],
//     perPage: json["per_page"],
//     prevPageUrl: json["prev_page_url"],
//     to: json["to"],
//     total: json["total"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "current_page": currentPage,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "first_page_url": firstPageUrl,
//     "from": from,
//     "last_page": lastPage,
//     "last_page_url": lastPageUrl,
//     "next_page_url": nextPageUrl,
//     "path": path,
//     "per_page": perPage,
//     "prev_page_url": prevPageUrl,
//     "to": to,
//     "total": total,
//   };
// }
//
// class Datum {
//   Datum({
//     this.id,
//     this.name,
//     this.city,
//     this.region,
//     this.details,
//     this.notes,
//     this.latitude,
//     this.longitude,
//   });
//
//   int id;
//   String name;
//   String city;
//   String region;
//   String details;
//   dynamic notes;
//   double latitude;
//   double longitude;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     name: json["name"],
//     city: json["city"],
//     region: json["region"],
//     details: json["details"],
//     notes: json["notes"],
//     latitude: json["latitude"].toDouble(),
//     longitude: json["longitude"].toDouble(),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "city": city,
//     "region": region,
//     "details": details,
//     "notes": notes,
//     "latitude": latitude,
//     "longitude": longitude,
//   };
// }
