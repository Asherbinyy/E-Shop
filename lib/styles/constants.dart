import 'dart:io';
import '../../models/api/categories/categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Colors ---------------------------------------------------------------------
const Color kPrimaryColor = Color(0xff0a8060);
const Color kSecondaryColor = Color(0xff2690AD);
const Color kThirdColor = Color(0xffFECC5A);
const Color kPrimaryColorLight = Color(0xff6BDCB4);
const Color kSecondaryColorLight = Color(0xff76D5F9);
// light Mode
const Color kLightPrimaryColor=Colors.white;
const Color kLightSecondaryColor=Color(0xFFF5F5F5);
const Color kLightThirdColor=Color(0xff686A6C);
// Dark Mode
const Color kDarkPrimaryColor=Color(0xff1D3037); // deep dark
const Color kDarkSecondaryColor=Color(0xff1F2029); // deep dark
const Color kDarkThirdColor=Color(0xff767d7d); // light grey
// like button
const Color kLikeButtonColor =  Color(0xffF36054);
// String
const String kDummyText = '';

// Fonts
const String fontFamily = 'Montserrat' ;
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
const List<String> kWelcomeMessageImages = [
  'assets/images/midnight.JPG',
  'assets/images/morning.JPG',
  'assets/images/day.JPG',
  'assets/images/night.JPG',
];
/// Eg= 0 , PAL = 1 , UAE = 2, UK=3
const List<String> kCountriesImages = [
  'assets/images/flags/egypt.png',
  'assets/images/flags/palestine.png',
  'assets/images/flags/united-arab-emirates.png',
  'assets/images/flags/united-kingdom.png',
];
//categories images
String getCategoryImageUrl (DataCategoriesData category){
  String _imageUrl ;
  if (category.name=='electrionic devices') _imageUrl = 'assets/images/electronics.JPG';
  else if (category.name=='Prevent Corona') _imageUrl = 'assets/images/covid.JPG';
  else if (category.name=='sports') _imageUrl = 'assets/images/sports.png';
  else if (category.name=='Best Selling') _imageUrl = 'assets/images/bestsellering.JPG';
  else if (category.name=='Lighting') _imageUrl = 'assets/images/lightning.JPG';
  else _imageUrl ='assets/images/category.JPG';
  return _imageUrl;
}

// const String kElectronicsImage = 'assets/images/electronics.JPG';
// const String kCovidImage = 'assets/images/covid.JPG';
// const String kSportsImage = 'assets/images/sports.JPG';
// const String kBestSellingImage = 'assets/images/bestsellering.JPG';
// const String kLightningImage = 'assets/images/lightning.JPG';
// const String kCategoryImage = 'assets/images/category.JPG';


const String kNoConnectionImage = 'assets/images/1_No Connection.png';
const String kNoImageFound = 'https://image.freepik.com/free-vector/no-data-concept-illustration_114360-536.jpg';
//hash Image
const BlurHash kHashImage = BlurHash(hash: "L84g6F.k%#t7%1%#x]tRjEn+oLoI");


//Lottie Animation
const String kSuccessLottie = 'assets/animation/success.json';
const String kFailedLottie = 'assets/animation/failed.json';
const String kLikeLottie = 'assets/animation/like.json';
const String kUnlikeLottie = 'assets/animation/unlike.json';
const String kDeleteLottie = 'assets/animation/delete.json';
const String kSignUpLottie = 'assets/animation/sign_up.json';
const String kCongratulationLottie = 'assets/animation/congrat.json';
const String kSwipeLeftLottie = 'assets/animation/swipe_left.json';
const String kEmptyListLottie = 'assets/animation/emptyList.json';
const String kEmptyCartLottie = 'assets/animation/empty_cart.json';
const String kEmptySearchLottie = 'assets/animation/emptyseach.json';
const String kAddedToCartLottie = 'assets/animation/addedtocart.json';
const String kAddedToCart2Lottie = 'assets/animation/addedtocart2.json';

//methods :
// hide & show status bar :
void hideStatusBar ()=> SystemChrome.setEnabledSystemUIOverlays([]);
Future<void> showStatusBar()=> SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
 String getOs ()=>Platform.operatingSystem;



//enums
// not used
enum BNB {HOME,FAVOURITES,CART,SETTINGS}

// user experience
 String ? token = '';
 String ? appLanguage = '';
 bool  stopWelcome =false;


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
const kLoadingPulse = SpinKitPulse(
  color: kThirdColor,
  size: 25.0,
);

// Decorations
Decoration get landingDecoration =>  BoxDecoration(
  gradient: LinearGradient(
    colors: [
      kPrimaryColor,
      kDarkSecondaryColor,
    ],
    stops: [0.1, 1],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    tileMode: TileMode.repeated,
  ),
);
Decoration? signingButtonDecoration({
  double? startAngle ,
  double? endAngle,
}) => BoxDecoration(
  borderRadius: BorderRadius.circular(25.0) ,
  gradient: SweepGradient(
    colors: [
      kPrimaryColorLight,

      kSecondaryColorLight,
      // kThirdColor,
    ],
    center: Alignment.topRight,
    startAngle: startAngle = 1,
    endAngle: endAngle = 6,
  ),
);

Decoration productCardDecoration(bool isDark) => BoxDecoration(
  borderRadius: BorderRadius.circular(10.0),
  color: isDark ? kDarkThirdColor.withOpacity(0.7) : kLightSecondaryColor,
  boxShadow: [
    BoxShadow(
      color: kSecondaryColor.withOpacity(0.2),
      blurRadius: 7,
      spreadRadius: 1,
      offset: Offset(0, 0),
    ),
  ],
);
Decoration welcomeCardDecoration(bool isDark,String imageUrl, {Color glowColor = Colors.white}) => BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
        color: glowColor,
        blurRadius: 5,
        spreadRadius: 0.2,
        offset: Offset(2, 2),
      ),
      BoxShadow(
        color: glowColor,
        blurRadius: 5,
        spreadRadius: 0.2,
        offset: Offset(-2, -2),
      ),
    ],
    image: DecorationImage(
      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
      image: AssetImage(
          imageUrl),fit: BoxFit.cover,
    )
);
//not used
Decoration defaultCardDecoration(bool isDark) => BoxDecoration(
  borderRadius: BorderRadius.circular(8.0),
  boxShadow: [
    BoxShadow(
      color: kSecondaryColor.withOpacity(0.2),
      blurRadius: 7,
      spreadRadius: 1,
      offset: Offset(0, 0),
    ),
  ],
  gradient: LinearGradient(
    begin:  AlignmentDirectional.topEnd,
    end: AlignmentDirectional.bottomCenter,
    colors:  [
      isDark ? kSecondaryColor.withOpacity(0.4)
          : kSecondaryColor.withOpacity(0.1),
      isDark ? kSecondaryColor : kSecondaryColor,
    ],),
  // image: DecorationImage(
  //     image: AssetImage(
  //         kWelcomeMessageImages[3]),fit: BoxFit.cover,
  //
  // )
);
Widget curvedBottomSheetDecoration (bool isDark,{Widget ? child}){
  return Container(
    decoration: BoxDecoration(
      color: isDark?Color(0xff001414):Color(0xff757575),
    ),
    child: Container(
      decoration: BoxDecoration(
        color: isDark?kDarkSecondaryColor:kLightSecondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: child?? null,
    ),
  );
}



// ******* My Account **********
// username : ahmedshiko@gmail.com
// password : 123456
