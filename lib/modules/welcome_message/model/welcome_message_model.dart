import 'package:flutter/material.dart';

class WelcomeMessageModel {
  final String? message;
  final String? subMessage;
  final String? backgroundImage;
  /// The glowing shadow of the card borders
  final Color ? cardShadow;
 const WelcomeMessageModel(
    this.message,
    this.subMessage, {
    this.backgroundImage,
    this.cardShadow,
  });

}

