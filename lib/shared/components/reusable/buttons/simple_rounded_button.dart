import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';

class SimpleRoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color labelColor;
  final Color color;
  final bool isUpperCase;
  final bool isDisabled ;

  const SimpleRoundedButton({Key? key, this.onPressed, this.label='', this.isUpperCase=true, this.labelColor =Colors.white, this.color=kSecondaryColor, this.isDisabled=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisabled,
      child: MaterialButton(
        onPressed:()=> onPressed!(),
        padding: EdgeInsets.zero,
        elevation: 0.0,
        color:  isDisabled?Colors.black12:color,
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
          child: Text(label.toUpperCase(),style: TextStyle(color: labelColor),),),
      ),
    );
  }
}