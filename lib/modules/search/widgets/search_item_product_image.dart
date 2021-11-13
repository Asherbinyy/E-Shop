
part of 'widgets_search_imports.dart';

class SearchItemProductImage extends StatelessWidget {
  const SearchItemProductImage({
    Key? key,
    required this.isDark,
    required this.product,
  }) : super(key: key);

  final bool isDark;
  final ProductSearchData? product;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
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
    );
  }
}
