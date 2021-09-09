import 'package:e_shop/models/api/home.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';

class SortItemsScreen extends StatefulWidget {
  const SortItemsScreen({Key? key}) : super(key: key);

  @override
  _SortItemsScreenState createState() => _SortItemsScreenState();
}

class _SortItemsScreenState extends State<SortItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 8),
              child: Container(
                color: Colors.grey,
                height: 5,
                width: MediaQuery.of(context).size.width*0.2,
              ),
            ),
          ),
          Center(child: Text('Sort by',style: Theme.of(context).textTheme.subtitle1,)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
              SortByModel.getOptions.map((e) =>MaterialButton(
                minWidth:MediaQuery.of(context).size.width,
                color: e.isSelected?kPrimaryColorDarker:null,
                child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(e.title,style: Theme.of(context).textTheme.subtitle2,),
                ),
                onPressed: (){
                  setState(() {
                    SortByModel.getOptions.forEach((element) {
                      element.isSelected=false;

                    });
                    e.isSelected=true;
                  });
                },) ).toList(),

            //   MaterialButton(
            //     // color: kPrimaryColorDarker,
            //     onPressed: (){},
            //     child: Text('Popular'),
            //   ),
            //   MaterialButton(
            //     // color: kPrimaryColorDarker,
            //     onPressed: (){},
            //     child: Text('Random'),
            //   ),
            //   MaterialButton(
            //     // color: kPrimaryColorDarker,
            //     onPressed: (){},
            //     child: Text('Discount'),
            //   ),
            //   Container(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //           child: Text('Price',style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Theme.of(context).textTheme.caption?.color),),
            //         ),
            //         MaterialButton(
            //           // color: kPrimaryColorDarker,
            //           onPressed: (){},
            //           child: Text('low to high'),
            //         ),
            //         MaterialButton(
            //           // color: kPrimaryColorDarker,
            //           onPressed: (){},
            //           child: Text('high to low'),
            //         ),
            //       ],
            //     ),
            //   ),
            // ,
          ),
        ],
      ),
    );
  }
}
class SortByModel {
  final String title;
  final HomeProducts ? product;
   bool isSelected;

  SortByModel(this.title,this.isSelected, { this.product});

 static List <SortByModel> _sortByOptions  = [
   SortByModel('Popular',false,),
   SortByModel('Random', false,),
   SortByModel('Offer', false,),
   SortByModel('Price : Low to High', false),
   SortByModel('Price : High to Low', false,),
 ];
  static List <SortByModel> get getOptions => _sortByOptions;
}