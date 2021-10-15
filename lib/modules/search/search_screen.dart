import '/shared/components/builders/myConditional_builder.dart';
import '/layout/cubit/home_states.dart';
import '/models/api/search/search.dart';
import '/modules/product_details/product_details.dart';
import '/shared/components/adaptive/adaptive_search_bar.dart';
import '/shared/components/methods/navigation.dart';
import '/shared/components/reusable/spaces/spaces.dart';
import '/shared/cubit/app_cubit.dart';
import '/shared/cubit/app_state.dart';
import '/styles/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_localization/easy_localization.dart';
import '/layout/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
/// REVIEWED
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
        var cubit = HomeCubit.get(context);
        var searchedProducts = cubit.searchModel?.data?.data;

        return Scaffold(
          appBar: AppBar(
            title: Text('search'.tr()),
            leading: IconButton(
                onPressed: () {
                  controller.clear();
                  navigateBack(context);
                },
                icon: (const Icon(Icons.arrow_back))),
          ),
          body: Column(
            children: [
              AdaptiveSearchBar(
                controller,
                onSubmitted: (_) => cubit.searchProduct(controller.text),
              ),
              MyConditionalBuilder(
                condition: searchedProducts != null,
                builder: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: MyConditionalBuilder(
                      condition: cubit.searchModel?.status == true &&
                          searchedProducts!.length > 0 &&
                          controller.text.isNotEmpty,
                      builder: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  'search_result'.tr() + '${controller.text} ',
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                                const Spacer(),
                                Text(
                                  '(${searchedProducts?.length} ${searchedProducts?.length == 1 ? 'item'.tr() : 'items'.tr()} ${'were_found'.tr()})',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: cubit.searchModel?.data?.total,
                                itemBuilder: (context, index) {
                                  List<ProductSearchData>? products =
                                      cubit.searchModel?.data?.data;
                                  return SizedBox(
                                      height: height * 0.3,
                                      child: _SearchItem(
                                          cubit, index, products?[index]));
                                }),
                          ),
                        ],
                      ),
                      feedback: const _NoItemFound(),
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
}

class _NoItemFound extends StatelessWidget {
  const _NoItemFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          LottieBuilder.asset(
            kEmptySearchLottie,
            reverse: false,
          ),
          YSpace.extreme,
          Center(
            child: Text(
              'no_search_content'.tr(),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchItem extends StatelessWidget {
  const _SearchItem(
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var isDark = AppCubit.get(context).isDark;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: productCardDecoration(isDark),
                  child: MaterialButton(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    padding: EdgeInsets.zero,
                    splashColor: Colors.white,
                    onPressed: () {
                      navigateTo(context, ProductDetailsScreen(product!.id!));
                      cubit.getProductDetails(product!.id!);
                    },
                    // onPressed: () => {},
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomStart,
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
                              //like
                              InkWell(
                                onTap: () =>
                                    cubit.changeFavourites(product!.id!),
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
                                          offset: const Offset(0, 0),
                                          spreadRadius: 0.5,
                                          color: Colors.black.withOpacity(0.4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      (cubit.favourites?[product?.id] == true)
                                          ? Icons.favorite
                                          : Icons.favorite_outline,
                                      color: (cubit.favourites?[product?.id] ==
                                              true)
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
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? kDarkSecondaryColor
                                  : kLightSecondaryColor,
                              borderRadius: const BorderRadius.only(
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
                                  'by'.tr() + 'e_shop'.tr(),
                                  style: Theme.of(context).textTheme.caption,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomStart,
                                  child: FittedBox(
                                    child: Text(
                                      'egp'.tr() + ' ${product?.price}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                //cart
                                FittedBox(
                                  child: OutlinedButton(
                                    onPressed: () =>
                                        cubit.changeCarts(product!.id!),
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: Size(width, height * 0.1),
                                      backgroundColor:
                                          cubit.carts?[product?.id] == true
                                              ? kPrimaryColor
                                              : null,
                                    ),
                                    child: cubit.carts?[product?.id] == true
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                              XSpace.normal,
                                              Text(
                                                'added_to_cart'.tr(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5
                                                    ?.copyWith(
                                                        color: Colors.white),
                                              ),
                                            ],
                                          )
                                        : const Icon(
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
        });
  }
}
