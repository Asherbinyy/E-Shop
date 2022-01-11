import 'package:easy_localization/easy_localization.dart';
/// REVIEWED
class FaqModel {
  final String q ;
  final String a ;
 const FaqModel._(this.q,this.a);
}

class FaqData {
  FaqData._();
  static List <FaqModel> _list  =  [
    FaqModel._('q1'.tr(), 'a1'.tr()),
    FaqModel._('q2'.tr(), 'a2'.tr()),
    FaqModel._('q3'.tr(), 'a3'.tr()),
    FaqModel._('q4'.tr(), 'a4'.tr()),
  ];
  static List <FaqModel> get getList => _list ;
}