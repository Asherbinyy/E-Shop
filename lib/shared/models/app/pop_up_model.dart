import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
///REVIEWED
class PopUpModel {
  final String label ;
  final String ?  value ;
  final IconData ?  icon ;
  const PopUpModel({Key? key,this.label='', this.icon,this.value}) : super();

  static List <PopUpModel> productOptions =[
    PopUpModel(label: 'list'.tr(),value:'List',icon:FontAwesomeIcons.listUl ),
    PopUpModel(label: 'grid'.tr(),value:'Grid',icon:FontAwesomeIcons.th ),
  ];
  static List <PopUpModel> bannerOptions =[
    PopUpModel(label: 'hide_ads'.tr(),value:'Hide',icon:Icons.dnd_forwardslash ),
  ];
}