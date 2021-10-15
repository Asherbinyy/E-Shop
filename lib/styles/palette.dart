import 'package:flutter/material.dart';
///reviewed

/// used in appearance screen
class ColorPalette {
final  MaterialColor colors ;
final  String logo ;
ColorPalette({required this.colors,required this.logo});

static List<ColorPalette> palette = [
  //indigo
  ColorPalette(colors:const MaterialColor(
    0xff4050b5, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff3a48a3), //10%
      100: const Color(0xff334091), //20%
      200: const Color(0xff2d387f), //30%
      300: const Color(0xff26306d), //40%
      400: const Color(0xff20285b), //50%
      500: const Color(0xff1a2048), //60%
      600: const Color(0xff131836), //70%
      700: const Color(0xff0d1024), //80%
      800: const Color(0xff060812), //90%
      900: const Color(0xff000000), //100%
    },
  ), logo: 'assets/images/logo1.png'),
  //deep purple
  ColorPalette(colors:const MaterialColor(
    0xFF673AB7,
    <int, Color>{
      50: Color(0xFFEDE7F6),
      100: Color(0xFFD1C4E9),
      200: Color(0xFFB39DDB),
      300: Color(0xFF9575CD),
      400: Color(0xFF7E57C2),
      500: Color(0xFF673AB7),
      600: Color(0xFF5E35B1),
      700: Color(0xFF512DA8),
      800: Color(0xFF4527A0),
      900: Color(0xFF311B92),
    },
  ), logo: 'assets/images/logo2.png'),
  //teal
  ColorPalette(colors:const MaterialColor(
    0xFF009688,
    <int, Color>{
      50: Color(0xFFE0F2F1),
      100: Color(0xFFB2DFDB),
      200: Color(0xFF80CBC4),
      300: Color(0xFF4DB6AC),
      400: Color(0xFF26A69A),
      500: Color(0xFF009688),
      600: Color(0xFF00897B),
      700: Color(0xFF00796B),
      800: Color(0xFF00695C),
      900: Color(0xFF004D40),
    },
  ), logo: 'assets/images/logo3.png'),
  //amber
  ColorPalette(colors:const   MaterialColor(
    0xFFFFC107, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
      const <int, Color>{
        50: Color(0xFFFFF8E1),
        100: Color(0xFFFFECB3),
        200: Color(0xFFFFE082),
        300: Color(0xFFFFD54F),
        400: Color(0xFFFFCA28),
        500: Color(0xFFFFC107),
        600: Color(0xFFFFB300),
        700: Color(0xFFFFA000),
        800: Color(0xFFFF8F00),
        900: Color(0xFFFF6F00),
      },
    ), logo: 'assets/images/logo4.png'),
  //pink
  ColorPalette(colors: const MaterialColor(
    0xFFC2185B, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: Color(0xFFFCE4EC),
      100: Color(0xFFF8BBD0),
      200: Color(0xFFF48FB1),
      300: Color(0xFFF06292),
      400: Color(0xFFEC407A),
      500: Color(0xFFE91E63),
      600: Color(0xFFD81B60),
      700: Color(0xFFC2185B),
      800: Color(0xFFAD1457),
      900: Color(0xFF880E4F),
    },
  ), logo: 'assets/images/logo5.png'),
  //deep orange
  ColorPalette(colors:const MaterialColor(
    0xFFFF5722,
    <int, Color>{
      50: Color(0xFFFBE9E7),
      100: Color(0xFFFFCCBC),
      200: Color(0xFFFFAB91),
      300: Color(0xFFFF8A65),
      400: Color(0xFFFF7043),
      500: Color(0xFFFF5722),
      600: Color(0xFFF4511E),
      700: Color(0xFFE64A19),
      800: Color(0xFFD84315),
      900: Color(0xFFBF360C),
    },
  ), logo: 'assets/images/logo6.png'),
];
}
