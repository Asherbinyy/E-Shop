import 'package:e_shop/styles/constants/constants.dart';
import 'package:flutter/material.dart';

class CurvedBottomSheetContainer extends StatelessWidget {
  final bool isDark;
  final Widget child;
  final EdgeInsets ? padding;
  const CurvedBottomSheetContainer({Key? key,this.isDark=false,required this.child,this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark?Color(0xff001414):Color(0xff757575),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: isDark?kDarkSecondaryColor:kLightSecondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0.0),
          child: child,
        ),
      ),
    );
  }
}
