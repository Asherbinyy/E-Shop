class SignOutModel {
  bool? status;
  String? message;
  Data? data ;

  SignOutModel.formJson(Map<String,dynamic> json ){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.formJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? token;



  Data.formJson(Map<String,dynamic> json ){
    id = json['id'];
    token = json['token'];
  }
}