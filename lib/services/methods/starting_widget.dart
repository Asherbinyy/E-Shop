import 'package:e_shop/modules/auth/login/view/login_imports.dart';
import 'package:e_shop/modules/landing/view/landing_imports.dart';
import 'package:e_shop/modules/layout/layout_screen.dart';
import 'package:e_shop/modules/welcome_message/view/import_welcome_messages.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:flutter/material.dart';
/// Returns home Widget depends on the value of token & cached memory
class OnStarting {

}

Widget getStartingWidget(bool ? isLanding) {
  Widget _widget;
  if (isLanding != null) {
    if (token != null && token != '')
      _widget = stopWelcome ? const LayoutScreen() :const WelcomeMessageScreen ();
    else
      _widget =const LoginScreen();
  } else
    _widget = const LandingScreen();
  return _widget;
}

