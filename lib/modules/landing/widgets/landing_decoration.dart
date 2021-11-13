part of 'widgets_landing_imports.dart';

class LandingDecoration extends BoxDecoration{

  @override
  // TODO: implement gradient
  Gradient? get gradient => LinearGradient(
    colors: [
      kPrimaryColor,
      kDarkSecondaryColor,
    ],
    stops: [0.1, 1],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    tileMode: TileMode.repeated,
  );

}

