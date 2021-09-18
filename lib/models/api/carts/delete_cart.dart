class DeleteCartModel {
  bool ?status;
  String ? message;

  DeleteCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
