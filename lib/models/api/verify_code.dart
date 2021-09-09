class VerifyCodeModel {
  bool ? status;
  VerifyCodeData ? data;

  VerifyCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = json['data'] != null ? new VerifyCodeData.fromJson(json['data']) : null;
  }

}

class VerifyCodeData {
  int ?  id;
  String  ? name;
  String ? email;
  String ? phone;
  String ? image;
  int  ? points;


  VerifyCodeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
  }

}