import 'package:e_shop/modules/main_home/main_home_screen.dart';

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
    BottomNavModel(
      'main_home',
      Icons.home,
      screen: MainHomeScreen(),
    ),
    BottomNavModel('Favourites', Icons.favorite, screen: FavouritesScreen()),
    BottomNavModel('Cart', Icons.shopping_cart, screen: CartScreen()),
    BottomNavModel('Setting', Icons.settings, screen: SettingScreen()),
  ];
  static List<BottomNavModel> get getList => _list;
}
