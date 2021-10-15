import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

class XDivider {
  XDivider._();
  static Widget faded({double height = 1.0}) => Opacity(
      opacity: 0.1,
      child: Container(
        width: double.infinity,
        height: height,
        color: Colors.grey[300],
      ));
  static Widget semiFaded({double height = 1.0}) => Opacity(
      opacity: 0.5,
      child: Container(
        width: double.infinity,
        height: height,
        color: Colors.grey[300],
      ));
  static Widget normal({double height = 1.0}) => Opacity(
      opacity: 1,
      child: Container(
        width: double.infinity,
        height: height,
        color: Colors.grey[300],
      ));
}

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
}

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
}


double? getDividerHeight(SectionDividerStyle style) {
     double? _height ;
  switch (style) {
    case SectionDividerStyle.normal:
      _height= null;
      break;
    case SectionDividerStyle.h1:
      _height=5;
      break;
    case SectionDividerStyle.h2:
      _height=10;
      break;
    case SectionDividerStyle.h3:
      _height=15;
      break;
    case SectionDividerStyle.h4:
      _height=20;
      break;
    case SectionDividerStyle.h5:
      _height=25;
      break;
    case SectionDividerStyle.h6:
      _height=30;
      break;
    case SectionDividerStyle.h7:
      _height=35;
      break;
    case SectionDividerStyle.h8:
      _height=40;
  }
  return _height;
}
class SectionsDivider extends StatelessWidget {
  final bool isDark;
  /// h1:5 , h2:10 , h3:15, h4:20 ,h5:25 , h6:30 , h7:35 , h8:40 .. normal :based on it's child
  final SectionDividerStyle style;
  final Widget? child;
  const SectionsDivider(
      this.isDark,
      {
        Key? key,
      this.style = SectionDividerStyle.normal,
      this.child = const SizedBox(),
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:getDividerHeight(style),
      width: double.infinity,
      color: isDark
          ? kDarkSecondaryColor.withOpacity(0.4)
          : kLightSecondaryColor.withOpacity(0.5),
      child: style == SectionDividerStyle.normal ? child : null,
    );
  }
}
enum SectionDividerStyle {
  /// h1:5 , h2:10 , h3:15, h4:20 ,h5:25 , h6:30 , h7:35 , h8:40 .. normal :based on it's child
  normal,
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  h7,
  h8
}