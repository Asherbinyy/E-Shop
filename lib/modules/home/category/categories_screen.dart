import 'package:e_shop/shared/models/api/categories/categories.dart';
import 'package:e_shop/shared/models/api/categories/category_products.dart';

import '/shared/components/builders/myConditional_builder.dart';
import '/shared/components/builders/product_card.dart';
import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';

import 'package:e_shop/styles/constants/constants.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

/// REVIEWED
class CategoryScreen extends StatelessWidget {
  final DataCategoriesData category;
  const CategoryScreen(
    this.category, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);
        var isDark = AppCubit.get(context).isDark;
        var height = MediaQuery.of(context).size.height;
        var textTheme = Theme.of(context).textTheme;
        var productModel = cubit.categoryProductModel;
        var products = cubit.categoryProductModel?.data?.data;

        return MyConditionalBuilder(
          condition: category.name != null && productModel != null,
          onBuild: Container(
            child: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _categoryImage(height, textTheme, isDark),
                    MyConditionalBuilder(
                      condition: productModel?.status == true &&
                          productModel!.data!.total! > 0,
                      onBuild: _ProductBuilder(cubit, products),
                      onError: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child:const Center(
                          child: kLoadingWanderingCubes,
                        ),
                      ),
                    )
                    // ProductsBuilder(products, isGrid: cubit.isGrid),
                  ],
                ),
              ),
            ),
          ),
          onError:const Center(
            child: kLoadingHourGlass,
          ),
        );
      },
    );
  }

  Widget _categoryImage(double height, TextTheme textTheme, bool isDark) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        //image
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          width: double.infinity,
          height: height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? kPrimaryColor
                    : kPrimaryColor.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Image.asset(
            getCategoryImageUrl(category),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        // text
        Container(
          width: double.infinity,
          padding:const EdgeInsets.all(5.0),
          color: isDark ? Colors.white54 : Colors.black45,
          child: Center(
            child: Text(
              category.name?.toUpperCase() ?? '',
              style: textTheme.overline
                  ?.copyWith(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}
class _ProductBuilder extends StatelessWidget {
  final LayoutCubit cubit;
  final List<ProductCategoryData>? products;
  const _ProductBuilder(this.cubit, this.products, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products?.length,
      itemBuilder: (context, index) {
        ProductCategoryData? product = products?[index];
        return SizedBox(
          height: height * 0.22,
          child: ProductCard(
              isGrid:false,
              name: product!.name!,
              seller: 'e_shop'.tr(),
              image: product.image!,
              price: product.price!,
              id: product.id!,
              oldPrice: product.oldPrice!,
              discount: product.discount!),
        );
      },
    );
  }
}
