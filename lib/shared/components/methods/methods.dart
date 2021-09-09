import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

void navigateTo(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return widget;
    }),
  );
}

void navigateToAndFinish(BuildContext context, Widget widget,
    {bool routeIs = false}) {
  Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget),
    (route) => routeIs, // removes the last route if false
  );
}

//
// List <dynamic> shuffleList (List <dynamic> list){
//
//   list.shuffle();
//
//   return list;
// }
//


