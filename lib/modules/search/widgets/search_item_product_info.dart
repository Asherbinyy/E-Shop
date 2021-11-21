part of 'widgets_search_imports.dart';

class SearchItemProductInfo extends StatelessWidget {
  const SearchItemProductInfo({
    Key? key,
    required this.width,
    required this.isDark,
    required this.product,
    required this.cubit,
    required this.height,
  }) : super(key: key);

  final double width;
  final bool isDark;
  final ProductSearchData? product;
  final LayoutCubit cubit;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isDark ? kDarkSecondaryColor : kLightSecondaryColor,
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
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          //cart
          BlocBuilder<LayoutCubit, LayoutStates>(
            builder: (context, state) {
              final cubit = LayoutCubit.get(context);
              return FittedBox(
                child: OutlinedButton(
                  onPressed: () => cubit.changeCarts(product!.id!),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(width, height * 0.1),
                    backgroundColor: cubit.carts?[product?.id] == true
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
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        )
                      : const Icon(
                          Icons.add_shopping_cart,
                          size: 40,
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
