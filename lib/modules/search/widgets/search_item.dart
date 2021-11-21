part of 'widgets_search_imports.dart';

class SearchItem extends StatelessWidget {
  const SearchItem(
      this.cubit,
      this.index,
      this.product, {
        Key? key,
      }) : super(key: key);
  final int index;
  final LayoutCubit cubit;
  final ProductSearchData? product;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<LayoutCubit, LayoutStates>(
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
                              //image
                              SearchItemProductImage(isDark: isDark, product: product),
                              //like
                              SearchItemLikeButton(cubit: cubit, product: product, isDark: isDark),
                            ],
                          ),
                        ),
                        // product info
                        Expanded(child: SearchItemProductInfo(width: width, isDark: isDark, product: product, cubit: cubit, height: height)),
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

