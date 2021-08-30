import 'package:e_shop/modules/Home/home/home_screen.dart';
import 'package:e_shop/modules/cart/cart_screen.dart';
import 'package:e_shop/modules/favourites/favourites_screen.dart';
import 'package:e_shop/modules/setting/setting_screen.dart';
import 'package:flutter/material.dart';

class BottomNavModel {
  String? label;
  IconData? icon;
  Widget screen;

  BottomNavModel(this.label, this.icon,{required this.screen,});
  static List<BottomNavModel> _list = [
    BottomNavModel('Home', Icons.home,screen: HomeScreen()),
    BottomNavModel('Favourites', Icons.favorite,screen: FavouritesScreen()),
    BottomNavModel('Cart', Icons.shopping_cart,screen: CartScreen()),
    BottomNavModel('Setting', Icons.settings,screen: SettingScreen()),

  ];
  static List<BottomNavModel> get getList => _list;
}
