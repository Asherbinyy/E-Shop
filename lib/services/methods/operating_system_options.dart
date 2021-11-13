import 'dart:io';
import 'package:flutter/services.dart';

/// Related to device orientation
class OperatingSystemOptions {
  OperatingSystemOptions._();
static Future <void> fixedOrientation (){
    List<DeviceOrientation> _orientations = [
      DeviceOrientation.portraitUp
    ];
    return SystemChrome.setPreferredOrientations(_orientations);
  }
/// hide status bar :
static void hideStatusBar ()=> SystemChrome.setEnabledSystemUIOverlays([]);
/// Shows status bar :
static Future<void> showStatusBar()=> SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
/// Device target platform :
static String getOs ()=>Platform.operatingSystem;

}
