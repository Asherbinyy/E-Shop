import '/modules/product_description/product_description.dart';
import '/shared/components/methods/navigation.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '/models/api/home.dart';
import '/shared/components/reusable/filter_search/filter_search_list_tile.dart';
import '/shared/components/reusable/spaces/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBuilder extends StatelessWidget {
  const ProductsBuilder(
    this.products, {
    Key? key,
    required this.isGrid,
    this.showSearchFilter = true,
    this.showHeaderTitle = false,
    this.headerTitle = '',
  }) : super(key: key);

  final List<HomeProducts>? products;
  final String headerTitle;
  final bool isGrid;
  final bool showHeaderTitle;
  final bool showSearchFilter;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Builder(builder: (context) {
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;
          bool isDark = AppCubit.get(context).isDark;
          Widget _gridBuilder() => GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: width / height * 1,
                  // childAspectRatio: width / height * 0.9, // was 1.07
                ),
                itemBuilder: (context, index) {
                  return _ProductItemGridCard(
                    cubit,
                    products?[index],
                    isDark: isDark,
                  );
                },
              );
          Widget _listBuilder() => ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products?.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                      height: height * 0.3,
                      child: _ProductItemListCard(
                        cubit,
                        products?[index],
                        isDark: isDark,
                      ));
                },
              );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // products
              if (showHeaderTitle)
                Padding(
                  padding:
                      const EdgeInsetsDirectional.only(top: 10.0, start: 10),
                  child: FittedBox(
                    child: Text(
                      '$headerTitle'.toUpperCase(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              YSpace.extreme,
              //Filter Search
              if (showSearchFilter) FilterSearchListTile(),
              // products View
              isGrid ? _gridBuilder() : _listBuilder(),
            ],
          );
        });
      },
    );
  }
}

class _ProductItemGridCard extends StatelessWidget {
  const _ProductItemGridCard(
    this.cubit,
    this.product, {
    required this.isDark,
    Key? key,
  }) : super(key: key);

  final HomeProducts? product;
  final bool isDark;
  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: productCardDecoration(isDark),
        child: MaterialButton(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: EdgeInsets.zero,
          splashColor: Colors.white,
          onPressed: () => navigateTo(context, ProductDescription(product)),
          child: Stack(
            alignment: AlignmentDirectional.centerEnd,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  // image and offer
                  Expanded(
                    child: SizedBox(
                      child: Stack(
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
                              child: product?.discount != 0
                                  ? RichText(
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
                                    )
                                  : Text(
                                      'EGP ${product?.price}',
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
                            fit: BoxFit.contain,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                minimumSize: Size(width, height * 0.1),
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.shopping_cart,
                                size: 40,
                                color: isDark
                                    ? kLightPrimaryColor
                                    : kDarkPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // Like
              InkWell(
                onTap: () => cubit.changeFavourites(product!.id!),
                child: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 5.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color:
                            isDark ? kDarkPrimaryColor : kLightSecondaryColor,
                        // borderRadius: BorderRadius.circular(20.0),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 7,
                            offset: Offset(0, 0),
                            spreadRadius: 0.5,
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ],
                      ),
                      child: (cubit.favourites?[product?.id] == true)
                          ? Icon(
                              Icons.favorite,
                              color: kLikeButtonColor,
                            )
                          : Icon(Icons.favorite_outline,
                              color: (isDark
                                  ? kLightPrimaryColor
                                  : kDarkPrimaryColor)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductItemListCard extends StatelessWidget {
  const _ProductItemListCard(
    this.cubit,
    this.product, {
    required this.isDark,
    Key? key,
  }) : super(key: key);

  final HomeCubit cubit;
  final HomeProducts? product;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: productCardDecoration(isDark),
        child: MaterialButton(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: EdgeInsets.zero,
          splashColor: Colors.white,
          onPressed: () => navigateTo(context, ProductDescription(product)),
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
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
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
                    // Like
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
                    color: isDark ? kDarkSecondaryColor : kLightSecondaryColor,
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
                          child: product?.discount != 0
                              ? RichText(
                                  text: TextSpan(
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    text: 'EGP ${product?.price}  ',
                                    children: [
                                      TextSpan(
                                        text: ' ${product?.oldPrice}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline
                                            ?.copyWith(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: kLikeButtonColor),
                                      ),
                                    ],
                                  ),
                                )
                              : Text(
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
                          color:
                              isDark ? kLightPrimaryColor : kDarkPrimaryColor,
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
  }
}
