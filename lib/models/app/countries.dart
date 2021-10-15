import '../../styles/constants.dart';
import 'package:easy_localization/easy_localization.dart';
///REVIEWED
class CountriesModel {
  final String name ;
  final String value ;
  final String image ;
  final String ? code ;
  const CountriesModel(this.name,this.image, {required this.value,this.code});

  static List <CountriesModel> _list = [
    CountriesModel('eg'.tr(),kCountriesImages[0],value:'EG' ),
    CountriesModel('pal'.tr(),kCountriesImages[1],value:'PAl' ),
    CountriesModel('uae'.tr(),kCountriesImages[2],value:'UAE' ),
    CountriesModel('uk'.tr(),kCountriesImages[3],value:'UK' ),
  ];

  static List <CountriesModel>  get getCountries => _list;

}
