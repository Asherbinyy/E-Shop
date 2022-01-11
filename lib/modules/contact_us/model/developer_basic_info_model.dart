import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeveloperBasicInfoModel {
  final String label;
  final String body;
  final IconData? icon;
  const DeveloperBasicInfoModel._(
      {required this.label, required this.body, this.icon});
}

class DeveloperInfoData {
  DeveloperInfoData._();
  static var _infoList = <DeveloperBasicInfoModel>[
    DeveloperBasicInfoModel._(
      label: 'email'.tr(),
      body: 'ahmed.elsherbiny2020@gmail.com',
      icon: FontAwesomeIcons.solidEnvelope,
    ),
    DeveloperBasicInfoModel._(
      label: 'address'.tr(),
      body: 'Mansoura, Egypt',
      icon: FontAwesomeIcons.home,
    ),
    DeveloperBasicInfoModel._(
      label: 'phone_number'.tr(),
      body: '+20 01096710597',
      icon: FontAwesomeIcons.phone,
    ),
  ];
  static List<DeveloperBasicInfoModel> get getInfo => _infoList;
  // NOT USED YET
  static var _aboutList = DeveloperBasicInfoModel._(
    label: 'about'.tr(),
    body: '.........',
  );
  static DeveloperBasicInfoModel get getAbout => _aboutList;
}
