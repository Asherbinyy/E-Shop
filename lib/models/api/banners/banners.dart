class BannerModel {
  bool? status;

  List<BannerData>? data = [];

  BannerModel({this.status, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      (json['data']).forEach((element) {
        data?.add(BannerData.fromJson(element));
      });
    }
  }
}

class BannerData {
  int? id;
  String? image;

  BannerData({this.id, this.image});

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}
