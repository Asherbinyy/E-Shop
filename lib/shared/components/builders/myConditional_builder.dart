import 'package:flutter/material.dart';

class MyConditionalBuilder extends StatelessWidget {
  final bool condition;
  final Widget builder;
  final Widget? feedback;

  const MyConditionalBuilder(
      {Key? key, required this.condition, required this.builder, this.feedback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgetIs;
    if (feedback == null) {
      if (condition == true) {
        widgetIs = builder;
      }
    } else {
      if (condition == true) {
        widgetIs = builder;
      } else {
        widgetIs = feedback;
      }
    }
    return widgetIs;
  }
}
