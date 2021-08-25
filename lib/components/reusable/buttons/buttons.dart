import 'package:e_shop/components/reusable/colors/color.dart';
import 'package:flutter/material.dart';

class DefaultLoginButton extends StatelessWidget {
  final Color? textColor;
  final VoidCallback onPressed;
  final String title;
  final double? width;
  final double? startAngel;
  final double? endAngle;

  const DefaultLoginButton({
    Key? key,
    this.startAngel,
    this.endAngle,
    this.textColor,
    required this.title,
    required this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: mixedColors(
        startAngle: startAngel,
        endAngle: endAngle,

      ),
      child: MaterialButton(
        child: Text(title,style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: textColor,fontWeight: FontWeight.bold
        ),),
        onPressed: onPressed,
      ),
    );
  }
}
