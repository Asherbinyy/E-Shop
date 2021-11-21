part of 'widgets_search_imports.dart';
class SearchItemLikeButton extends StatelessWidget {
  const SearchItemLikeButton({
    Key? key,
    required this.cubit,
    required this.product,
    required this.isDark,
  }) : super(key: key);

  final LayoutCubit cubit;
  final ProductSearchData? product;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
    );
  }
}
