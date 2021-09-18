import '../api/home/home.dart';

class SortByModel {
  final String title;
  final SortByOptions ? options;
   bool isSelected;

  SortByModel(this.title, {this.isSelected=false,this.options});

  static List <SortByModel> _sortByOptions  = [
    SortByModel('Popular',options:SortByOptions.POPULAR ),
    SortByModel('Random',options:SortByOptions.RANDOM),
    SortByModel('Offer',options:SortByOptions.OFFERS ),
    SortByModel('Price : Low to High',options:SortByOptions.LOWER ),
    SortByModel('Price : High to Low',options:SortByOptions.Higher ),
  ];
  static List <SortByModel> get getOptions => _sortByOptions;
}
enum SortByOptions {
  POPULAR,
  RANDOM,
  OFFERS,
  LOWER,
  Higher,
}