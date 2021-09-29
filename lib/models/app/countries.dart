import '../../styles/constants.dart';

class CountriesModel {
  final String name ;
  final String image ;
  final String ? code ;
  const CountriesModel(this.name,this.image,{this.code});

  static List <CountriesModel> _list = [
   CountriesModel('EG',kCountriesImages[0]),
    CountriesModel('PAl',kCountriesImages[1]),
    CountriesModel('UAE',kCountriesImages[2]),
    CountriesModel('UK',kCountriesImages[3]),
  ];

  static List <CountriesModel>  get getCountries => _list;

}
