import 'package:e_shop/modules/cart/controller/cart_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/components/builders/myConditional_builder.dart';
import 'package:e_shop/shared/models/api/products/product_details.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:lottie/lottie.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import '/shared/components/reusable/photo_viewer/product_Images_previewer.dart';
import '/shared/components/reusable/photo_viewer/single_product_image_previewer.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productID;

  const ProductDetailsScreen(this.productID, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool isDark = AppCubit.get(context).isDark;

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is RateProductState)
          Utils.showSnackBar(context, 'Thanks for your feedback',
              labelColor: isDark ? Colors.white : Colors.black,
              dialogueStates: DialogueStates.NONE,
              isDark: isDark);
      },
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        ProductDetailsData? product = cubit.productDetailsModel?.data;
        Widget _likeButton() => MyConditionalBuilder(
              // like action
              condition: (state is ChangeFavouritesSuccessState ||
                      state is ToggleLikeButtonState) &&
                  cubit.favourites?[product?.id] == true,
              onBuild: SizedBox(
                height: height * 0.06,
                child: OutlinedButton(
                  child: LottieBuilder.asset(
                    kLikeLottie,
                    repeat: false,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () => cubit.changeFavourites(product!.id!),
                ),
              ),
              onError: SizedBox(
                height: height * 0.06,
                //liked or unliked
                child: OutlinedButton(
                  child: cubit.favourites?[product?.id] == true
                      ? Icon(
                          Icons.favorite,
                          color: kLikeButtonColor,
                        )
                      : Icon(Icons.favorite_outline),
                  onPressed: () => cubit.changeFavourites(product!.id!),
                ),
              ),
            );
        Widget _cartButton() => BlocBuilder<LayoutCubit, LayoutStates>(
              builder: (context, state) {
                final cubit = LayoutCubit.get(context);

                return MyConditionalBuilder(
                  // cart action
                  condition: (state is ChangeCartSuccessState ||
                          state is ToggleCartButtonState) &&
                      cubit.carts?[product?.id] == true,
                  onBuild: SizedBox(
                    height: height * 0.06,
                    child: OutlinedButton(
                      child: LottieBuilder.asset(
                        kAddedToCart2Lottie,
                        repeat: false,
                        fit: BoxFit.cover,
                      ),
                      onPressed: () => cubit.changeCarts(product!.id!),
                    ),
                  ),
                  onError: SizedBox(
                      height: height * 0.06,
                      child: cubit.carts?[product?.id] == true
                          ? OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: AppCubit.get(context).isDark
                                      ? Colors.white12
                                      : kPrimaryColor.withOpacity(0.1)),
                              onPressed: () =>
                                  cubit.changeCarts(product!.id!),
                              label: Text(
                                'Added to Cart',
                                style: TextStyle(color: Colors.green),
                              ),
                              icon: Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                            )
                          : ElevatedButton.icon(
                              onPressed: () =>
                                  cubit.changeCarts(product!.id!),
                              label: Text('Add item To Cart'),
                              icon: Icon(Icons.add_shopping_cart),
                            )),
                );
              },
            );

        return Scaffold(
          persistentFooterButtons: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: _cartButton(),
                ),
                XSpace.light,
                Expanded(child: _likeButton()),
              ],
            ),
          ],
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: Colors.transparent),
            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            children: [
              // image
              Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: PageView.builder(
                        itemCount: product?.images?.length,
                        itemBuilder: (context, index) {
                          return MyConditionalBuilder(
                            condition: product?.images != null,
                            onBuild: InkWell(
                              onTap: () => navigateTo(
                                  context,
                                  ProductImagesPreviewer(
                                      images: product?.images)),
                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  isDark ? Colors.black12 : Colors.black,
                                  BlendMode.difference,
                                ),
                                child: Opacity(
                                  opacity: isDark ? 0.8 : 1,
                                  child: Hero(
                                      tag: '$productID',
                                      child: Image.network(
                                        product?.images?[index] ??
                                            kNoImageFound,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                      )),
                                ),
                              ),
                            ),
                            onError: Hero(
                              tag: '$productID ',
                              child: kHashImage,
                            ),
                          );
                        }),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              // page
              DraggableScrollableSheet(
                minChildSize: 0.5,
                maxChildSize: 1,
                initialChildSize: 0.5,
                builder: (context, controller) {
                  Widget _section(
                    String label, {

                    /// if isCustomizable=true provide a proper child widget.details will have no impact .
                    bool isCustomizable = false,
                    Widget? child,
                    String? details,
                  }) {
                    if (details != null) child = null;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        YSpace.normal,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5.0),
                          child: Text(
                            label,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                        YSpace.normal,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppCubit.get(context).isDark
                                ? kDarkPrimaryColor
                                : kLightPrimaryColor,
                          ),
                          child: isCustomizable
                              ? child
                              : SelectableText(details ?? ''),
                        ),
                      ],
                    );
                  }

                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    controller: controller,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppCubit.get(context).isDark
                            ? kDarkSecondaryColor
                            : kLightSecondaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          // brand name
                          _section('Brand Name',
                              details: '${product?.name ?? ''}'),
                          //images
                          if (product?.images != null)
                            _section(
                              'Feature Images',
                              isCustomizable: true,
                              child: Container(
                                color: isDark ? null : kLightSecondaryColor,
                                height: height * 0.1,
                                width: width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2.0),
                                  child: ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: product!.images!.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => navigateTo(
                                            context,
                                            SingleProductImagePreviewer(
                                                product.images?[index])),
                                        child: Hero(
                                          tag: '${product.images?[index]}',
                                          child: Container(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Image.network(
                                                  product.images![index],
                                                  fit: BoxFit.cover)),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return XSpace.normal;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          // description
                          _section('Description',
                              details: '${product?.description ?? ''}'),
                          // Price
                          _section(
                            'Price',
                            isCustomizable: true,
                            child: product?.discount != null &&
                                    product?.discount != 0
                                ? Row(
                                    children: [
                                      Text('EGP ${product?.price ?? ''}'),
                                      XSpace.light,
                                      Text(
                                        'EGP ${product?.oldPrice ?? ''}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            ?.copyWith(
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                      ),
                                      Spacer(),
                                      FittedBox(
                                        child: Text(
                                            '-% ${product?.discount ?? ''} for a Limited time'),
                                      ),
                                    ],
                                  )
                                : Text('EGP ${product?.price ?? ''}'),
                          ),
                          // Buttons
                          // _section(
                          //   'label',
                          //   isCustomizable: true,
                          //   child: ToggleButtons(
                          //     onPressed: (index) {},
                          //     children: List.generate(
                          //         3,
                          //         (index) => TextButton(
                          //               onPressed: () {},
                          //               child: Text('button'),
                          //             )),
                          //     isSelected: List.generate(3, (index) => false),
                          //   ),
                          // ),

                          // RATING
                          _section(
                            'User Rating',
                            isCustomizable: true,
                            child: Row(
                              children: [
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) =>
                                      cubit.rateProduct(rating),
                                ),
                                Tooltip(
                                    preferBelow: false,
                                    message: '${10.toString()} users ratings',
                                    child: Text('(${10.toString()})',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption)),
                                Spacer(),
                                if (cubit.userRating != null)
                                  Text(
                                    '(${cubit.userRating})',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(color: kPrimaryColor),
                                  ),
                              ],
                            ),
                          ),
                          // //category
                          // _section('Category',isCustomizable: true,child: TextButton(
                          //   onPressed: (){},
                          //   // navigateToAndFinish(context,Scaffold(appBar: AppBar(),body: CategoryScreen(),),
                          //   child: Text('label '),
                          // ),),
                          // buttons
                          ToggleButtons(
                            children: [],
                            isSelected: [],
                          ),
                          YSpace.titan,
                          YSpace.titan,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

List<Widget> _buttons = [
  MaterialButton(
    onPressed: () {},
    child: CircleAvatar(),
  )
];
