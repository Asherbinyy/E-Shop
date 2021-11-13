import 'package:flutter/material.dart';

class CustomSelectableText extends StatelessWidget {
  final String label;
  final Color? color;
  final double? fontSize;
  final bool isBold;
  final bool isUpperCase;
  final EdgeInsetsGeometry ? padding;
  final int ? maxLines;
  final double ? textHeight;
  final TextDecoration? decoration;
  final String ? fontFamily;


  const CustomSelectableText(
      this.label,
      {Key? key,
        this.color,
        this.fontSize,
        this.isBold = false,
        this.isUpperCase = false,
        this.padding,
        this.maxLines,
        this.decoration,
        this.textHeight=1.0,
        this.fontFamily,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SelectableText(
        isUpperCase ? label.toUpperCase() : label,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: isBold ? FontWeight.bold : null,
          decoration: decoration,
          height: textHeight ,
          fontFamily: fontFamily ?? '',
        ),
        maxLines: maxLines,
      ),
    );
  }
}