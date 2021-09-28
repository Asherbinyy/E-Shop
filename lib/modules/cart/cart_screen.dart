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
                return SwipeToDeleteDialog();
              });
        if (state is ChangeCartSuccessState) {
          if (state.changeCartModel?.status == true)
            DefaultDialogue.showSnackBar(
                context, '${state.changeCartModel?.message}',
                labelColor:
                    AppCubit.get(context).isDark ? Colors.white : Colors.black,
                dialogueStates: DialogueStates.NONE,
                isDark: AppCubit.get(context).isDark);
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
              context, 'Something went wrong , please try again later',
              dialogueStates: DialogueStates.ERROR);
        if (state is UpdateCartSuccessState) if (!state
            .updateCartModel!.status!)
          DefaultDialogue.showSnackBar(context, state.updateCartModel!.message!,
              dialogueStates: DialogueStates.ERROR);
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        List<CartItems>? carts = cubit.getCartsModel?.data?.cartItems;
        double height = MediaQuery.of(context).size.height;
        double width = MediaQuery.of(context).size.width;

        return Scaffold(
          persistentFooterButtons: [
            cubit.getCartsModel?.data?.total != null
                ? _FooterWidgets(cubit)
                : const SizedBox()
          ],
          appBar: SecondaryAppBar(title: 'Cart',actions: [
                TextButton.icon(
                    icon : Icon(cubit.isExpandedCarts?FontAwesomeIcons.compressAlt:Icons.expand),
                    label: Text(cubit.isExpandedCarts?'Collapse All':'Expand All'),
                    onPressed: ()=>cubit.toggleExpandedCarts()),
              ]),
          body: MyConditionalBuilder(
            condition: carts != null,
            builder: MyConditionalBuilder(
                condition: carts != null && carts.length > 0,
                builder: _ProductBuilder(cubit, carts, showSpinner),
                feedback: _NoItemsAdded()),
            feedback: Center(child: kLoadingFadingCircle),
          ),
        );
      },
    );
  }
}
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: TextButton.icon(
// onPressed: () {},
// icon: Icon(Icons.clear_all),
// label: Text('Clear all'.toUpperCase()),
// ),
// )

//
// class _CartItemCard extends StatelessWidget {
//   const _CartItemCard(
//     this.cubit,
//     this.cart, {
//     Key? key,
//   }) : super(key: key);
//
//   final HomeCubit cubit;
//   final CartItems? cart;
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         bool isDark = AppCubit.get(context).isDark;
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             decoration: productCardDecoration(isDark),
//             child: MaterialButton(
//               clipBehavior: Clip.antiAliasWithSaveLayer,
//               padding: EdgeInsets.zero,
//               splashColor: Colors.white,
//               onPressed: () {
//                 cubit.getProductDetails(cart!.product!.id!);
//                 navigateTo(context, ProductDetailsScreen(cart!.product!.id!));
//               },
//               // onPressed: () => {},
//
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Stack(
//                       alignment: AlignmentDirectional.bottomStart,
//                       children: [
//                         Stack(
//                           children: [
//                             ColorFiltered(
//                               colorFilter: ColorFilter.mode(
//                                 isDark ? Colors.black12 : Colors.black,
//                                 BlendMode.difference,
//                               ),
//                               child: Opacity(
//                                 opacity: isDark ? 0.8 : 1,
//                                 child: Hero(
//                                   tag: '${cart?.product?.id}',
//                                   child: Image.network(
//                                     cart?.product?.image ?? kNoImageFound,
//                                     fit: BoxFit.cover,
//                                     width: double.infinity,
//                                     height: double.infinity,
//                                     alignment: AlignmentDirectional.topCenter,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             if (cart?.product?.discount != 0)
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 15.0),
//                                 child: RotationTransition(
//                                   turns: AlwaysStoppedAnimation(-30 / 360),
//                                   child: Container(
//                                     padding: const EdgeInsets.all(8.0),
//                                     decoration: BoxDecoration(
//                                       color: Colors.teal.shade800,
//                                       borderRadius: BorderRadius.circular(20.0),
//                                     ),
//                                     child: FittedBox(
//                                       child: Text(
//                                         '${cart?.product?.discount} % OFF',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyText2
//                                             ?.copyWith(
//                                               color: Colors.white,
//                                             ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             InkWell(
//                               onTap: () =>
//                                   cubit.changeFavourites(cart!.product!.id!),
//                               child: Padding(
//                                 padding: const EdgeInsetsDirectional.only(
//                                     start: 5.0, bottom: 2.0),
//                                 child: Container(
//                                   padding: const EdgeInsets.all(8.0),
//                                   decoration: BoxDecoration(
//                                     color: isDark
//                                         ? kDarkPrimaryColor
//                                         : kLightSecondaryColor,
//                                     borderRadius: BorderRadius.circular(20.0),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         blurRadius: 7,
//                                         offset: Offset(0, 0),
//                                         spreadRadius: 0.5,
//                                         color: Colors.black.withOpacity(0.4),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Icon(
//                                     (cubit.favourites?[cart?.product?.id] ==
//                                             true)
//                                         ? Icons.favorite
//                                         : Icons.favorite_outline,
//                                     color:
//                                         (cubit.favourites?[cart?.product?.id] ==
//                                                 true)
//                                             ? kLikeButtonColor
//                                             : (isDark
//                                                 ? kLightPrimaryColor
//                                                 : kDarkPrimaryColor),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Spacer(),
//                             // amount
//                             Padding(
//                               padding: const EdgeInsetsDirectional.only(
//                                   end: 5.0, bottom: 2.0),
//                               child: Tooltip(
//                                 message: 'amount : ${cart?.quantity ?? ''}',
//                                 child: Container(
//                                   padding: const EdgeInsets.all(8.0),
//                                   decoration: BoxDecoration(
//                                     color: isDark
//                                         ? kDarkPrimaryColor
//                                         : kLightSecondaryColor,
//                                     borderRadius: BorderRadius.circular(5.0),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         blurRadius: 7,
//                                         offset: Offset(0, 0),
//                                         spreadRadius: 0.5,
//                                         color: Colors.black.withOpacity(0.4),
//                                       ),
//                                     ],
//                                   ),
//                                   child: cart?.quantity != 0
//                                       ? Row(
//                                           children: [
//                                             Text('x',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .subtitle2),
//                                             Text('${cart?.quantity}',
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .subtitle1),
//                                           ],
//                                         )
//                                       : null,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   // product info
//                   Expanded(
//                     child: Container(
//                       width: width,
//                       padding: EdgeInsets.all(10.0),
//                       decoration: BoxDecoration(
//                         color:
//                             isDark ? kDarkSecondaryColor : kLightSecondaryColor,
//                         borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(10.0),
//                           bottomRight: Radius.circular(10.0),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '${cart?.product?.name}',
//                             style: Theme.of(context).textTheme.bodyText2,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 2,
//                           ),
//                           Text(
//                             'by : E-Shop',
//                             style: Theme.of(context).textTheme.caption,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                           ),
//                           Align(
//                             alignment: AlignmentDirectional.bottomStart,
//                             child: FittedBox(
//                               child: cart?.product?.discount != 0
//                                   ? RichText(
//                                       text: TextSpan(
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyText2
//                                             ?.copyWith(
//                                                 fontWeight: FontWeight.bold),
//                                         text: 'EGP ${cart?.product?.price}  ',
//                                         children: [
//                                           TextSpan(
//                                             text: ' ${cart?.product?.oldPrice}',
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .overline
//                                                 ?.copyWith(
//                                                     decoration: TextDecoration
//                                                         .lineThrough,
//                                                     color: kLikeButtonColor),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   : Text(
//                                       'EGP ${cart?.product?.price}',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyText2
//                                           ?.copyWith(
//                                               fontWeight: FontWeight.bold),
//                                     ),
//                             ),
//                           ),
//                           //Amount
//                           Align(
//                             alignment: AlignmentDirectional.bottomEnd,
//                             child: Column(
//                               children: [
//                                 Text(
//                                   'Amount ',
//                                   style: Theme.of(context).textTheme.caption,
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 1,
//                                 ),
//                                 YSpace.normal,
//                                 Container(
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.04,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                     border: Border.all(
//                                         color: AppCubit.get(context).isDark
//                                             ? kThirdColor.withOpacity(0.5)
//                                             : kThirdColor.withOpacity(0.2)),
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       MaterialButton(
//                                         padding: EdgeInsets.zero,
//                                         minWidth: 10,
//                                         onPressed: () {},
//                                         child: Icon(
//                                           Icons.arrow_left_rounded,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       Text(
//                                         '${cart?.quantity} ',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .subtitle2,
//                                         overflow: TextOverflow.ellipsis,
//                                         maxLines: 1,
//                                       ),
//                                       MaterialButton(
//                                         padding: EdgeInsets.zero,
//                                         minWidth: 0.0,
//                                         onPressed: () {},
//                                         child: Icon(
//                                           Icons.arrow_right_rounded,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class _FooterWidgets extends StatelessWidget {
  final HomeCubit cubit;
  const _FooterWidgets(this.cubit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: Text(
                'Total :  ${cubit.getCartsModel?.data?.total?.toStringAsFixed(1)} L.E'
                    .toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        XSpace.normal,
        TextButton(
          style: OutlinedButton.styleFrom(onSurface: Colors.red),
          child: Text('Check Out'.toUpperCase()),
          onPressed: () => {},
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
        physics: BouncingScrollPhysics(),
        children: [
          LottieBuilder.asset(
            kEmptyCartLottie,
            repeat: false,
          ),
          YSpace.extreme,
          Center(
              child: Text(
            'No Items In Cart .. Try Adding New Ones ..',
            textAlign: TextAlign.center,
          )),
        ],
      ),
    );
  }
}

class _ProductBuilder extends StatelessWidget {
  final HomeCubit cubit;
  final List<CartItems>? carts;
  final bool showSpinner;
  final bool  isAllExpanded;
  const _ProductBuilder(
    this.cubit,
    this.carts,
    this.showSpinner, {
        this.isAllExpanded=true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Builder(builder: (context) {
      return Stack(
        children: [
          Opacity(
            opacity: showSpinner ? 0.3 : 1,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: false,
              itemCount: carts?.length,
              itemBuilder: (context, index) {
                CartItems? cart = carts?[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    child: Icon(
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
                        collapsedBackgroundColor: AppCubit.get(context).isDark?kDarkSecondaryColor:kLightSecondaryColor,
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
                        // subtitle: Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 8.0, vertical: 5.0),
                        //   child: Text(
                        //     '${cart.product?.price} L.E ',
                        //     style: TextStyle(color: kSecondaryColorDarker),
                        //   ),
                        // ),
                        children: [
                          SizedBox(
                            height: height * 0.25,
                            child: ProductCard(
                              isCartScreen: true,
                              isGrid: false,
                              name: cart.product!.name!,
                              quantity: cart.quantity,
                              // quantity: cubit.cartAmount[cart.id],
                              seller: 'E-Shop',
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
          if (showSpinner)
            Center(
              child: kLoadingFadingCircle,
            ),
        ],
      );
    });
  }
}
