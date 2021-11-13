import 'package:flutter/material.dart';

class MyConditionalBuilder extends StatelessWidget {
  final bool condition;
  final Widget onBuild;
  final Widget? onError;

  const MyConditionalBuilder(
      {Key? key, required this.condition, required this.onBuild, this.onError})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widgetIs;
    if (onError == null) {
      if (condition == true) {
        widgetIs = onBuild;
      }
    } else {
      if (condition == true) {
        widgetIs = onBuild;
      } else {
        widgetIs = onError;
      }
    }
    return widgetIs;
  }
}
