import 'package:easy_localization/easy_localization.dart';
/// REVIEWED
class FaqModel {
  final String q ;
  final String a ;
 const FaqModel(this.q,this.a);

  static List <FaqModel> _list  =  [
    FaqModel('q1'.tr(), 'a1'.tr()),
    FaqModel('q2'.tr(), 'a2'.tr()),
    FaqModel('q3'.tr(), 'a3'.tr()),
    FaqModel('q4'.tr(), 'a4'.tr()),
  ];
  static List <FaqModel> get getList => _list ;
}
