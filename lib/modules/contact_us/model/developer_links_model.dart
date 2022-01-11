import 'package:e_shop/styles/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

/// reviewed
class DeveloperLinksModel {
  final String name;
  final IconData icon;
  final Color color;
  final String link;

 const DeveloperLinksModel._(this.name, this.icon, this.color, this.link);

}
class DeveloperLinksData {
  DeveloperLinksData._();
  static var _developerLinks = <DeveloperLinksModel>[
    DeveloperLinksModel._(
      'phone_number'.tr(),
      FontAwesomeIcons.phone,
      kThirdColor,
      'tel:+201096710597',
    ),
    DeveloperLinksModel._(
      'twitter'.tr(),
      FontAwesomeIcons.twitter,
      Color(0xff1A8CD8),
      'https://twitter.com/sherbinovic',
    ),
    DeveloperLinksModel._(
      'github',
      FontAwesomeIcons.github,
      Colors.black87,
      'https://github.com/Asherbinyy',
    ),
    DeveloperLinksModel._(
      'stackoverflow',
      FontAwesomeIcons.stackOverflow,
      Colors.deepOrange,
      'https://stackoverflow.com/users/16408031/ahmed-elsherbini',
    ),
    DeveloperLinksModel._(
      'facebook'.tr(),
      FontAwesomeIcons.facebookF,
      Color(0xff139CF8),
      'https://www.facebook.com/profile.php?id=100004409198217',
    ),
  ];
  static List<DeveloperLinksModel> get getDeveloperLinks => _developerLinks;
}