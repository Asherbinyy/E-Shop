import 'package:e_shop/shared/components/builders/myConditional_builder.dart';
import 'package:e_shop/shared/components/builders/shop_shimmer_builder.dart';
import '/shared/components/methods/navigation.dart';
import '/shared/components/adaptive/adaptive_search_bar.dart';
import '/modules/search/search_screen.dart';
import '/models/app/bottom_nav.dart';
import '/modules/landing/landing_screen.dart';
import '/shared/components/reusable/app_bar/primary_sliver_appbar.dart';
import '/shared/components/reusable/bottom_nav_bar/BottomNavItem.dart';
import '/shared/components/reusable/drawer/custom_drawer.dart';
import '/shared/cubit/app_cubit.dart';
import '/shared/cubit/app_state.dart';
import 'package:flutter/cupertino.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutScreen extends StatelessWidget {
  static String id = 'LayoutScreen';

  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        showStatusBar();
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            HomeCubit cubit = HomeCubit.get(context);
            double height = MediaQuery.of(context).size.height;
            double width = MediaQuery.of(context).size.width;
             TextEditingController controller = TextEditingController();
            print( cubit.tabBarData);

            return Scaffold(
              extendBodyBehindAppBar: true,
              endDrawer: CustomDrawerScreen(),
              bottomNavigationBar:
                  CustomBottomNavBar(cubit,appCubit.isDark, height: height * 0.08),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: (){},
              //   backgroundColor: Colors.transparent,
              //   ///TODO : add to cart using this (Drag and Drop) .
              // ) ,
              body: MyConditionalBuilder(
                condition: cubit.tabBarData.length > 0,
                builder: DefaultTabController(
                  length: cubit.tabBarData.length,
                  initialIndex: 0,
                  child: NestedScrollView(
                    floatHeaderSlivers: true,
                    physics: BouncingScrollPhysics(),
                    headerSliverBuilder: (context, value) => [
                      PrimarySliverAppBar(tabWidth: width * 0.29, tabHeight: height * 0.04),
                      if(!cubit.hideSearchBar)SliverToBoxAdapter(
                        child: AdaptiveSearchBar(
                          controller,
                          onSubmitted: (_) {
                            cubit.searchProduct(controller.text);
                            navigateTo(context, SearchScreen(controller));
                          },
                        ),
                      ),
                    ],
                    body: BottomNavModel.getList[cubit.currentIndex].screen,
                  ),
                ),
                feedback: ShopShimmerBuilder(),
              ),
            );
          },
        );
      },
    );
  }
}
// /// To Make Persistent Widget
// class _PersistentHeader extends SliverPersistentHeaderDelegate {
//   final Widget widget;
//
//   _PersistentHeader({required this.widget});
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       width: double.infinity,
//       height: 56.0,
//       child: Card(
//         margin: EdgeInsets.all(0),
//         color: Colors.white,
//         elevation: 5.0,
//         child: Center(child: widget),
//       ),
//     );
//   }
//
//   @override
//   double get maxExtent => 56.0;
//
//   @override
//   double get minExtent => 56.0;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }
