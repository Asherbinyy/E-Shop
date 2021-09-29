import 'package:flutter/material.dart';

class XDivider {
  static Widget faded ({double height = 1.0}) => Opacity(opacity: 0.1,child: Container( width: double.infinity, height: height, color: Colors.grey[300],));
  static Widget semiFaded ({double height = 1.0}) => Opacity(opacity: 0.5,child: Container( width: double.infinity, height: height, color: Colors.grey[300],));
  static Widget normal ({double height = 1.0}) => Opacity(opacity: 1,child: Container( width: double.infinity, height: height, color: Colors.grey[300],));
}
class XSpace {
  XSpace._();
  /// width : 2.5
  static SizedBox get tiny => const SizedBox(width: 2.5,);
  /// width : 5.0
  static SizedBox get light =>const SizedBox(width: 5,);
  /// width : 10.0
  static SizedBox get normal => const SizedBox(width: 10,);
  /// width : 15.0
  static SizedBox get hard=>const SizedBox(width: 15,);
  /// width : 20.0
  static SizedBox get extreme=>const SizedBox(width: 20,);
  /// width : 25.0
  static SizedBox get titan=>const SizedBox(width: 25,);
}
class YSpace {
  YSpace._();
  /// height : 2.5
  static SizedBox get tiny => const SizedBox(height: 2.5,);
  /// height : 5.0
  static SizedBox get light =>const SizedBox(height: 5,);
  /// height : 10.0
  static SizedBox get normal => const SizedBox(height: 10,);
  /// height : 15.0
  static SizedBox get hard=>const SizedBox(height: 15,);
  /// height : 20.0
  static SizedBox get extreme=>const SizedBox(height: 20,);
  /// height : 25.0
  static SizedBox get titan=>const SizedBox(height: 25,);
}
