import 'package:easy_localization/easy_localization.dart';
///REVIEWED
class SortByModel {
  final String title;
  final SortByOptions ? options;
   bool isSelected;

  SortByModel(this.title, {this.isSelected=false,this.options});

  static List <SortByModel> _sortByOptions  = [
    SortByModel('popular'.tr(),options:SortByOptions.POPULAR ),
    SortByModel('random'.tr(),options:SortByOptions.RANDOM),
    SortByModel('offer'.tr(),options:SortByOptions.OFFERS ),
    SortByModel('price_from_low'.tr(),options:SortByOptions.LOWER ),
    SortByModel('price_from_high'.tr(),options:SortByOptions.Higher ),
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