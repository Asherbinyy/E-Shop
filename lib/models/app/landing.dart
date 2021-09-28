import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// reviewed

class LandingModel {
  final String? imageUrl;
  final String? title;
  final String? body;
  final Color? backgroundColor;
  LandingModel({this.imageUrl, this.body, this.title, this.backgroundColor});
  static List<LandingModel> _list = [
    LandingModel(
        title: 'landing_title_1'.tr(),
        body: 'landing_body_1'.tr(),
        imageUrl: kLandingImages[0]),
    LandingModel(
        title: 'landing_title_2'.tr(),
        body:'landing_body_2'.tr(),
        imageUrl: kLandingImages[1]),
    LandingModel(
        title: 'landing_title_3'.tr(),
        body:
        'landing_body_3'.tr(),
        imageUrl: kLandingImages[2]),
  ];
  static List<LandingModel> get getLandingList => _list;
}
