part of 'widgets_search_imports.dart';


class SearchBuilder extends StatelessWidget {
  const SearchBuilder({
    Key? key,
    required this.controller,
    required this.searchedProducts,
    required this.cubit,
    required this.height,
  }) : super(key: key);

  final TextEditingController controller;
  final List<ProductSearchData>? searchedProducts;
  final HomeCubit cubit;
  final double height;

  @override
  Widget build(BuildContext context) {
    return  MyConditionalBuilder(
      condition: searchedProducts != null,
      onBuild: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: MyConditionalBuilder(
            condition: cubit.searchModel?.status == true &&
                searchedProducts!.length > 0 &&
                controller.text.isNotEmpty,
            onBuild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBuilderResults(controller: controller, searchedProducts: searchedProducts),
                SearchBuilderListView(cubit: cubit, height: height),
              ],
            ),
            onError: const SearchNoItemFound(),
          ),
        ),
      ),
      onError:const Center(
        child: kLoadingWanderingCubes,
      ),
    );
  }
}
