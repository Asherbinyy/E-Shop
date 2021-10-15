import 'package:flutter/material.dart';
///REVIEWED
/// returns List of controllers used in the Stepper Widget
class StepperControllers {
  StepperControllers._();
  static final TextEditingController name = TextEditingController();
  static final TextEditingController phone = TextEditingController();
  static final TextEditingController city = TextEditingController();
  static final TextEditingController details = TextEditingController();
  static final TextEditingController region = TextEditingController();
  static final TextEditingController notes = TextEditingController();
  static void clear() {
    name.clear();
    phone.clear();
    city.clear();
    details.clear();
    region.clear();
    notes.clear();
  }
}
