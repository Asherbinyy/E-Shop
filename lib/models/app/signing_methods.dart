import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

/// reviewed
class SitesLinksModel {
  final String name;
  final IconData icon;
  final Color color;
  final String link;

  SitesLinksModel(this.name, this.icon, this.color, this.link);

  static var _signingMethodsList = <SitesLinksModel>[
    SitesLinksModel(
        'phone_number'.tr(), FontAwesomeIcons.phone, kThirdColor, ''),
    SitesLinksModel(
        'google'.tr(), FontAwesomeIcons.google, Color(0xffEA4335), ''),
    SitesLinksModel(
        'facebook'.tr(), FontAwesomeIcons.facebookF, Color(0xff139CF8), ''),
  ];
  static List<SitesLinksModel> get getSigningMethods => _signingMethodsList;

  static var _developerLinks = <SitesLinksModel>[
    SitesLinksModel(
      'phone_number'.tr(),
      FontAwesomeIcons.phone,
      kThirdColor,
      'tel:+201096710597',
    ),
    SitesLinksModel(
      'twitter'.tr(),
      FontAwesomeIcons.twitter,
      Color(0xff1A8CD8),
      'https://twitter.com/sherbinovic',
    ),
    SitesLinksModel(
      'github',
      FontAwesomeIcons.github,
      Colors.black87,
      'https://github.com/Asherbinyy',
    ),
    SitesLinksModel(
      'stackoverflow',
      FontAwesomeIcons.stackOverflow,
      Colors.deepOrange,
      'https://stackoverflow.com/users/16408031/ahmed-elsherbini',
    ),
    SitesLinksModel(
      'facebook'.tr(),
      FontAwesomeIcons.facebookF,
      Color(0xff139CF8),
      'https://www.facebook.com/profile.php?id=100004409198217',
    ),
  ];
  static List<SitesLinksModel> get getDeveloperLinks => _developerLinks;
}
