import 'package:e_shop/shared/components/methods/operating_system_options.dart';

import '/shared/cubit/app_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// Reviewed
class AdaptiveSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  const AdaptiveSearchBar(this.controller,{Key? key, this.onSubmitted}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   late Widget _builtWidget ;
    switch ( OperatingSystemOptions.getOs()){
      case 'android':
       _builtWidget =CupertinoSearchTextField(
         controller:controller ,
         style:Theme.of(context).textTheme.subtitle2 ,
         itemColor: AppCubit.get(context).isDark?Colors.white38:Colors.black38,
         placeholder: 'search_anything'.tr(),
         onSubmitted: onSubmitted,
       );
        break ;
      default : _builtWidget = Container(
       height: MediaQuery.of(context).size.height*0.045,
        child: TextFormField(
          style:Theme.of(context).textTheme.subtitle2 ,
          controller: controller,
          onFieldSubmitted: onSubmitted,
          // onFieldSubmitted: onSubmitted,
          decoration: InputDecoration(
            contentPadding:const EdgeInsets.symmetric(horizontal: 4.0),
            filled: true,
            hintText: 'search_anything'.tr(),
            hintStyle: TextStyle(color: AppCubit.get(context).isDark?Colors.white38:Colors.black38) ,
            fillColor: AppCubit.get(context).isDark?Colors.white10:Colors.black12,
            border:OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsetsDirectional.only(),
              child: Icon(Icons.search,color: Colors.grey,),
            ),
            suffix: TextButton(
              child: Text('clear'.tr().toUpperCase()),
              onPressed: ()=>controller.clear(),
            ),

          ),
        ),
      );
      break ;
    }
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8.0,end: 8.0,bottom: 8.0),
      child:  SafeArea(
        child: _builtWidget,
      ),
    );
  }
}
