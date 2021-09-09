import 'package:e_shop/styles/constants.dart';
import 'package:flutter/cupertino.dart';

class WelcomeMessageModel {
  final String? message;
  final String? subMessage;
  final String? backgroundImage;
  /// The glowing shadow of the card borders
  final Color ? cardShadow;
  WelcomeMessageModel(
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

    //Midnight

    if (dateTime.hour > 23 || dateTime.hour <= 2) {
      _welcomeMessage = WelcomeMessageModel(
        'Hey, $userName 🌚 ',
        ' Wanna Spend Some money ?',
        backgroundImage: kWelcomeMessageImages[0],
        cardShadow:Color(0xff14528D),
      );
    }
    // morning

    else if (dateTime.hour > 2 && dateTime.hour <= 13) {
      _welcomeMessage = WelcomeMessageModel(
        'Morning $userName 🌝',
        ' Let\'s buy new things ',
        backgroundImage: kWelcomeMessageImages[1],
        cardShadow: Color(0xffFCD068),
      );
    }
    // day

    else if (dateTime.hour > 13 && dateTime.hour < 6) {
      _welcomeMessage = WelcomeMessageModel(
        'Welcome back $userName',
        '  We got some new things for you 😉 ',
        backgroundImage: kWelcomeMessageImages[2],
        cardShadow: Color(0xffFE9347),
      );
    }
    // night

    else {
      _welcomeMessage = WelcomeMessageModel(
        'Hello $userName 🥰 ',
        ' Let\'s fill this cart together 🛒 ',
        backgroundImage:kWelcomeMessageImages[3],
        cardShadow: Color(0xff07BABE),
      );
    }
    return _welcomeMessage;
  }
}
