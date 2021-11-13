import '../model/welcome_message_model.dart';
import '../../../styles/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class WelcomeMessagesProvider {
  WelcomeMessagesProvider._();
  /// a method that returns a different welcome message depends on day time (hour)
  static WelcomeMessageModel messageData(
      String userName,
      ){
    DateTime dateTime = DateTime.now();
    WelcomeMessageModel _welcomeMessage;

    ///Midnight
    // 24 or 2  1  0
    if (dateTime.hour > 23 || dateTime.hour <= 2) {
      _welcomeMessage = WelcomeMessageModel(
        'midnight'.tr() + ' $userName 🌚 ',
        'midnight_message'.tr(),
        backgroundImage: kWelcomeMessageImages[0],
        cardShadow:Color(0xff14528D),
      );
    }
    ///morning
    // 3 and 4 , 5 ,...., 13
    else if (dateTime.hour > 2 && dateTime.hour <= 13) {
      _welcomeMessage = WelcomeMessageModel(
        'morning'.tr()+' $userName 🌝',
        'morning_message'.tr(),
        backgroundImage: kWelcomeMessageImages[1],
        cardShadow: Color(0xffFCD068),
      );
    }
    /// day
    /// edit : 18 was 6
    else if (dateTime.hour > 13 && dateTime.hour < 18) {
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