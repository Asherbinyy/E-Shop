
import 'package:e_shop/shared/components/builders/myConditional_builder.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/dialogue/swipe_to_delete_dialog.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:e_shop/shared/cubit/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '../../models/api/favourites/get_favourites.dart';
import '/modules/landing/landing_screen.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetFavouritesSuccessState && HomeCubit.get(context).showFavouritesDialogue) showDialog(context: context, builder: (context){
          return  SwipeToDeleteDialog();
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
        List<FavProductData>? favouritesProducts = cubit.getFavouritesModel?.data?.data;
        Widget _noItemsAdded () => Padding(
          padding: const EdgeInsets.all(50.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              LottieBuilder.asset(kEmptyListLottie,repeat: false,),
              YSpace.extreme,
              Center(child: Text('No Favourite Items .. try adding new ones',textAlign: TextAlign.center,)),
              ],
          ),
        );

        return MyConditionalBuilder(
          condition: favouritesProducts != null,
          builder:MyConditionalBuilder(
            condition: favouritesProducts != null && favouritesProducts.length>0,
            builder:  Padding(
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
                    height: height * 0.2,
                    child: _FavouriteItemCard(cubit,index, product,),
                  ),
                );},
            ),
          ),
            feedback: _noItemsAdded()
          ),
          feedback: Center(child: kLoadingFadingCircle),
        );
      },
    );
  }
}

class _FavouriteItemCard extends StatelessWidget {
  const _FavouriteItemCard(
      this.cubit,
      this.index,
      this.product,{

    Key? key,
  }) : super(key: key);
  final int index;
  final HomeCubit cubit;
  final ProductData? product;


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

  return  BlocConsumer<AppCubit,AppStates>(
    listener: (context,state){},
    builder: (context,state){
      bool isDark= AppCubit.get(context).isDark;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: productCardDecoration(isDark),
          child: MaterialButton(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            padding: EdgeInsets.zero,
            splashColor: Colors.white,
            // onPressed: () => navigateTo(context, ProductDescription(product)),
            onPressed: () => {},

            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomStart,
                    children: [
                      Stack(
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isDark ? Colors.black12 : Colors.black,
                              BlendMode.difference,
                            ),
                            child: Opacity(
                              opacity: isDark ? 0.8 : 1,
                              child: Hero(
                                tag: '${product?.id}',
                                child: Image.network(
                                  product?.image ?? kNoImageFound,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                  alignment: AlignmentDirectional.topCenter,
                                ),
                              ),
                            ),
                          ),
                          if (product?.discount != 0)
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 15.0),
                              child: RotationTransition(
                                turns: AlwaysStoppedAnimation(-30 / 360),
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.teal.shade800,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: FittedBox(
                                    child: Text(
                                      '${product?.discount} % OFF',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                // product info
                Expanded(
                  child: Container(
                    width: width,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color:
                      isDark ? kDarkSecondaryColor : kLightSecondaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '${product?.name}',
                          style: Theme.of(context).textTheme.bodyText2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          'by : E-Shop',
                          style: Theme.of(context).textTheme.caption,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Align(
                          alignment: AlignmentDirectional.bottomStart,
                          child: FittedBox(
                            child: product?.discount != 0?RichText(
                              text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                    fontWeight: FontWeight.bold),
                                text: 'EGP ${product?.price}  ',
                                children: [
                                  TextSpan(
                                    text: ' ${product?.oldPrice}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .overline
                                        ?.copyWith(
                                        decoration: TextDecoration
                                            .lineThrough,
                                        color: kLikeButtonColor),
                                  ),
                                ],
                              ),
                            ):Text('EGP ${product?.price}',style:Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                fontWeight: FontWeight.bold),),
                          ),
                        ),
                        //cart
                        FittedBox(
                          child: OutlinedButton(
                            onPressed: () {
                              cubit.changeCarts(product!.id!);
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: Size(width,height*0.1),
                              backgroundColor: cubit.carts?[product?.id]==true ?kPrimaryColor : null,
                            ),
                            child: cubit.carts?[product?.id]==true
                                ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                XSpace.normal,
                                Text('Added To Cart',style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white),),
                              ],
                            )
                                : Icon(
                              Icons.add_shopping_cart,
                              size: 40,

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
  }
}