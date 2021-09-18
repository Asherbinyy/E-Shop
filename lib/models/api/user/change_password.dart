class ChangePasswordModel {
  bool ? status;
  String ? message;
  // ChangePasswordData ? data;


  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // data = json['data'] != null ? new ChangePasswordData.fromJson(json['data']) : null;
  }

}
//
// class ChangePasswordData {
//   String ?email;
//
//
//   ChangePasswordData.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//   }
//
// }