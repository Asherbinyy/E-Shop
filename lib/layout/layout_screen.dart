import '/shared/components/methods/operating_system_options.dart';
import '/shared/components/builders/myConditional_builder.dart';
import '/shared/components/builders/shop_shimmer_builder.dart';
import '/shared/components/methods/navigation.dart';
import '/shared/components/adaptive/adaptive_search_bar.dart';
import '/modules/search/search_screen.dart';
import '/models/app/bottom_nav.dart';
import '/shared/components/reusable/app_bar/primary_sliver_appbar.dart';
import '/shared/components/reusable/bottom_nav_bar/BottomNavItem.dart';
import '/shared/components/reusable/drawer/custom_drawer.dart';
import '/shared/cubit/app_cubit.dart';
import '/shared/cubit/app_state.dart';
import 'package:flutter/cupertino.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/// Reviewed
var _searchController = TextEditingController();

class LayoutScreen extends StatelessWidget {
  static String id = 'LayoutScreen';

  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        OperatingSystemOptions.showStatusBar();
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HomeCubit.get(context);
            var height = MediaQuery.of(context).size.height;

            return Scaffold(
              extendBodyBehindAppBar: true,
              endDrawer:const CustomDrawerScreen(),
              bottomNavigationBar:
                  CustomBottomNavBar(cubit,appCubit.isDark, height: height * 0.08),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: (){},
              //   backgroundColor: Colors.transparent,
              //   ///TODO Future Idea 1 : add to cart using this (Drag and Drop) .
              // ) ,
              body: MyConditionalBuilder(
                condition: cubit.tabBarData.length > 0 ,
                builder: DefaultTabController(
                  length: cubit.tabBarData.length,
                  initialIndex: 0,
                  child: NestedScrollView(
                    floatHeaderSlivers: true,
                    physics:const BouncingScrollPhysics(),
                    headerSliverBuilder: (context, value) => [
                       PrimarySliverAppBar( tabHeight: height * 0.04),
                      if(!cubit.hideSearchBar) SliverToBoxAdapter(
                        child: AdaptiveSearchBar(
                          _searchController,
                          onSubmitted: (_) {
                            cubit.searchProduct(_searchController.text);
                            navigateTo(context, SearchScreen(_searchController));
                          },
                        ),
                      ),
                    ],
                    body: BottomNavModel.getList[cubit.currentIndex].screen,
                  ),
                ),
                feedback:const ShopShimmerBuilder(),
              ),
            );
          },
        );
      },
    );
  }
}
