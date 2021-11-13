import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/shared/models/api/favourites/get_favourites.dart';
import 'package:e_shop/styles/constants/constants.dart';

import '/shared/components/builders/product_card.dart';
import '/shared/components/builders/myConditional_builder.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import '/shared/components/reusable/dialogue/swipe_to_delete_dialog.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
///REVIEWED
class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetFavouritesSuccessState && HomeCubit.get(context).showFavouritesDialogue) showDialog(context: context, builder: (context){
          return const SwipeToDeleteDialog();
        });
        if (state is ChangeFavouritesSuccessState){
          if (state.changeFavouritesModel?.status==true)
            DefaultDialogue.showSnackBar(
                context, '${state.changeFavouritesModel?.message}',
                labelColor: AppCubit.get(context).isDark ? Colors.white : Colors.black, dialogueStates: DialogueStates.NONE, isDark: AppCubit.get(context).isDark);
          else DefaultDialogue.showSnackBar(context, '${state.changeFavouritesModel?.message}', dialogueStates: DialogueStates.ERROR,);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
       var favouritesProducts = cubit.getFavouritesModel?.data?.data;
        return MyConditionalBuilder(
          condition: favouritesProducts != null,
          onBuild:MyConditionalBuilder(
            condition: favouritesProducts != null && favouritesProducts.length>0,
            onBuild:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: favouritesProducts?.length,
              itemBuilder: (context, index) {
                ProductData ? product = favouritesProducts?[index].product;
                double height = MediaQuery.of(context).size.height;
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red, child: Icon(Icons.delete_forever,color: Colors.white,),),
                  onDismissed: (dismissDirection){
                    favouritesProducts?.removeAt(index);
                    cubit.changeFavourites(product!.id!);
                  },
                  child: SizedBox(
                    height: height * 0.25,
                    child: ProductCard(
                      isFavouritesScreen: true,
                      isGrid: false,
                      name:'${product?.name}',
                      image: '${product?.image}',
                      id: product!.id!,
                      oldPrice: product.oldPrice,
                      seller: 'e_shop'.tr(),
                      price: product.price,
                      discount: product.discount!,
                    ),
                  ),
                );},
            ),
          ),
            onError:const _NoItemAdded(),
          ),
          onError:const Center(child: kLoadingFadingCircle),
        );
      },
    );
  }
}
class _NoItemAdded extends StatelessWidget {
  const _NoItemAdded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: ListView(
        physics:const BouncingScrollPhysics(),
        children: [
          LottieBuilder.asset(kEmptyListLottie,repeat: false,),
          YSpace.extreme,
          Center(child: Text('empty_fav'.tr(),textAlign: TextAlign.center,)),
        ],
      ),
    );
  }
}

// class _FavouriteItemCard extends StatelessWidget {
//   const _FavouriteItemCard(
//       this.cubits,
//       this.index,
//       this.product,{
//
//     Key? key,
//   }) : super(key: key);
//   final int index;
//   final HomeCubit cubits;
//   final ProductData? product;
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//   return  BlocConsumer<AppCubit,AppStates>(
//     listener: (context,state){},
//     builder: (context,state){
//       bool isDark= AppCubit.get(context).isDark;
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           decoration: productCardDecoration(isDark),
//           child: MaterialButton(
//             clipBehavior: Clip.antiAliasWithSaveLayer,
//             padding: EdgeInsets.zero,
//             splashColor: Colors.white,
//             // onPressed: () => navigateTo(context, ProductDescription(product)),
//             onPressed: () => {},
//
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Stack(
//                     alignment: AlignmentDirectional.bottomStart,
//                     children: [
//                       Stack(
//                         children: [
//                           ColorFiltered(
//                             colorFilter: ColorFilter.mode(
//                               isDark ? Colors.black12 : Colors.black,
//                               BlendMode.difference,
//                             ),
//                             child: Opacity(
//                               opacity: isDark ? 0.8 : 1,
//                               child: Hero(
//                                 tag: '${product?.id}',
//                                 child: Image.helpers(
//                                   product?.image ?? kNoImageFound,
//                                   fit: BoxFit.cover,
//                                   width: double.infinity,
//                                   height: double.infinity,
//                                   alignment: AlignmentDirectional.topCenter,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           if (product?.discount != 0)
//                             Padding(
//                               padding:
//                               const EdgeInsets.symmetric(vertical: 15.0),
//                               child: RotationTransition(
//                                 turns: AlwaysStoppedAnimation(-30 / 360),
//                                 child: Container(
//                                   padding: const EdgeInsets.all(8.0),
//                                   decoration: BoxDecoration(
//                                     color: Colors.teal.shade800,
//                                     borderRadius: BorderRadius.circular(20.0),
//                                   ),
//                                   child: FittedBox(
//                                     child: Text(
//                                       '${product?.discount} % OFF',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyText2
//                                           ?.copyWith(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 // product info
//                 Expanded(
//                   child: Container(
//                     width: width,
//                     padding: EdgeInsets.all(10.0),
//                     decoration: BoxDecoration(
//                       color:
//                       isDark ? kDarkSecondaryColor : kLightSecondaryColor,
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(10.0),
//                         bottomRight: Radius.circular(10.0),
//                       ),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           '${product?.name}',
//                           style: Theme.of(context).textTheme.bodyText2,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 2,
//                         ),
//                         Text(
//                           'by : E-Shop',
//                           style: Theme.of(context).textTheme.caption,
//                           overflow: TextOverflow.ellipsis,
//                           maxLines: 1,
//                         ),
//                         Align(
//                           alignment: AlignmentDirectional.bottomStart,
//                           child: FittedBox(
//                             child: product?.discount != 0?RichText(
//                               text: TextSpan(
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyText2
//                                     ?.copyWith(
//                                     fontWeight: FontWeight.bold),
//                                 text: 'EGP ${product?.price}  ',
//                                 children: [
//                                   TextSpan(
//                                     text: ' ${product?.oldPrice}',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .overline
//                                         ?.copyWith(
//                                         decoration: TextDecoration
//                                             .lineThrough,
//                                         color: kLikeButtonColor),
//                                   ),
//                                 ],
//                               ),
//                             ):Text('EGP ${product?.price}',style:Theme.of(context)
//                                 .textTheme
//                                 .bodyText2
//                                 ?.copyWith(
//                                 fontWeight: FontWeight.bold),),
//                           ),
//                         ),
//                         //cart
//                         FittedBox(
//                           child: OutlinedButton(
//                             onPressed: () {
//                               cubits.changeCarts(product!.id!);
//                             },
//                             style: OutlinedButton.styleFrom(
//                               minimumSize: Size(width,height*0.1),
//                               backgroundColor: cubits.carts?[product?.id]==true ?kPrimaryColor : null,
//                             ),
//                             child: cubits.carts?[product?.id]==true
//                                 ? Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.check,
//                                   color: Colors.white,
//                                   size: 40,
//                                 ),
//                                 XSpace.normal,
//                                 Text('Added To Cart',style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white),),
//                               ],
//                             )
//                                 : Icon(
//                               Icons.add_shopping_cart,
//                               size: 40,
//
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
//   }
// }
