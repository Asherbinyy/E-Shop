import 'package:e_shop/layout/layout_screen.dart';
import 'package:e_shop/modules/search/search_screen.dart';
import 'package:e_shop/shared/components/adaptive/adaptive_search_bar.dart';
import 'package:e_shop/shared/components/methods/navigation.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:e_shop/shared/cubit/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:lottie/lottie.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '/models/api/get_favourites_model.dart';
import '/modules/landing/landing_screen.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is GetFavouritesSuccessState && HomeCubit.get(context).showFavouritesDialogue) showDialog(context: context, builder: (context){
          return  Dialog(
            backgroundColor: AppCubit.get(context).isDark?kDarkSecondaryColor:kLightThirdColor,
            child:  SizedBox(
              height: MediaQuery.of(context).size.height*0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(kSwipeLeftLottie,reverse: true,fit: BoxFit.fitWidth,width: 150,),
                  Text('swipe to delete Items',style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white)),
                ],
              ),
            ),
          );
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
        List<FavProductData>? favourites = cubit.getFavouritesModel?.data?.data;
        Widget _noItemsAdded () => Padding(
          padding: const EdgeInsets.all(50.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              LottieBuilder.asset(kEmptyCartLottie,repeat: false,),
              YSpace.extreme,
              Center(
                  child: Text('No Favourite Items .. Try adding new ones ..',textAlign: TextAlign.center,)),
            ],
          ),
        );

        return MyConditionalBuilder(
          condition: favourites != null,
          builder:MyConditionalBuilder(
              condition: favourites != null && favourites.length>0,
              builder:  Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: favourites?.length,
                  itemBuilder: (context, index) {
                    ProductData ? product = favourites?[index].product;
                    double height = MediaQuery.of(context).size.height;
                    return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.red, child: Icon(Icons.delete_forever,color: Colors.white,),),
                      onDismissed: (dismissDirection){
                        favourites?.removeAt(index);
                        cubit.changeFavourites(product!.id!);
                      },
                      child: SizedBox(
                        height: height * 0.3,
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
              // onPressed: () => navigateTo(context, ProductDescription()),
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
                          OutlinedButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.shopping_cart,
                              size: 20,
                              color: isDark
                                  ? kLightPrimaryColor
                                  : kDarkPrimaryColor,
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