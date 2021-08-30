import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/layout/cubit/home_cubit.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final double tabWidth ;
  final double tabHeight ;
  final AppCubit appCubit;
  final HomeCubit cubit ;
  const CustomSliverAppBar (this.appCubit, this.cubit, {Key? key,required this.tabWidth,required this.tabHeight}) : super(key: key);

   @override

  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: true,
      // stretch: true,
      leadingWidth: 100,
      expandedHeight: MediaQuery.of(context).size.height*0.145,
      // snap: false,
      // primary: true,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Image.asset(
            appCubit.isDark ? kLogoDark : kLogoLight),
      ),
      actions: [
        IconButton(
            onPressed: (){},
            icon: Icon(FontAwesomeIcons.bell),
        ),
        IconButton(
            onPressed: ()=>appCubit.changeThemeMode(),
            icon: Icon(Icons.dark_mode),
        ),
        GestureDetector(
          onTap: (){
            Scaffold.of(context).openEndDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(kMoon),
            ),
          ),
        ),
      ],
      // title: CupertinoSearchTextField(
      //   style:Theme.of(context).textTheme.subtitle2 ,
      //   itemColor: AppCubit.get(context).isDark?Colors.white38:Colors.black38,
      //   placeholder: ' Search anything you want !',
      // ),

      bottom:cubit.isHome? TabBar(
        isScrollable: true,
        physics: BouncingScrollPhysics(),
        automaticIndicatorColorAdjustment: true,
        enableFeedback: true,
        indicator: BoxDecoration(
          color: kPrimaryColorDarker,
          borderRadius: BorderRadius.circular(20),
        ),
        indicatorPadding:
        EdgeInsets.symmetric(horizontal: 2.0),
        tabs:
        List.generate(_tabs.length, (index) =>  Container(
          width: tabWidth,
          height: tabHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0)),
          child:
          Center(
              child: FittedBox(child: Text(_tabs[index]),
              ),
          ),
        ),
        ),
      ):null,
      backwardsCompatibility: false,
    );
}
}

List <String> _tabs = [
  'All',
  'New Products',
  'Categories',
];