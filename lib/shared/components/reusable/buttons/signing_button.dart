import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';

class SigningButton extends StatelessWidget {
  final Color? textColor;
  final VoidCallback onPressed;
  final String title;
  final double? width;
  final double? startAngel;
  final double? endAngle;

  const SigningButton({
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
      return Material(
        borderRadius: BorderRadius.circular(25.0),
        shadowColor: kSecondaryColorLight,
        elevation: 5.0,
        child: Container(
          width: width,
          decoration: signingButtonDecoration(
            startAngle: startAngel,
            endAngle: endAngle,
          ),
          child: MaterialButton(
            child: FittedBox(
              child: Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    // fontSize: 16.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onPressed: onPressed,
          ),
        ),
      );
  }
}

class OutlinedSigningButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double width;
  final double height;
  final Color color;
final bool isDark;
  const OutlinedSigningButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.width=40,
    this.height=40,
    this.isDark=false,
    this.color=kSecondaryColorLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style:OutlinedButton.styleFrom(
       shape: StadiumBorder(),
        fixedSize: Size(width, height),
        onSurface: Colors.red,
        side: BorderSide(color: color)
        // primary: Colors.white
      ) ,
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FittedBox(
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: isDark ? Colors.white :kSecondaryColor ,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      icon: Icon(FontAwesomeIcons.mask,color: isDark ? Colors.white :kSecondaryColor ,),
      onPressed: onPressed,
    );
  }
}

