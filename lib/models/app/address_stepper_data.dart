import '/modules/new_address/stepper/address_stepper.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
///REVIEWED
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
      title: 'basic_info'.tr() ,
      subTitle: 'basic_info_SubTitle'.tr() ,
      content: BasicInfoContent(),
    ),
    AddressStepperData(
      index: 1,
      title: 'address'.tr(),
      subTitle: 'address_SubTitle'.tr(),
      content: const AddressContent(),
    ),
    AddressStepperData(
      index: 2,
      title:  'delivery_address_type'.tr(),
      subTitle: 'delivery_address_type_SubTitle'.tr(),
      content: const  DeliveryTypeContent(),
    ),
    AddressStepperData(
      index: 3,
      title:  'place_your_location'.tr(),
      subTitle:  'place_your_location_SubTitle'.tr(),
      content: const LocationContent(),
    ),
    AddressStepperData(
      index: 4,
      title:   'complete'.tr(),
      subTitle:  '',
      content:const SizedBox(),
    ),
  ];
  static List<AddressStepperData> get data => _list;
}
