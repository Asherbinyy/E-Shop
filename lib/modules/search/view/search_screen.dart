part of 'search_imports.dart';
/// REVIEWED
class SearchScreen extends StatefulWidget {
  final TextEditingController controller;
  const SearchScreen(
    this.controller, {
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    widget.controller.text='';
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var searchedProducts = cubit.searchModel?.data?.data;

        return SearchScaffold(
          leading: IconButton(
            onPressed: () {
              widget.controller.clear();
              navigateBack(context);
            },
            icon:(const Icon(Icons.arrow_back)
            ),
          ),
          child:  Column(
          children: [
            AdaptiveSearchBar(
              widget.controller,
              onSubmitted: (_) => cubit.searchProduct(widget.controller.text),
            ),
            SearchBuilder(controller: widget.controller, searchedProducts: searchedProducts, cubit: cubit, height: height  )
          ],
        ),
        );
      },
    );
  }
}





