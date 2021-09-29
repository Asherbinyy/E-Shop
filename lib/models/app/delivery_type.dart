class DeliveryTypeModel {
  String? label;
  String? subTitle;
  bool? isSelected;
  DeliveryTypeModel(this.label, {this.subTitle, this.isSelected = false});

  static List<DeliveryTypeModel> _list = [
    DeliveryTypeModel('Home',
        subTitle: '7 am to 9 pm everyday', isSelected: false),
    DeliveryTypeModel('Office',
        subTitle: '9 am to 6 pm sunday : Thursday', isSelected: false),
    DeliveryTypeModel('Other', subTitle: '', isSelected: false),
  ];
  static List<DeliveryTypeModel> get getAddressesType => _list;
}
