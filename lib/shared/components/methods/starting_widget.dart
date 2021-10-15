import 'package:e_shop/layout/layout_screen.dart';
import 'package:e_shop/modules/landing/landing_screen.dart';
import 'package:e_shop/modules/login/login_screen.dart';
import 'package:e_shop/modules/welcome_message/welcome_message_screen.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';
/// Returns home Widget depends on the value of token & cached memory
Widget getStartingWidget(bool ? isLanding) {
  Widget _widget;
  if (isLanding != null) {
    if (token != null && token != '')
      _widget = stopWelcome ?const LayoutScreen() :const WelcomeMessageScreen ();
    else
      _widget =const LoginScreen();
  } else
    _widget = const LandingScreen();
  return _widget;
}