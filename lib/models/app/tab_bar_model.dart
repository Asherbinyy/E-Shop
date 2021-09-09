import 'package:e_shop/modules/main_home/home/home_screen.dart';

import 'package:flutter/material.dart';

class TabBarModel {
  final String label ;
  final Widget screens ;
  TabBarModel(this.label,this.screens);


  /// Adding any new screen here !
  static List<TabBarModel> staticTabs = [
    TabBarModel('All', HomeScreen()),
  ];
}

