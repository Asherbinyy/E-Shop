part of 'widgets_search_imports.dart';


class SearchBuilderResults extends StatelessWidget {
  const SearchBuilderResults({
    Key? key,
    required this.controller,
    required this.searchedProducts,
  }) : super(key: key);

  final TextEditingController controller;
  final List<ProductSearchData>? searchedProducts;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
