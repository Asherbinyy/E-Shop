import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:e_shop/shared/components/reusable/text/custom_text.dart';
import 'package:e_shop/styles/constants/constants.dart';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableListTile extends StatelessWidget {
  final String label;
  final IconData ? prefixIcon;
  final IconData  expandIcon;
  final IconData  collapseIcon;
  final Widget? child;
  final VoidCallback? onPressed;
  final Color? primaryColor;
  final Color? prefixIconColor;
  final double fontSize ;
  final double iconsSize ;
  final double ? iconPadding ;

  const ExpandableListTile(
      {Key? key,
        this.child,
        this.onPressed,
        required this.label,
         this.prefixIcon,
        this.primaryColor=kPrimaryColor,
        this.prefixIconColor=Colors.white,
        this.fontSize=12.0,
        this.iconsSize=14.0,
        this.iconPadding,
        this.expandIcon=Icons.keyboard_arrow_down,
        this.collapseIcon=Icons.keyboard_arrow_up,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      padding: const EdgeInsets.all(8.0),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
          iconPadding:iconPadding != null? EdgeInsets.all(iconPadding??0):null,
          expandIcon:expandIcon,
          collapseIcon:collapseIcon ,
          iconColor: primaryColor,
          iconSize: iconsSize,
        ),
        header: Row(
          children: [
          if (prefixIcon != null)  CircleAvatar(
              child: Icon(prefixIcon,color:prefixIconColor,),
              backgroundColor: primaryColor,
            ),
         if (prefixIcon != null) XSpace.extreme,
            Expanded(
              child: CustomText(
                label,isBold: true,
                color: primaryColor,fontSize: fontSize,
              ),
            ),
          ],
        ),
        collapsed: Visibility(
          visible: false,
          child: const CustomText(''),
        ),
        expanded: child ??const SizedBox(),
      ),
    );
  }
}
