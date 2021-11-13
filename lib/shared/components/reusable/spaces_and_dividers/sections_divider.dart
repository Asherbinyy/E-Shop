import 'package:e_shop/styles/constants/constants.dart';
import 'package:flutter/material.dart';

class SectionsDivider extends StatelessWidget {
  final bool isDark;
  /// h1:5 , h2:10 , h3:15, h4:20 ,h5:25 , h6:30 , h7:35 , h8:40 .. normal :based on it's child
  final SectionDividerStyle style;
  final Widget? child;
  const SectionsDivider(
      this.isDark, {
        Key? key,
        this.style = SectionDividerStyle.normal,
        this.child = const SizedBox(),
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _getDividerHeight(style),
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
double? _getDividerHeight(SectionDividerStyle style) {
  double? _height;
  switch (style) {
    case SectionDividerStyle.normal:
      _height = null;
      break;
    case SectionDividerStyle.h1:
      _height = 5;
      break;
    case SectionDividerStyle.h2:
      _height = 10;
      break;
    case SectionDividerStyle.h3:
      _height = 15;
      break;
    case SectionDividerStyle.h4:
      _height = 20;
      break;
    case SectionDividerStyle.h5:
      _height = 25;
      break;
    case SectionDividerStyle.h6:
      _height = 30;
      break;
    case SectionDividerStyle.h7:
      _height = 35;
      break;
    case SectionDividerStyle.h8:
      _height = 40;
  }
  return _height;
}


