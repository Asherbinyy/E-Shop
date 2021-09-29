class DeleteAddressModel {
  bool ? status ;
  String ? message ;

  DeleteAddressModel.fromJson(Map<String,dynamic>json){
    status = json['status'];
    message = json['message'];
  }
}