import 'package:flutter/material.dart';

void navigateTo(BuildContext context, Widget widget) =>
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return widget;
      }),
    );

void navigateToAndFinish(BuildContext context, Widget widget,
        {bool routeIs = false}) =>
    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => widget),
      (route) => routeIs, // removes the last route if false
    );

void navigateBack(BuildContext context) => Navigator.pop(context);
