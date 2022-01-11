import 'package:flutter/material.dart';

/// Creates a Divider with different styles : faded ,semi ,normal
class XDivider extends StatelessWidget {
  final double height;
  final Color? color;
  final double opacity;
  final double horizontalPadding;

  const XDivider._({
    Key? key,
    this.height = 1.0,
    this.color,
    this.opacity = 1.0,
    this.horizontalPadding = 0.0,
  }) : super(key: key);


  /// Normal Divider with opacity = 1
  factory XDivider.normal(
      {double height = 1.0,
        Color? color,
        double horizontalPadding = 0.0}) =>
      XDivider._(
        opacity: 1,
        height: height,
        color: color,
        horizontalPadding: horizontalPadding,
      );
  /// Divider with opacity = 0.5
  factory XDivider.semiFaded(
      {double height = 1.0,
        Color? color,
        double horizontalPadding = 0.0}) =>
      XDivider._(
          opacity: 0.5,
          height: height,
          color: color,
          horizontalPadding: horizontalPadding);
  /// Divider with opacity = 0.1
  factory XDivider.faded(
      {double height = 1.0,
        Color? color,
        double horizontalPadding = 0.0}) =>
      XDivider._(
          opacity: 0.1,
          height: 1.0,
          color: color,
          horizontalPadding: horizontalPadding);

  @override
  Widget build(BuildContext context) => _CustomDivider(
    color: color ?? Colors.grey[300],
    height: height,
    key: key,
    opacity: opacity,
    horizontalPadding: horizontalPadding,
  );
}

class _CustomDivider extends StatelessWidget {
  final double height;
  final Color? color;
  final double opacity;
  final double horizontalPadding;
  const _CustomDivider({
    Key? key,
    required this.height,
    this.color,
    required this.opacity,
    required this.horizontalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: double.infinity,
          height: height,
          color: color,
        ),
      ),
    );
  }
}


/// OLD Formula

// /// Creates a Divider with different styles : faded ,semi ,normal
// class XDivider {
//   XDivider._();
//
//   /// Divider with opacity = 0.1
//   static Widget faded({double height = 1.0}) => Opacity(
//       opacity: 0.1,
//       child: Container(
//         width: double.infinity,
//         height: height,
//         color: Colors.grey[300],
//       ));
//
//   /// Divider with opacity = 0.5
//   static Widget semiFaded({double height = 1.0}) => Opacity(
//       opacity: 0.5,
//       child: Container(
//         width: double.infinity,
//         height: height,
//         color: Colors.grey[300],
//       ));
//
//   /// Divider with opacity = 1 (no opacity)
//   static Widget normal({double height = 1.0}) => Opacity(
//       opacity: 1,
//       child: Container(
//         width: double.infinity,
//         height: height,
//         color: Colors.grey[300],
//       ));
//
//   /// Customizable Divider with default opacity = 1 (no opacity)
//   static Widget custom({double height = 1.0}) => Opacity(
//       opacity: 1,
//       child: Container(
//         width: double.infinity,
//         height: height,
//         color: Colors.grey[300],
//       ));
// }
