import 'package:e_shop/layout/cubit/home_cubit.dart';
import 'package:e_shop/models/app/bottom_nav_model.dart';
import 'package:e_shop/modules/landing/landing_screen.dart';
import 'package:e_shop/shared/cubit/app_cubit.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final HomeCubit cubit;
  final AppCubit appCubit;
  final double height;
  const CustomBottomNavBar( this.cubit, this.appCubit,{Key? key,required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: BottomAppBar(
          elevation: 0.0,
          color: appCubit.isDark ? kDarkPrimaryColor : kLightPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: BottomNavModel.getList.length,
                // separatorBuilder: (context, index)=>SizedBox(width: 4,),
                itemBuilder: (context, index) {
                  var item = BottomNavModel.getList[index];
                  return BottomNavItem(item,cubit,index,isDark: appCubit.isDark,onPressed:()=> cubit.changeBottomNav(index),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {

  final BottomNavModel item ;
  final HomeCubit cubit  ;
  final int index  ;
  final VoidCallback? onPressed;
  final bool isDark ;
  const BottomNavItem(this.item, this.cubit,this.index,{Key? key,required this.isDark, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
      elevation: 0.0,
      color: isDark?kSecondaryColorDarker.withOpacity(0.01):kSecondaryColorDarker.withOpacity(0.01),/// delete
      minWidth: MediaQuery.of(context).size.width/4,
      padding: EdgeInsets.zero,
      onPressed: onPressed,///select
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Tooltip(
          message: '${item.label}',
          child: MyConditionalBuilder(
            condition:cubit.currentIndex==index, /// if selected
            builder: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
              decoration: BoxDecoration(
                color: kSecondaryColorDarker.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  FittedBox(child: Icon(item.icon,color: isDark?kLightPrimaryColor:Colors.white, size: 25)),
                  const SizedBox(width: 5),
                  FittedBox(child: Text('${item.label}',style: TextStyle(color: isDark?kLightPrimaryColor:Colors.white),)),
                ],
              ),
            ),
            feedback: FittedBox(
              child: Icon(
                item.icon,
                size: 30,
                color: Colors.grey[400],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

