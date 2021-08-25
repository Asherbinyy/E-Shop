import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final bool? isPrimary ;
  final Color? cursorColor;
  final Color? iconShadowColor;
  final Color? formFieldShadowColor;
  final Color? textColor;
  final Color? suffixIconColor;
  final Color? prefixIconColor;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final VoidCallback? suffixPressed;

  const DefaultTextField({
    this.prefixIconColor,
    this.prefixIcon,
    this.textColor = Colors.black54,
    this.suffixIconColor = Colors.black54,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.labelText,
    this.keyboardType,
    this.controller,
    this.onFieldSubmitted,
    this.suffixPressed,
    this.formFieldShadowColor,
    this.iconShadowColor,
    this.cursorColor,
    this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Material(
            color: Colors.white,
            elevation: 7.0,
            shadowColor: formFieldShadowColor,
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 12.5,
              width: MediaQuery.of(context).size.width / 1.4,
              child: TextFormField(
                controller: controller,
                validator: validator,
                cursorColor: cursorColor,
                obscureText: obscureText,
                decoration: InputDecoration(
                    fillColor: Colors.red,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(25.0)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isPrimary == true ? kPrimaryColor.withRed(1): kSecondaryColor.withRed(1),
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hoverColor: Colors.red,
                    prefixIcon: Icon(null),
                    suffixIcon: IconButton(
                        icon: Icon(suffixIcon),
                        color: suffixIconColor,
                        onPressed: suffixPressed),
                    labelStyle: TextStyle(
                      color: textColor,
                    ),
                    labelText: labelText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    )),
                style: Theme.of(context).textTheme.button!.copyWith(),
                keyboardType: keyboardType,
                onFieldSubmitted: onFieldSubmitted,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
        Material(
          color: Colors.white,
          elevation: 12.0,
          shadowColor: iconShadowColor,
          borderRadius: BorderRadius.circular(50.0),
          child: CircleAvatar(
            child: Icon(
              prefixIcon,
              color: prefixIconColor,
            ),
            radius: 27.0,
            backgroundColor: Colors.white,
            // backgroundColor: kColor1,
          ),
        ),
      ],
    );
  }
}
