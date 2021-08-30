import 'package:e_shop/models/app/bottom_nav_model.dart';
import 'package:e_shop/modules/Home/home/home_screen.dart';
import 'package:e_shop/modules/landing/landing_screen.dart';
import 'package:e_shop/shared/components/reusable/app_bar/CustomSliverAppBar.dart';
import 'package:e_shop/shared/components/reusable/bottom_nav_bar/BottomNavItem.dart';
import 'package:e_shop/shared/components/reusable/drawer/custom_drawer.dart';
import 'package:e_shop/shared/cubit/app_cubit.dart';
import 'package:e_shop/shared/cubit/app_state.dart';
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
            return Scaffold(
              extendBodyBehindAppBar: true,
              endDrawer: CustomDrawer(),
              bottomNavigationBar: CustomBottomNavBar(cubit,appCubit,height: height*0.08),
              body: DefaultTabController(
                length: 3,
                initialIndex: 0,
                child: NestedScrollView(
                  physics: BouncingScrollPhysics(),
                  // floatHeaderSlivers: true,
                  headerSliverBuilder: (context, value) {
                    return [
                    MyConditionalBuilder(
                      condition: (cubit.isAppBarShown), /// if we wanted to hide app bar
                      builder: CustomSliverAppBar(appCubit, cubit,tabWidth: width * 0.25,tabHeight: height*0.04,),
                     feedback: SliverToBoxAdapter(),
                    ),
                    ];
                  },
                  body:cubit.isHome?
                  TabBarView( ///this is all HomeScreen related
                      children: [
                    HomeScreen(),
                    Text('New Products Goes here !'),
                    Text('Categories here '),
                  ]) :
                  BottomNavModel.getList[cubit.currentIndex].screen,
                ),
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