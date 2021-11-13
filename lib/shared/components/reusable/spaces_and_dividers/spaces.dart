import 'package:flutter/material.dart';

/// Creates Horizontal Spaces (X-Axis SizedBox)
class XSpace {
  XSpace._();
  /// width : 2.5
  static SizedBox get tiny => const SizedBox(
        width: 2.5,
      );

  /// width : 5.0
  static SizedBox get light => const SizedBox(
        width: 5,
      );

  /// width : 10.0
  static SizedBox get normal => const SizedBox(
        width: 10,
      );

  /// width : 15.0
  static SizedBox get hard => const SizedBox(
        width: 15,
      );

  /// width : 20.0
  static SizedBox get extreme => const SizedBox(
        width: 20,
      );

  /// width : 25.0
  static SizedBox get titan => const SizedBox(
        width: 25,
      );

  /// creates a Spacer (free space) in the Row between 2 children
  static Spacer get spacer => const Spacer();

}
/// Creates Vertical Spaces (Y-Axis SizedBox)
class YSpace {
  YSpace._();
  /// height : 2.5
  static SizedBox get tiny => const SizedBox(
        height: 2.5,
      );

  /// height : 5.0
  static SizedBox get light => const SizedBox(
        height: 5,
      );

  /// height : 10.0
  static SizedBox get normal => const SizedBox(
        height: 10,
      );

  /// height : 15.0
  static SizedBox get hard => const SizedBox(
        height: 15,
      );

  /// height : 20.0
  static SizedBox get extreme => const SizedBox(
        height: 20,
      );

  /// height : 25.0
  static SizedBox get titan => const SizedBox(
        height: 25,
      );
  static SizedBox get erinYeager => const SizedBox(
        height: 50,
      );

 /// creates a Spacer (free space) in the Columns between 2 children
  static Spacer get spacer => const Spacer();

}

