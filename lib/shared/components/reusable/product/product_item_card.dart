import 'package:e_shop/models/api/home.dart';
import 'package:e_shop/shared/cubit/app_cubit.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';

class ProductItemCard extends StatelessWidget {
  const ProductItemCard(
      this.isDark, {
        Key? key,
        required this.height,
        required this.product,
        required this.width,
      }) : super(key: key);

  final bool isDark;
  final double height;
  final HomeProducts? product;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: productCardDecoration(isDark),
        child: MaterialButton(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: EdgeInsets.zero,
          splashColor: Colors.white,
          onPressed: () {},
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
                              child: Image.network(
                                product?.image ?? kNoImageFound,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height:double.infinity,
                                alignment: AlignmentDirectional.topCenter,
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
                    ),
                  ),
                  // product info
                  Expanded(
                      child: LayoutBuilder(builder: (context,constrains){
                        double maxHeight = constrains.maxHeight;
                        double maxWidth = constrains.maxWidth;
                        return Container(
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
                                  child: RichText(
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
                                              color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(),
                                    FittedBox(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          fixedSize: Size(width, maxHeight*0.28),
                                          // padding: EdgeInsetsDirectional.all(10.0)
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Icon(
                                                Icons.shopping_cart,
                                                size: 20,
                                              ),
                                            ),
                                            FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child : Text(
                                                'Add to cart'.toUpperCase(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    ?.copyWith(color: kPrimaryColorDarker),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                  ),
                ],
              ),
              // Like Button
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 5.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppCubit.get(context).isDark
                        ? kDarkPrimaryColor
                        : kLightSecondaryColor,
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
                  child:  Icon(
                    Icons.favorite_outline,
                    color: AppCubit.get(context).isDark
                        ? kLightPrimaryColor
                        : kDarkPrimaryColor,
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