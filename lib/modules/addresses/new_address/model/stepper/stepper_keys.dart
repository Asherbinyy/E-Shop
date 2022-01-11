import 'package:flutter/material.dart';

/// returns List of formKeys used in the Stepper Widget
///REVIEWED
class StepperFormKeys {
  StepperFormKeys._();
  static var step1 = GlobalKey<FormState>(debugLabel: 'step1');
  static var step2 = GlobalKey<FormState>(debugLabel: 'step2');
  static List<GlobalKey<FormState>> stepperKeys = [
    step1,
    step2,
  ];
}
