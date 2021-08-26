import '/styles/constants.dart';
import 'package:flutter/material.dart';

class LandingModel {
  final String? imageUrl;
  final String? title;
  final String? body;
  final Color? backgroundColor;
  LandingModel({this.imageUrl, this.body, this.title, this.backgroundColor});
  static List<LandingModel> _list = [
    LandingModel(
        title: 'E-Shop Provides you all your needs ',
        body: 'It\'s all set for you with a variety of products and categories',
        imageUrl: kLandingImages[0]),
    LandingModel(
        title: 'Delivery ',
        body: 'Wherever you live we will ship our products for you ! ',
        imageUrl: kLandingImages[1]),
    LandingModel(
        title: 'Payment Methods ',
        body:
            'E-Shop gives you the ability to pay online . Also you can buy after you get your products',
        imageUrl: kLandingImages[2]),
  ];
  static List<LandingModel> get getLandingList => _list;
}
