import '../../styles/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguagesModel {
  final String name ;
  final String value ;
  final String image ;
  const LanguagesModel(this.name,this.value,this.image);

  static List <LanguagesModel> _list = [
    LanguagesModel('arabic'.tr(),'ar',kArabicFlag),
    LanguagesModel('english'.tr(),'en',kEnglishFlag),
  ];

  static List <LanguagesModel>  get getLanguages => _list;

}