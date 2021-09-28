class NewAddressModel {
  bool ? status;
  String ? message;

  NewAddressModel({this.status, this.message});

  NewAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }


}
