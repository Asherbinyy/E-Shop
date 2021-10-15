import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// REVIEWED
class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget{

  static PreferredSizeWidget signingAppBar (Color statusBarColor)=> AppBar (
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:statusBarColor,
      statusBarIconBrightness: Brightness.light,
    ),
  );  /// used in Login & Register Screens


  final List<Widget> ? actions ;
  final String ? title ;
  final Color ? backgroundColor ;
  final Color ? leadingIconColor ;
  final bool isFirst ;
  final SystemUiOverlayStyle ? systemOverlayStyle ;
   SecondaryAppBar({Key? key, this.actions,this.title,this.backgroundColor,this.systemOverlayStyle,this.isFirst = false,this.leadingIconColor}) ;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor:backgroundColor ,
        systemOverlayStyle: systemOverlayStyle ,
        title:  Text(title??''),
        // leading: isFirst?null:IconButton(
        //     onPressed: ()=>Navigator.pop(context), icon:Icon(getLocale(context) =='en' ? IconBroken.Arrow___Left_2 : IconBroken.Arrow___Right_2,color: leadingIconColor,)),
        actions: actions,
      );

  }


  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.copy(AppBar().preferredSize);
  // height is nearly 60
}
