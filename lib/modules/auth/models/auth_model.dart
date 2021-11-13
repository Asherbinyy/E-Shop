
import 'package:e_shop/modules/auth/models/user_model.dart';

/// Used in signup / login cause both have the same response ..
class AuthModel {
  bool? status;
  String? message;
  UserModel? data ;

  AuthModel.fromJson(Map<String,dynamic> json ){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserModel.formJson(json['data']) : null;
  }
}


