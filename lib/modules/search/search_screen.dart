import 'package:e_shop/layout/cubit/home_states.dart';
import 'package:e_shop/models/api/get_favourites_model.dart';
import 'package:e_shop/models/api/search_model.dart';
import 'package:e_shop/modules/landing/landing_screen.dart';
import 'package:e_shop/modules/product_description/product_description.dart';
import 'package:e_shop/shared/components/adaptive/adaptive_search_bar.dart';
import 'package:e_shop/shared/components/methods/navigation.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:e_shop/shared/cubit/app_cubit.dart';
import 'package:e_shop/shared/cubit/app_state.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '/layout/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController controller;
  const SearchScreen(
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);

        List<ProductSearchData>? searchedProducts =
            cubit.searchModel?.data?.data;

        return Scaffold(
          appBar: AppBar(
            title: Text('Search'),
            leading: IconButton(
                onPressed: (){
              controller.clear();
              Navigator.pop(context);
            }, icon: (Icon(Icons.arrow_back))),
          ),
          body: Column(
            children: [
              AdaptiveSearchBar(
                controller,
                onSubmitted: (_) {
                  cubit.searchProduct(controller.text);
                },
              ),
              MyConditionalBuilder(
                condition: searchedProducts != null,
                builder: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MyConditionalBuilder(
                      condition: cubit.searchModel?.status == true && searchedProducts!.length > 0 && controller.text.isNotEmpty,
                      builder: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Results for : ${controller.text} ',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                Spacer(),
                                Text(
                                  '(${searchedProducts?.length} ${searchedProducts?.length==1 ? 'item' : 'items'} were found)',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: cubit.searchModel?.data?.total,
                                itemBuilder: (context, index) {
                                  List<ProductSearchData>? products =
                                      cubit.searchModel?.data?.data;
                                  return SizedBox(
                                      height: height * 0.3,
                                      child: _SearchBuilder(
                                          cubit, index, products?[index]));
                                }),
                          ),
                        ],
                      ),
                      feedback: _noItemFound(),
                    ),
                  ),
                ),
                feedback: Center(
                  child: kLoadingWanderingCubes,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _noItemFound() => Padding(
        padding: const EdgeInsets.all(50.0),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            LottieBuilder.asset(
              kEmptySearchLottie,
              reverse: false,
            ),
            YSpace.extreme,
            Center(
                child: Text(
              'I\'m Sorry, There is no such Item found',
              textAlign: TextAlign.center,
            )),
          ],
        ),
      );
}

class _SearchBuilder extends StatelessWidget {
  const _SearchBuilder(
    this.cubit,
    this.index,
    this.product, {
    Key? key,
  }) : super(key: key);
  final int index;
  final HomeCubit cubit;
  final ProductSearchData? product;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isDark = AppCubit.get(context).isDark;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: productCardDecoration(isDark),
            child: MaterialButton(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding: EdgeInsets.zero,
              splashColor: Colors.white,
              onPressed: () => navigateTo(context, ProductDescription(product)),
              // onPressed: () => {},
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
                            // if (product?.discount != 0)
                            //   Padding(
                            //     padding:
                            //     const EdgeInsets.symmetric(vertical: 15.0),
                            //     child: RotationTransition(
                            //       turns: AlwaysStoppedAnimation(-30 / 360),
                            //       child: Container(
                            //         padding: const EdgeInsets.all(8.0),
                            //         decoration: BoxDecoration(
                            //           color: Colors.teal.shade800,
                            //           borderRadius: BorderRadius.circular(20.0),
                            //         ),
                            //         child: FittedBox(
                            //           child: Text(
                            //             '${product?.discount} % OFF',
                            //             style: Theme.of(context)
                            //                 .textTheme
                            //                 .bodyText2
                            //                 ?.copyWith(
                            //               color: Colors.white,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                          ],
                        ),
                        //like
                        InkWell(
                          onTap: () => cubit.changeFavourites(product!.id!),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 5.0, bottom: 2.0),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? kDarkPrimaryColor
                                    : kLightSecondaryColor,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 7,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0.5,
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                (cubit.favourites?[product?.id] == true)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: (cubit.favourites?[product?.id] == true)
                                    ? kLikeButtonColor
                                    : (isDark
                                    ? kLightPrimaryColor
                                    : kDarkPrimaryColor),
                              ),
                            ),
                          ),
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
                              child:
                                  // product?.discount != 0 ?RichText(
                                  //   text: TextSpan(
                                  //     style: Theme.of(context)
                                  //         .textTheme
                                  //         .bodyText2
                                  //         ?.copyWith(
                                  //         fontWeight: FontWeight.bold),
                                  //     text: 'EGP ${product?.price}  ',
                                  //     children: [
                                  //       TextSpan(
                                  //         text: ' ${product?.oldPrice}',
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .overline
                                  //             ?.copyWith(
                                  //             decoration: TextDecoration
                                  //                 .lineThrough,
                                  //             color: kLikeButtonColor),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ):
                                  Text(
                                'EGP ${product?.price}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
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
