import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class SystemMode {
  final String label;
  final String value;
  final IconData icon;

  const SystemMode(
      {required this.label, required this.value, required this.icon});
  static var _list = <SystemMode>[
    SystemMode(
      label: 'dark_mode'.tr(),
      icon: FontAwesomeIcons.solidMoon,
      value: 'Dark Mode',
    ),
    SystemMode(
      label: 'light_mode'.tr(),
      icon: FontAwesomeIcons.solidSun,
      value: 'Light Mode',
    ),
  ];

  static List<SystemMode> get getSystemModes =>_list ;
}
