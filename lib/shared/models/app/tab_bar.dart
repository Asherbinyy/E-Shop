import '/modules/home/all/all_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
/// reviewed
class TabBarModel {
  final String label ;
  final Widget screen ;
  TabBarModel({required this.label,required this.screen});

  /// Adding any new screen here !
  static List<TabBarModel> staticTabs = [
    TabBarModel(label: 'all_screen'.tr(),screen: const AllScreen()),
  ];
}

