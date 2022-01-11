import '../../../styles/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class LandingModel {
  final String? imageUrl;
  final String? title;
  final String? body;
  // final Color? backgroundColor;
  const LandingModel._({
    this.imageUrl,
    this.body,
    this.title,
    // this.backgroundColor,
  });
}

class LandingData {
  LandingData._();
  static List<LandingModel> _list = [
    LandingModel._(
        title: 'landing_title_1'.tr(),
        body: 'landing_body_1'.tr(),
        imageUrl: kLandingImages[0]),
    LandingModel._(
        title: 'landing_title_2'.tr(),
        body: 'landing_body_2'.tr(),
        imageUrl: kLandingImages[1]),
    LandingModel._(
        title: 'landing_title_3'.tr(),
        body: 'landing_body_3'.tr(),
        imageUrl: kLandingImages[2]),
  ];
  static List<LandingModel> get getLandingList => _list;
}
