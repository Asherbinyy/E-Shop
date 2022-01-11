import 'package:e_shop/modules/drawer/view/custom_drawer_imports.dart';
import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/search/view/search_imports.dart';
import 'package:e_shop/services/methods/operating_system_options.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_state.dart';
import 'package:e_shop/shared/models/app/bottom_nav.dart';
import '/shared/components/builders/myConditional_builder.dart';
import '/shared/components/builders/shop_shimmer_builder.dart';
import '/shared/components/adaptive/adaptive_search_bar.dart';
import '../../shared/components/reusable/app_bar/primary_sliver_appbar.dart';
import '/shared/components/reusable/bottom_nav_bar/BottomNavItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/home_states.dart';

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
        return BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = LayoutCubit.get(context);
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
                onBuild: DefaultTabController(
                  length: cubit.tabBarData.length,
                  initialIndex: 0,
                  child: NestedScrollView(
                    floatHeaderSlivers: true,
                    physics:const BouncingScrollPhysics(),
                    headerSliverBuilder: (context, value) => [
                       PrimarySliverAppBar( cubit,tabHeight: height * 0.04),
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
                onError:const ShopShimmerBuilder(),
              ),
            );
          },
        );
      },
    );
  }
}
