import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PopUpModel {
  final String label ;
  final IconData ?  icon ;
  const PopUpModel({Key? key,this.label='', this.icon,}) : super();

  static List <PopUpModel> productOptions =[
    PopUpModel(label: 'List',icon:FontAwesomeIcons.listUl ),
    PopUpModel(label: 'Grid',icon:FontAwesomeIcons.th ),
  ];
}