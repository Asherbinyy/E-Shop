import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopUpModel {
  final String label ;
  final String ?  value ;
  final IconData ?  icon ;
  const PopUpModel({Key? key,this.label='', this.icon,this.value}) : super();

  static List <PopUpModel> productOptions =[
    PopUpModel(label: 'List',value:'List',icon:FontAwesomeIcons.listUl ),
    PopUpModel(label: 'Grid',value:'Grid',icon:FontAwesomeIcons.th ),
  ];
  static List <PopUpModel> bannerOptions =[
    PopUpModel(label: 'Hide Ads',value:'Hide',icon:Icons.dnd_forwardslash ),
  ];
}