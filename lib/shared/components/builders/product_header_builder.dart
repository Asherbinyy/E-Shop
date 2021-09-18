import '/shared/components/reusable/filter_search/filter_search_list_tile.dart';
import 'package:flutter/material.dart';

class ProductHeaderWidget extends StatelessWidget {
  final String title;
  final bool showSearchFilter;

  const ProductHeaderWidget({Key? key,required this.title , this.showSearchFilter = true,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
          const EdgeInsetsDirectional.only(top: 15.0, start: 10),
          child: FittedBox(
            child: Text(
              '$title'.toUpperCase(),
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        //Filter Search
        if (showSearchFilter) FilterSearchListTile(),
      ],
    );
  }
}
