import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';

Decoration? mixedColors({
   double? startAngle ,
   double? endAngle,
 }) => BoxDecoration(
  borderRadius: BorderRadius.circular(25.0) ,
      gradient: SweepGradient(
        colors: [
          kPrimaryColor,
          kSecondaryColor,
          kThirdColor,
        ],
        center: Alignment.topRight,
        startAngle: startAngle = 1,
        endAngle: endAngle = 6,
      ),
    );
