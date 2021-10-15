import 'package:easy_localization/easy_localization.dart';
///REVIEWED
class DeliveryTypeModel {
 final String? label;
 final String? subTitle;
 final bool? isSelected;
 const DeliveryTypeModel(this.label, {this.subTitle, this.isSelected = false});

  static List<DeliveryTypeModel> _list = [
    DeliveryTypeModel('home'.tr(), subTitle: 'home_Subtitle'.tr(), isSelected: false),
    DeliveryTypeModel('office'.tr(), subTitle: 'office_Subtitle'.tr(), isSelected: false),
    DeliveryTypeModel('other'.tr(), subTitle: ''.tr(), isSelected: false),
  ];
  static List<DeliveryTypeModel> get getAddressesType => _list;
}
