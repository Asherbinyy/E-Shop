import 'package:e_shop/modules/main_home/home/home_screen.dart';
import 'package:e_shop/shared/components/methods/methods.dart';
import 'package:e_shop/shared/components/adaptive/adaptive_search_bar.dart';
import 'package:e_shop/modules/search/search_screen.dart';
import '/models/app/bottom_nav_model.dart';
import '/modules/landing/landing_screen.dart';
import '/shared/components/reusable/app_bar/CustomSliverAppBar.dart';
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
final TextEditingController controller = TextEditingController();

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

            return Scaffold(
              extendBodyBehindAppBar: true,
              endDrawer: CustomDrawer(),
              bottomNavigationBar:
                  CustomBottomNavBar(cubit, appCubit, height: height * 0.08),
              floatingActionButton: FloatingActionButton(
                onPressed: (){},
                backgroundColor: Colors.transparent,
                ///TODO : add to cart using this (Drag and Drop) .
              ) ,
              body: MyConditionalBuilder(
                condition: cubit.tabBarData.length > 0,
                builder: DefaultTabController(
                  length: cubit.tabBarData.length,
                  initialIndex: 0,
                  child: NestedScrollView(
                    physics: BouncingScrollPhysics(),
                    headerSliverBuilder: (context, value) => [
                      if (cubit.isAppBarShown)
                        CustomSliverAppBar(
                            tabWidth: width * 0.29, tabHeight: height * 0.04),
                      SliverToBoxAdapter(
                        child: AdaptiveSearchBar(
                          controller,
                          onSubmitted: (value) {
                            navigateTo(context, SearchScreen(value));
                          },
                        ),
                      ),
                    ],
                    body: BottomNavModel.getList[cubit.currentIndex].screen,
                  ),
                ),
                feedback: kLoadingWanderingCubes,
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
