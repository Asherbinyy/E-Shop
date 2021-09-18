import 'package:e_shop/modules/home/home_screen.dart';
import 'package:e_shop/modules/location/location_screen.dart';

import '/modules/home/all/all_screen.dart';
import '/modules/cart/cart_screen.dart';
import '/modules/favourites/favourites_screen.dart';
import '/modules/setting/setting_screen.dart';
import 'package:flutter/material.dart';

class BottomNavModel {
  String? label;
  IconData? icon;
  Widget screen;


  BottomNavModel(
    this.label,
    this.icon, {
    required this.screen,

  });
  static List<BottomNavModel> _list = [
    BottomNavModel('Home', Icons.home, screen: HomeScreen()),
    BottomNavModel('Favourites', Icons.favorite, screen: FavouritesScreen()),
    BottomNavModel('Location', Icons.location_on_rounded, screen: LocationScreen()),
    BottomNavModel('Setting', Icons.settings, screen: SettingScreen()),
  ];
  static List<BottomNavModel> get getList => _list;
}
