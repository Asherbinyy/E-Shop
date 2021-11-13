import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../styles/constants/constants.dart';
import 'package:flutter/material.dart';

class SigningMethods {
  final int? index ;
  final String label;
  final IconData icon;
  final Color? color;

  const SigningMethods._(
    this.label, {
    required this.icon,
    this.color,
        this.index,
  });
}

class SigningMethodsData {
  static final _signingMethodsList = <SigningMethods>[
    SigningMethods._(
        'phone_number'.tr(),
        index: 0,
        icon: FontAwesomeIcons.phone, color: kThirdColor),
    SigningMethods._('google'.tr(), index: 1,
        icon: FontAwesomeIcons.google, color: Color(0xffEA4335)),
    SigningMethods._('facebook'.tr(), index: 2,
        icon: FontAwesomeIcons.facebookF, color: Color(0xff139CF8)),
  ];
  static List<SigningMethods> get getSigningMethods => _signingMethodsList;
}
