import 'package:e_shop/modules/addresses/current_adresses/view/current_addresses_screen.dart';

import '../../../modules/home/view/home_screen.dart';
import '../../../modules/favourites/view/favourites_screen.dart';
import '../../../modules/setting/view/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

///reviewed
class BottomNavModel {
  final String? label;
  final IconData? icon;
  final Widget screen;

  const BottomNavModel(
    this.label,
    this.icon, {
    required this.screen,
  });
  static List<BottomNavModel> _list = [
    BottomNavModel('home'.tr(), Icons.home, screen: const HomeScreen()),
    BottomNavModel('favourites'.tr(), Icons.favorite,
        screen: const FavouritesScreen()),
    BottomNavModel('addresses'.tr(), Icons.location_on_rounded,
        screen: const AddressesScreen()),
    BottomNavModel('setting'.tr(), Icons.settings,
        screen: const SettingScreen()),
  ];
  static List<BottomNavModel> get getList => _list;
}
