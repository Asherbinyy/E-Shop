part of 'widgets_search_imports.dart';

class SearchBuilderListView extends StatelessWidget {
  const SearchBuilderListView({
    Key? key,
    required this.cubit,
    required this.height,
  }) : super(key: key);

  final HomeCubit cubit;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.searchModel?.data?.total,
          itemBuilder: (context, index) {
            List<ProductSearchData>? products =
                cubit.searchModel?.data?.data;
            return SizedBox(
                height: height * 0.3,
                child: SearchItem(
                    cubit, index, products?[index]));
          }),
    );
  }
}
