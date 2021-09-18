
class FaqModel {
  final String q ;
  final String a ;
  FaqModel(this.q,this.a);

  static List <FaqModel> list = [
    FaqModel('For Whom this app ? ', 'everyone'),
    FaqModel('How many Language the app support ? ', 'English , Arabic . We are working on more language .. soon.'),
  ];
}
