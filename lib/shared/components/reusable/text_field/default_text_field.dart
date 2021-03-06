import 'package:e_shop/styles/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class DefaultTextField extends StatelessWidget {
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final VoidCallback ? suffixOnChanged;
  final Function? prefixOnChanged;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Color primaryColor;
  final Color ? fillColor;
  final String label;
  final bool readOnly;
  final bool obscurePassword;
  final bool isDark;
  final int ? maxLength;
  final int ? minLines;
  final int ? maxLines;
  final bool isFilled;
  const DefaultTextField({
    Key? key,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.controller,
    this.suffixOnChanged,
    this.prefixOnChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.label = '',
    this.isFilled = false,
    this.primaryColor = kPrimaryColor,
    this.fillColor,
    this.obscurePassword = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.isDark = false,
    this.maxLength,
    this.maxLines =1,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLength: maxLength ,
      maxLines: maxLines,
      maxLengthEnforcement: obscurePassword ? null :MaxLengthEnforcement.truncateAfterCompositionEnds ,
      cursorColor: primaryColor,
      style: TextStyle(color: isDark? Colors.white:Colors.black54,fontWeight: FontWeight.w400),
      obscureText: obscurePassword,
      onTap: onTap,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      readOnly: readOnly,
      validator: validator,
      decoration: InputDecoration(

        filled: isFilled,
        fillColor: fillColor,
        suffixIcon: IconButton(
          icon: Icon(
            suffixIcon,
            color: isDark ? Colors.white : primaryColor,
          ),
          onPressed: suffixOnChanged,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: isDark ? Colors.white: primaryColor,
        ),
        // fillColor: Colors.black12,
        disabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: isDark ? Colors.white : primaryColor,),
        ),
        enabledBorder: UnderlineInputBorder(
           borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color:Colors.transparent),
        ),
        border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: isDark ? Colors.white : primaryColor,),
        ),
        focusedBorder:UnderlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: primaryColor,),
        ) ,
        labelText: label,
        labelStyle: TextStyle(
          color: isDark ? Colors.white : primaryColor,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
// * co
// ! sa











