import 'package:e_shop/layout/cubit/home_states.dart';
import 'package:e_shop/modules/cart/cart_screen.dart';
import 'package:e_shop/shared/components/methods/navigation.dart';
import 'package:e_shop/shared/components/reusable/tab_bar/tab_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/layout/cubit/home_cubit.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
class CustomSliverAppBar extends StatelessWidget {
  final double ? tabWidth ;
  final double tabHeight ;

  const CustomSliverAppBar ( {Key? key, this.tabWidth, this.tabHeight=30}) : super(key: key);

   @override

  Widget build(BuildContext context) {
     return BlocConsumer <HomeCubit,HomeStates>(
       listener: (context,state){},
       builder: (context,state){
         final HomeCubit cubit = HomeCubit.get(context);
         final AppCubit appCubit=AppCubit.get(context);

         bool ? isInCart;
         cubit.carts!.forEach((key, value) {
          if  (value==true ) isInCart=true;
         });

         return  SliverAppBar(
           pinned: false,
           // pinned: cubit.isAppBarPinned ? true : false,

           floating: true,
           // stretch: true,
           leadingWidth: 100,
           expandedHeight:cubit.isHome? MediaQuery.of(context).size.height*0.145:MediaQuery.of(context).size.height*0.05,
           // snap: false,
           // primary: true,
           leading: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8.0),
             child: Image.asset(
                 appCubit.isDark ? kLogoDark : kLogoLight),
           ),
           actions: [
             // cart screen
             Stack(
               alignment: AlignmentDirectional.topEnd,
               children: [
                 Tooltip(
                   message: 'cart',
                   child: IconButton(
                     onPressed: (){
                       cubit.getCarts();
                       navigateTo(context, CartScreen());
                     },
                     icon: Icon(FontAwesomeIcons.opencart),
                   ),
                 ),
               if (isInCart==true || cubit.getCartsModel?.data!.total! > 0)  Padding(
                   padding: const EdgeInsets.all(7.0),
                   child: Icon(Icons.circle,color: kLikeButtonColor,size: 10,),
                 )
               ],
             ),
             //dark mode
             IconButton(
               onPressed: ()=>appCubit.changeThemeMode(),
               icon: Icon(Icons.dark_mode),
             ),
             GestureDetector(
               onTap: ()=>Scaffold.of(context).openEndDrawer(),
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
                 child:cubit.profileModel?.data?.image!=null ?
                 CircleAvatar(backgroundImage: NetworkImage('${cubit.profileModel?.data?.image}')):
                /// To Hero here
                 CircleAvatar(radius: 25,backgroundImage: AssetImage(kDefaultImage),),
               ),
             ),

           ],
           bottom: cubit.isHome ?TabBar(
             // بيجيب الداتا مع الضغطة
             onTap: (index){
              if (index!=0) cubit.getCategoryProducts(cubit.categoriesIDs['${cubit.tabBarData[index].label}']!);
             },
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
             tabs: cubit.tabBarData.map((e) => TabItem(e.label, tabHeight: tabHeight )).toList(),
           ):null,
           // backwardsCompatibility: false,
         );
       },
     );
}
}

