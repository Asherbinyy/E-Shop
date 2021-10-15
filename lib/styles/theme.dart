import 'package:e_shop/styles/constants.dart';
import 'package:e_shop/styles/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode = ThemeData(
  scaffoldBackgroundColor: kLightPrimaryColor,
  backgroundColor: kLightPrimaryColor,
  primaryColor: ColorPalette.palette[colorIndex!].colors,
  primarySwatch: ColorPalette.palette[colorIndex!].colors,
  fontFamily: fontFamily,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: kLightPrimaryColor,
    selectedItemColor: ColorPalette.palette[colorIndex!].colors,
    unselectedItemColor: ColorPalette.palette[colorIndex!].colors.shade300,
    // unselectedItemColor: kSecondaryColorLight,
    elevation: 5.0,
    type: BottomNavigationBarType.fixed,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: kLightPrimaryColor,
    elevation: 0.0,
    centerTitle: true,
    titleTextStyle: TextStyle(
        color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: kDarkPrimaryColor),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: kLightPrimaryColor,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: kLightPrimaryColor,
    unselectedLabelColor: ColorPalette.palette[colorIndex!].colors,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(color: kLightPrimaryColor),
    bodyText2: TextStyle(color: kDarkPrimaryColor),
    headline5: TextStyle(color: kDarkSecondaryColor),
    headline6: TextStyle(color: kDarkSecondaryColor),
    subtitle1: TextStyle(fontWeight: FontWeight.bold),
    button: TextStyle(fontSize: 12),
    overline: TextStyle(color: kLightPrimaryColor),
  ),
  // radioTheme: RadioThemeData(
  //   fillColor: MaterialStateProperty.all(Color(0xff5156454)),
  //   overlayColor:  MaterialStateProperty.all(Colors.red),
  // ),

  popupMenuTheme: PopupMenuThemeData(
    color: kLightSecondaryColor,
    textStyle: const TextStyle(color: kThirdColor),
  ),
  iconTheme: IconThemeData(color: kDarkPrimaryColor),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shadowColor: ColorPalette.palette[colorIndex!].colors.withOpacity(0.1),
      // shadowColor: kPrimaryColorLight.withOpacity(0.1),
      elevation: 2.0,
      side: BorderSide(
        width: 1.0,
        color: kDarkSecondaryColor.withOpacity(0.05),
      ),
    ),
  ),
);

ThemeData darkMode = ThemeData(
  scaffoldBackgroundColor: kDarkPrimaryColor,
  backgroundColor: kDarkPrimaryColor,
  primarySwatch: ColorPalette.palette[colorIndex!].colors,
  cardColor: kDarkPrimaryColor,
  fontFamily: fontFamily,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: kDarkPrimaryColor,
    selectedItemColor: ColorPalette.palette[colorIndex!].colors,
    unselectedItemColor: ColorPalette.palette[colorIndex!].colors.shade300,
    // unselectedItemColor: kSecondaryColorLight,
    elevation: 5.0,
    type: BottomNavigationBarType.fixed,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: kDarkPrimaryColor,
    elevation: 0.0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: kLightPrimaryColor,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: kLightPrimaryColor,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: kDarkPrimaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelColor: kLightPrimaryColor,
    unselectedLabelColor: kLightPrimaryColor,
    // unselectedLabelColor: kSecondaryColorLight,
  ),
  textTheme: TextTheme(
    caption: TextStyle(color: Colors.grey),
    bodyText1: TextStyle(color: kDarkPrimaryColor),
    bodyText2: TextStyle(color: kLightPrimaryColor),
    headline5: TextStyle(color: kLightSecondaryColor),
    headline6: TextStyle(color: kLightSecondaryColor),
    subtitle1:
        TextStyle(fontWeight: FontWeight.bold, color: kLightPrimaryColor),
    subtitle2: TextStyle(color: kLightPrimaryColor),
    button: TextStyle(fontSize: 12),
    overline: TextStyle(color: kDarkPrimaryColor.withOpacity(0.7)),
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: kDarkSecondaryColor,
    textStyle: TextStyle(),
  ),
  iconTheme: IconThemeData(color: kLightPrimaryColor),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
        shadowColor: ColorPalette.palette[colorIndex!].colors.withOpacity(0.1),
        elevation: 2.0,
        side:
            BorderSide(width: 1, color: kLightSecondaryColor.withOpacity(0.1))),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: kDarkSecondaryColor,
  ),
);
