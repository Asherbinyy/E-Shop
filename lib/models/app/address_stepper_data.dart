import 'package:e_shop/modules/new_address/stepper/address_stepper.dart';
import 'package:flutter/material.dart';

class AddressStepperData {
  final int index;
  final String title;
  final String subTitle;
  final Widget content;

  const AddressStepperData(
      {required this.title, required this.subTitle, required this.content,required this.index});

  static List<AddressStepperData> _list = [
    AddressStepperData(
      index: 0,
      title: 'Basic Info.' ,
      subTitle: 'make sure you updated your latest phone number' ,
      content: BasicInfoContent(),
    ),
    AddressStepperData(
      index: 1,
      title: 'Address',
      subTitle: 'Try to be precised',
      content:  AddressContent(),
    ),
    AddressStepperData(
      index: 2,
      title:  'Delivery Address Type',
      subTitle: 'Specify your address type',
      content:  DeliveryTypeContent(),
    ),
    AddressStepperData(
      index: 3,
      title:  'Place your Location',
      subTitle:  'Choose whether you pick your address on Map or get your current location',
      content: LocationContent(),
    ),
    AddressStepperData(
      index: 4,
      title:   'Complete',
      subTitle:  '',
      content: Container(),
    ),
  ];
  static List<AddressStepperData> get data => _list;
}
