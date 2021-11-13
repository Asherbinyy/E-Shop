import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ComingSoonBuilder extends StatelessWidget {
  final EdgeInsets ? innerPadding;
  final double opacity;
  final Widget child;
  const ComingSoonBuilder({Key? key,this.innerPadding,this.opacity=0.3,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: innerPadding?? const EdgeInsets.all(0.0),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Opacity(
            opacity: opacity,
            child: child,
          ),
          Center(
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText('coming_soon'.tr()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
