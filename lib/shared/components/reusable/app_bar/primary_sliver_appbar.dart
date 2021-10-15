import '/layout/cubit/home_states.dart';
import '/modules/cart/cart_screen.dart';
import '/shared/components/methods/navigation.dart';
import '/shared/components/reusable/tab_bar/tab_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/layout/cubit/home_cubit.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

/// reviewed
class PrimarySliverAppBar extends StatelessWidget {
  final double tabHeight;
  const PrimarySliverAppBar({Key? key, this.tabHeight = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final HomeCubit cubit = HomeCubit.get(context);
        final AppCubit appCubit = AppCubit.get(context);

        return Builder(builder: (context) {
          bool? isInCart;
          cubit.carts!.forEach((key, value) {
            if (value == true) isInCart = true;
          });

          return SliverAppBar(
            snap: true,
            // pinned: cubit.isAppBarPinned ? true : false,
            floating: true,
            // stretch: true,
            leadingWidth: 100,
            expandedHeight: cubit.isHome
                ? MediaQuery.of(context).size.height * 0.145
                : MediaQuery.of(context).size.height * 0.05,
            // snap: false,
            // primary: true,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(appCubit.isDark ? kLogoDark : kLogoLight),
            ),
            actions: [
              // cart screen
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Tooltip(
                    message: 'cart'.tr(),
                    child: IconButton(
                      onPressed: () {
                        cubit.getCarts();
                        navigateTo(context, const CartScreen());
                      },
                      icon: const Icon(FontAwesomeIcons.opencart),
                    ),
                  ),
                  if ((isInCart == true ||
                      cubit.getCartsModel?.data!.total! > 0))
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: const Icon(
                        Icons.circle,
                        color: kLikeButtonColor,
                        size: 10,
                      ),
                    ),
                ],
              ),
              //dark mode
              IconButton(
                onPressed: () => appCubit.changeAppThemeModeSwitch(),
                icon: const Icon(Icons.dark_mode),
              ),
              GestureDetector(
                onTap: () => Scaffold.of(context).openEndDrawer(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: cubit.profileModel?.data?.image != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${cubit.profileModel?.data?.image}'))
                      : const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(kDefaultImage),
                        ),
                ),
              ),
            ],
            bottom: cubit.isHome
                ? TabBar(
                    // بيجيب الداتا مع الضغطة
                    onTap: (index) {
                      if (index != 0)
                        cubit.getCategoryProducts(cubit.categoriesIDs[
                            '${cubit.tabBarData[index].label}']!);
                    },
                    isScrollable: true,
                    physics: const BouncingScrollPhysics(),
                    automaticIndicatorColorAdjustment: true,
                    enableFeedback: true,
                    indicator: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: 2.0),
                    tabs: cubit.tabBarData
                        .map((e) => TabItem(e.label, tabHeight: tabHeight))
                        .toList(),
                  )
                : null,
            // backwardsCompatibility: false,
          );
        });
      },
    );
  }
}
