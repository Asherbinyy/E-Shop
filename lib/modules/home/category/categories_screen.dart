import 'package:e_shop/models/api/categories/category_products.dart';
import 'package:e_shop/shared/components/builders/product_card.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '../../../models/api/categories/categories.dart';
import '/modules/landing/landing_screen.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  final DataCategoriesData category;
  const CategoryScreen(
    this.category, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        bool isDark = AppCubit.get(context).isDark;
        double height = MediaQuery.of(context).size.height;
        TextTheme textTheme = Theme.of(context).textTheme;
        CategoryProductModel? productModel = cubit.categoryProductModel;
        List<ProductCategoryData>? products = cubit.categoryProductModel?.data?.data;

        return MyConditionalBuilder(
          condition: category.name != null && productModel != null,
          builder: Container(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                      builder: _ProductBuilder(cubit, products),
                      feedback: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Center(
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
          feedback: Center(
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
                    ? kPrimaryColorDarker
                    : kPrimaryColorDarker.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 0),
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
          padding: EdgeInsets.all(5.0),
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
  final HomeCubit cubit;
  final List<ProductCategoryData>? products;
  const _ProductBuilder(this.cubit, this.products, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products?.length,
      itemBuilder: (context, index) {
        ProductCategoryData? product = products?[index];
        return SizedBox(
          height: height * 0.22,
          child: ProductCard(
              isGrid:false,
              name: product!.name!,
              seller: 'E-Shop',
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
