import 'package:e_shop/shared/components/adaptive/adaptive_search_bar.dart';

import '/layout/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final String searched ;
  const SearchScreen( this.searched,{Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var controller = TextEditingController(text: this.searched);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          AdaptiveSearchBar(controller,onSubmitted: (_){},),
          Center(
            child:Text('Searched') ,
          ),
        ],
      ),
    );
  }
}
