import '/modules/order/order_screen.dart';
import '/shared/components/methods/navigation.dart';
import '../../models/api/carts/get_carts.dart';
import '../../shared/components/builders/myConditional_builder.dart';
import '../../shared/components/builders/product_card.dart';
import '../../shared/components/reusable/app_bar/secondary_app_bar.dart';
import '../../shared/components/reusable/dialogue/default_dialogue.dart';
import '../../shared/components/reusable/dialogue/swipe_to_delete_dialog.dart';
import '../../shared/components/reusable/spaces/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
/// REVIEWED
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showSpinner = false;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetCartSuccessState &&
            HomeCubit.get(context).showCartsDialogue)
          showDialog(
              context: context,
              builder: (context) {
                return const SwipeToDeleteDialog();
              });
        if (state is ChangeCartSuccessState) {
          if (state.changeCartModel?.status == true)
            DefaultDialogue.showSnackBar(
              context,
              '${state.changeCartModel?.message}',
              labelColor:
                  AppCubit.get(context).isDark ? Colors.white : Colors.black,
              dialogueStates: DialogueStates.NONE,
              isDark: AppCubit.get(context).isDark,
            );
          else
            DefaultDialogue.showSnackBar(
              context,
              '${state.changeCartModel?.message}',
              dialogueStates: DialogueStates.ERROR,
            );
        }

        if (state is UpdateCartLoadingState)
          showSpinner = true;
        else
          showSpinner = false;
        if (state is UpdateCartErrorState)
          DefaultDialogue.showSnackBar(
            context,
            'error_try_again'.tr(),
            dialogueStates: DialogueStates.ERROR,
          );
        if (state is UpdateCartSuccessState) if (!state
            .updateCartModel!.status!)
          DefaultDialogue.showSnackBar(context, state.updateCartModel!.message!,
              dialogueStates: DialogueStates.ERROR);
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        var carts = cubit.getCartsModel?.data?.cartItems;

        return Scaffold(
          persistentFooterButtons: [
            cubit.getCartsModel?.data?.total != null
                ? _FooterWidgets(cubit)
                : const SizedBox()
          ],
          appBar: SecondaryAppBar(
              title: 'cart'.tr(), actions: [
            TextButton.icon(
                icon: Icon(
                    cubit.isExpandedCarts
                    ? FontAwesomeIcons.compressAlt
                    : Icons.expand,
                ),
                label:
                    Text(cubit.isExpandedCarts ? 'collapse_all'.tr() : 'expand_all'.tr()),
                onPressed: () => cubit.toggleExpandedCarts()),
          ]),
          body: MyConditionalBuilder(
            condition: carts != null,
            builder: MyConditionalBuilder(
                condition: carts != null && carts.length > 0,
                builder: _ProductBuilder(cubit, carts, showSpinner),
                feedback:const _NoItemsAdded()),
            feedback:const Center(child: kLoadingFadingCircle),
          ),
        );
      },
    );
  }
}


class _FooterWidgets extends StatelessWidget {
  final HomeCubit cubit;
  const _FooterWidgets(this.cubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: Text(
                'total'.tr()+' ${cubit.getCartsModel?.data?.total?.toStringAsFixed(1)} L.E'
                    .toUpperCase(),
                style:const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        XSpace.normal,
        TextButton(
          style: OutlinedButton.styleFrom(onSurface: Colors.red),
          child: Hero(
            tag: 'OrderScreen',
              child: Text('make_order'.tr().toUpperCase())),
          onPressed: () => navigateTo(context,const OrderScreen()),
        ),
      ],
    );
  }
}

class _NoItemsAdded extends StatelessWidget {
  const _NoItemsAdded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: ListView(
        physics:const BouncingScrollPhysics(),
        children: [
          LottieBuilder.asset(
            kEmptyCartLottie,
            repeat: false,
          ),
          YSpace.extreme,
          Center(
              child: Text(
            'empty_cart'.tr(),
            textAlign: TextAlign.center,
          ),
          ),
        ],
      ),
    );
  }
}

class _ProductBuilder extends StatelessWidget {
  final HomeCubit cubit;
  final List<CartItems>? carts;
  final bool showSpinner;
  final bool isAllExpanded;
  const _ProductBuilder(
    this.cubit,
    this.carts,
    this.showSpinner, {
    this.isAllExpanded = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Builder(
        builder: (context) {
      return Stack(
        children: [
          Opacity(
            opacity: showSpinner ? 0.3 : 1,
            child: ListView.builder(
              physics:const BouncingScrollPhysics(),
              shrinkWrap: false,
              itemCount: carts?.length,
              itemBuilder: (context, index) {
                CartItems? cart = carts?[index];
                return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      child:const Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (dismissDirection) {
                      carts?.removeAt(index);
                      cubit.changeCarts(cart!.product!.id!);
                      cubit.getCarts();
                    },
                    child: ExpansionTile(
                      collapsedIconColor: kPrimaryColor,
                      initiallyExpanded: cubit.isExpandedCarts,
                      collapsedBackgroundColor: AppCubit.get(context).isDark
                          ? kDarkSecondaryColor
                          : kLightSecondaryColor,
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(cart!.product!.name!,
                                style: Theme.of(context).textTheme.bodyText2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text('( x ${cart.quantity} )',
                              style: Theme.of(context).textTheme.caption,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        child: Text(
                          "${cart.product?.price} "+"egyptian_pound".tr()+" ( "+"per_piece".tr()+" )",
                          style: const TextStyle(color: kSecondaryColor),
                        ),
                      ),
                      children: [
                        SizedBox(
                          height: height * 0.25,
                          child: ProductCard(
                            isCartScreen: true,
                            isGrid: false,
                            name: cart.product!.name!,
                            quantity: cart.quantity,
                            // quantity: cubit.cartAmount[cart.id],
                            seller: 'e_shop'.tr(),
                            image: cart.product!.image!,
                            price: cart.product!.price!,
                            id: cart.product!.id!,
                            cartId: cart.id,
                            oldPrice: cart.product!.oldPrice!,
                            discount: cart.product!.discount!,
                          ),
                        ),
                      ],
                    ));
              },
            ),
          ),
          if (showSpinner)const Center(
              child: kLoadingFadingCircle,
            ),
        ],
      );
    });
  }
}
