import 'package:e_shop/styles/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
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
  final TextStyle ? labelStyle ;
  final String hintText;
  final String ? errorMessage;
  final FormFieldSetter<String>? onSaved;

  final bool ? enabled;
  final bool readOnly;
  final bool obscurePassword;
  final bool isDark;
  final int ? maxLength;
  final int ? minLines;
  final int ? maxLines;
  final bool isFilled;
  const CustomTextFormField({
    Key? key,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onSaved,
    this.onTap,
    this.controller,
    this.suffixOnChanged,
    this.prefixOnChanged,
    this.suffixIcon,
    this.prefixIcon,
    this.label = '',
    this.hintText = '',
    this.errorMessage,
    this.isFilled = false,
    this.primaryColor = kPrimaryColor,
    this.fillColor,
    this.obscurePassword = false,
    this.enabled,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.isDark = false,
    this.maxLength,
    this.maxLines =1,
    this.minLines, this.labelStyle,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}
class _CustomTextFormFieldState extends State<CustomTextFormField> {
 late FocusNode _focusNode ;

  @override
  void initState() {
    _focusNode = FocusNode();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _focusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      enabled: widget.enabled,
      minLines: widget.minLines,
      maxLength: widget.maxLength ,
      maxLines: widget.maxLines,
      maxLengthEnforcement: widget.obscurePassword ? null :MaxLengthEnforcement.truncateAfterCompositionEnds ,
      cursorColor: widget.primaryColor,
      style: TextStyle(
          color: widget.isDark?
          Colors.white:Colors.black87,
          fontWeight: FontWeight.w400,),
      obscureText: widget.obscurePassword,
      onTap: widget.onTap,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      onSaved:widget.onSaved,
      onFieldSubmitted: widget.onSubmitted,
      readOnly: widget.readOnly,
      validator: widget.validator?? (value){
        if (value!.isEmpty) {
         return widget.errorMessage ?? 'Empty Field';
        }
        else {
          return null;
        }
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        filled: widget.isFilled,
        fillColor: widget.fillColor,
        suffixIcon:  widget.suffixIcon!=null?IconButton(
          icon: Icon(
            widget.suffixIcon,
            color: widget.isDark ? Colors.white : widget.primaryColor,
          ),
          onPressed: widget.suffixOnChanged,
        ):null,
        prefixIcon: widget.prefixIcon!=null? Icon(
          widget.prefixIcon,
          color: widget.isDark ? Colors.white: widget.primaryColor,
        ):null,
        // fillColor: Colors.black12,
        disabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: widget.isDark ? Colors.white : widget.primaryColor,),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide:  const BorderSide(color:Colors.grey,width: 0.5),
        ),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: widget.isDark ? Colors.white : widget.primaryColor,),
        ),
        focusedBorder:UnderlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide:BorderSide(color:widget.primaryColor,width: 2),
        ) ,
        labelText: widget.label,
        labelStyle:widget.labelStyle?? const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
