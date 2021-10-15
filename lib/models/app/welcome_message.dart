import '/../styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';

/// reviewed

class WelcomeMessageModel {
  final String? message;
  final String? subMessage;
  final String? backgroundImage;
  /// The glowing shadow of the card borders
  final Color ? cardShadow;
 const WelcomeMessageModel(
    this.message,
    this.subMessage, {
    this.backgroundImage,
    this.cardShadow,
  });

  static WelcomeMessageModel getWelcomeMessage(
    String userName,
  ) {
    DateTime dateTime = DateTime.now();
    WelcomeMessageModel _welcomeMessage;

    ///Midnight

    if (dateTime.hour > 23 || dateTime.hour <= 2) {
      _welcomeMessage = WelcomeMessageModel(
        'midnight'.tr() + ' $userName 🌚 ',
        'midnight_message'.tr(),
        backgroundImage: kWelcomeMessageImages[0],
        cardShadow:Color(0xff14528D),
      );
    }
    ///morning

    else if (dateTime.hour > 2 && dateTime.hour <= 13) {
      _welcomeMessage = WelcomeMessageModel(
        'morning'.tr()+' $userName 🌝',
        'morning_message'.tr(),
        backgroundImage: kWelcomeMessageImages[1],
        cardShadow: Color(0xffFCD068),
      );
    }
    /// day

    else if (dateTime.hour > 13 && dateTime.hour < 6) {
      _welcomeMessage = WelcomeMessageModel(
        'day'.tr()+' $userName',
        'day_message'.tr()+'😉 ',
        backgroundImage: kWelcomeMessageImages[2],
        cardShadow: Color(0xffFE9347),
      );
    }
    /// night

    else {
      _welcomeMessage = WelcomeMessageModel(
        'night'.tr()+' $userName 🥰 ',
        'night_message'.tr()+' 🛒 ',
        backgroundImage:kWelcomeMessageImages[3],
        cardShadow: Color(0xff07BABE),
      );
    }
    return _welcomeMessage;
  }
}


