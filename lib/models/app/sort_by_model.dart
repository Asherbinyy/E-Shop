import '/models/api/home.dart';

class SortByModel {
  final String title;
  final HomeProducts ? product;
   bool isSelected;

  SortByModel(this.title, {this.isSelected=false,this.product});

  static List <SortByModel> _sortByOptions  = [
    SortByModel('Popular',),
    SortByModel('Random',),
    SortByModel('Offer', ),
    SortByModel('Price : Low to High', ),
    SortByModel('Price : High to Low', ),
  ];
  static List <SortByModel> get getOptions => _sortByOptions;
}