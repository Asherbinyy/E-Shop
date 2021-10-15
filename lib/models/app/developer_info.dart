import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
///REVIEWED
class DeveloperInfo {
  final String label ;
  final String body ;
   final IconData ? icon;
  const DeveloperInfo( {required this.label,required this.body, this.icon});

  static var _infoList = <DeveloperInfo>[
    DeveloperInfo(
        label: 'email'.tr(),
        body: 'ahmed.elsherbiny2020@gmail.com',
      icon: FontAwesomeIcons.solidEnvelope,
    ),
    DeveloperInfo(
        label: 'address'.tr(),
        body: 'Mansoura, Egypt',
      icon: FontAwesomeIcons.home,
    ),
    DeveloperInfo(
        label: 'phone_number'.tr(),
        body: '+20 01096710597' ,
      icon:  FontAwesomeIcons.phone,
    ),
  ];
  static List <DeveloperInfo> get getInfo => _infoList;
  // NOT USED YET
  static var _aboutList =
  DeveloperInfo(
    label: 'about'.tr(),
    body: '.........',
  );
  static DeveloperInfo get getAbout => _aboutList;
}