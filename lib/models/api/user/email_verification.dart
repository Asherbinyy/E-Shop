class EmailVerificationModel {
  bool ? status;
  String ? message;
  Data ? data;


  EmailVerificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }


}

class Data {
  String ? email;



  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }


}