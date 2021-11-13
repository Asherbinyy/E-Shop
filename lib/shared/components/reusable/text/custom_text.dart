import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String label;
  final Color? color;
  final double? fontSize;
  final bool isBold;
  final bool isUpperCase;
  final EdgeInsetsGeometry? padding;
  final bool isOverFlow;
  final int? maxLines;
  final double? textHeight;
  final TextDecoration? decoration;
  final String? fontFamily;
  final TextAlign? textAlign;

  const CustomText(
    this.label, {
    Key? key,
    this.color,
    this.fontSize,
    this.isBold = false,
    this.isOverFlow = false,
    this.isUpperCase = false,
    this.padding,
    this.maxLines,
    this.decoration,
    this.textHeight = 1.0,
    this.fontFamily,
        this.textAlign,
  }) : super(key: key);

  factory CustomText.subtitle(
    String label, {
    Key? key,
    Color color = Colors.grey,
    bool isUpperCase = false,
    bool isBold = false,
    double fontSize = 12.0,
    int maxLines = 1,
    bool isOverFlow = false,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
        TextAlign textAlign=TextAlign.right,
  }) => CustomText(
      label,
      key: key,
      isUpperCase: isUpperCase,
      color: color,
      fontSize: fontSize,
      isOverFlow: isOverFlow,
      isBold: isBold,
      padding: padding,
    textAlign: textAlign,
    maxLines: maxLines,
    );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        isUpperCase ? label.toUpperCase() : label,
        textScaleFactor: AppCubit.get(context).fontSizeValue,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : null,
          decoration: decoration,
          height: textHeight,
          fontFamily: fontFamily ?? fontFamily,
        ),
        textAlign: textAlign,
        overflow: isOverFlow ? TextOverflow.ellipsis : null,
        maxLines: maxLines,
      ),
    );
  }
}

// class _BuildSubTitleText extends StatelessWidget {
//  final String label;
//  final Color color;
//  final  bool isUpperCase;
//  final  bool isBold ;
//  final  double fontSize;
//  final  bool isOverFlow ;
//  final EdgeInsetsGeometry padding ;
//
//   const _BuildSubTitleText(this.label, {this.color = Colors.grey,
//       this.isUpperCase = false,
//       this.isBold= false,
//       this.fontSize = 19.0,
//       this.isOverFlow= false,
//       this.padding= EdgeInsets.zero,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return  CustomText(
//       label,
//       key: key,
//       isUpperCase: isUpperCase,
//       color: color,
//       fontSize: fontSize,
//       isOverFlow: isOverFlow,
//       isBold: isBold,
//       padding: padding,
//     );
//   }
// }
