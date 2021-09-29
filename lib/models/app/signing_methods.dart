import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

/// reviewed
class SigningMethodsModel {
  final String name ;
  final IconData icon ;
  final Color color ;
  final VoidCallback? onPressed;

  SigningMethodsModel(this.name,this.icon,this.color,this.onPressed);


  static List <SigningMethodsModel> _list = [
    SigningMethodsModel('phone_number'.tr(), FontAwesomeIcons.phone, kThirdColor, (){} ),
    SigningMethodsModel('google'.tr(), FontAwesomeIcons.google, Color(0xffEA4335), (){} ),
    SigningMethodsModel('facebook'.tr(), FontAwesomeIcons.facebookF, Color(0xff139CF8), (){} ),
  ];
  static List <SigningMethodsModel> get getList => _list;
}