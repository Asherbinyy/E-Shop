import 'dart:io';

import 'package:e_shop/shared/cubit/app_cubit.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;

  const AdaptiveSearchBar(this.controller,{Key? key, this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   late Widget widget ;
    switch (getOs()){
      // case 'ios':
      case 'android':
       widget =CupertinoSearchTextField(
         controller:controller ,
         style:Theme.of(context).textTheme.subtitle2 ,
         itemColor: AppCubit.get(context).isDark?Colors.white38:Colors.black38,
         placeholder: ' Search anything you want !',
         onSubmitted: onSubmitted,

       );
        break ;
      default : widget = Container(
        child: TextFormField(
          style:Theme.of(context).textTheme.subtitle2 ,
          controller: controller,
          // onFieldSubmitted: onSubmitted,
          decoration: InputDecoration(
            filled: true,
            hintText: ' Search anything you want !',
            hintStyle: TextStyle(color: AppCubit.get(context).isDark?Colors.white38:Colors.black38) ,
            fillColor: AppCubit.get(context).isDark?Colors.white10:Colors.black12,
            border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            suffix: TextButton(
              child: Text('cancel'.toUpperCase()),
              onPressed: (){},
            ),
          ),
        ),
      );
      break ;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: widget,
      ),
    );
  }
}