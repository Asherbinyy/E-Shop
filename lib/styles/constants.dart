import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Colors
const Color kPrimaryColor = Color(0xff6BDCB4); // blue
const Color kPrimaryColorDarker = Color(0xff0a8060);
const Color kSecondaryColorDarker = Color(0xff2690AD);
const Color kSecondaryColor = Color(0xff76D5F9); // فيروزي
const Color kThirdColor = Color(0xffbba512); // deep yellow
// light Mode
const Color kLightPrimaryColor=Colors.white;
const Color kLightSecondaryColor=Color(0xFFF5F5F5);
const Color kLightThirdColor=Color(0xff686A6C); //TODO 1 : update this
// Dark Mode
const Color kDarkPrimaryColor=Color(0xff1D3037); // deep dark
const Color kDarkSecondaryColor=Color(0xff1F2029); // deep dark
const Color kDarkThirdColor=Color(0xff686A6C); // light grey


// Fonts
const String fontFamily = 'Montserrat' ;
const String kDummyText = 'What is Lorem Ipsum?Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';
// const String fontFamily = 'Cairo' ;

// Pics
const String kDefaultImage = 'assets/images/default.JPG';
const String kMoon = 'assets/images/moon.JPG';
const String kArabicFlag = 'assets/images/ar.png';
const String kEnglishFlag = 'assets/images/en.png';
const String kHiImage = 'assets/images/hi.gif';
const String kLogoDark = 'assets/images/logo_dark.png';
const String kLogoLight = 'assets/images/logo_light.png';
const String kLogo = 'assets/images/logo4.png';
const List<String> kLandingImages = [
  'assets/images/landing.png',
  'assets/images/landingg.png',
  'assets/images/landinggg.png',
];
const List<String> kBannerImages = [
  'assets/images/banner.jpg',
  'assets/images/bannerr.jpg',
];

//methods :
// hide & show status bar :
void hideStatusBar ()=> SystemChrome.setEnabledSystemUIOverlays([]);
Future<void> showStatusBar()=> SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

//enums
enum BNB {HOME,FAVOURITES,CART,SETTINGS}

// user experience
const String token = '';
const String appLang ='en';


// loaders
const kLoadingHourGlass = SpinKitPouringHourGlass(
  color: kThirdColor,
  size: 30.0,
  duration: Duration(seconds: 1),
  strokeWidth: 1,
);
const kLoadingWanderingCubes = SpinKitWanderingCubes(
  color: kThirdColor,
  size: 25.0,
);
const kLoadingFadingCircle = SpinKitFadingCircle(
  color: kThirdColor,
  size: 25.0,
);
