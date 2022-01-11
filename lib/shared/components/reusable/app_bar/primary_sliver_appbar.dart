import '../buttons/custom_icon_button.dart';
import '../../../../modules/cart/controller/cart_cubit.dart';
import '../../../../modules/cart/view/cart_imports.dart';
import '../../../../modules/layout/cubit/home_cubit.dart';
import '../../../../modules/layout/cubit/home_states.dart';
import '../../../../services/routing/navigation.dart';
import '../../../cubits/app_cubit/app_cubit.dart';
import '../../../../styles/constants/constants.dart';
import '/shared/components/reusable/tab_bar/tab_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class PrimarySliverAppBar extends StatelessWidget {
  final double tabHeight;
  final LayoutCubit cubit;
  const PrimarySliverAppBar(this.cubit, {Key? key, this.tabHeight = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appCubit = AppCubit.get(context);
    return SliverAppBar(
      snap: true,
      // pinned: cubits.isAppBarPinned ? true : false,
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
        _CartActionButton(cubit),
        //dark mode
        // _DarkModeButton(appCubit),
        // avatar
        _AvatarButton(cubit),
      ],
      bottom: cubit.isHome
          ? TabBar(
              key: key,
              // بيجيب الداتا مع الضغطة
              onTap: (index) {
                if (index != 0)
                  cubit.getCategoryProducts(
                      cubit.categoriesIDs['${cubit.tabBarData[index].label}']!);
              },
              isScrollable: true,
              physics: const BouncingScrollPhysics(),
              automaticIndicatorColorAdjustment: true,
              enableFeedback: true,
              indicator: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              tabs: cubit.tabBarData
                  .map((e) => TabItem(e.label, tabHeight: tabHeight))
                  .toList(),
            )
          : null,
      // backwardsCompatibility: false,
    );
  }
}

class _CartActionButton extends StatelessWidget {
  final LayoutCubit cubit;
  const _CartActionButton(this.cubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cartLength = cubit.getCartsModel?.data?.total;
      // print("Total length of Cart =>${cubit.getCartsModel?.data?.total}");
      bool? isInCart;
      cubit.carts!.forEach((key, value) {
        if (value == true)
          isInCart = true;
        else
          isInCart = false;
      });
      return Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Tooltip(
            message: 'cart'.tr(),
            child: IconButton(
              onPressed: () {
                cubit.getCarts();
                navigateTo(context, CartScreen());
              },
              icon: const Icon(FontAwesomeIcons.opencart),
            ),
          ),
          if ((isInCart == true || cartLength > 0))
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: const Icon(
                Icons.circle,
                color: kLikeButtonColor,
                size: 10,
              ),
            ),
        ],
      );
    });
  }
}

class _AvatarButton extends StatelessWidget {
  const _AvatarButton(
    this.cubit, {
    Key? key,
  }) : super(key: key);

  final LayoutCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Scaffold.of(context).openEndDrawer(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: cubit.profileModel?.data?.image != null
            ? CircleAvatar(
                backgroundImage:
                    NetworkImage('${cubit.profileModel?.data?.image}'))
            : const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(kDefaultImage),
              ),
      ),
    );
  }
}

class _DarkModeButton extends StatelessWidget {
  const _DarkModeButton(
    this.appCubit, {
    Key? key,
  }) : super(key: key);

  final AppCubit appCubit;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onPressed: () => appCubit.changeAppThemeModeSwitch(),
      icon: Icons.dark_mode,
    );
  }
}
