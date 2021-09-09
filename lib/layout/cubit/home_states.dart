import 'package:e_shop/models/api/sign_out.dart';
import 'package:e_shop/models/api/email_verification.dart';
import 'package:e_shop/models/api/verify_code.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

/// LAYOUT
// bottom nav bar
class ChangeBottomNavState extends HomeStates {}
// banner Slider
class ChangeBannerSlideState extends HomeStates {}
class HideWelcomeMessageState extends HomeStates {}

/// METHODS
// GET HOME DATA
class GetHomeDataLoadingState extends HomeStates {}
class GetHomeDataSuccessState extends HomeStates {}
class GetHomeDataErrorState extends HomeStates {
 final String error ;
 GetHomeDataErrorState(this.error);
}
//profile
class GetProfileLoadingState extends HomeStates {}
class GetProfileSuccessState extends HomeStates {}
class GetProfileErrorState extends HomeStates {
 final String error ;
 GetProfileErrorState(this.error);
}
//sign out
class SignOutSuccessState extends HomeStates {
 final SignOutModel signOutModel;
  SignOutSuccessState(this.signOutModel);

}
class SignOutErrorState extends HomeStates {
 final String error ;
 SignOutErrorState(this.error);
}
//send email verification
class SendVerificationLoadingState extends HomeStates {}
class SendVerificationSuccessState extends HomeStates {
 final EmailVerificationModel verifyEmailModel;
  SendVerificationSuccessState(this.verifyEmailModel);
}
class SendVerificationErrorState extends HomeStates {
 final String error ;
 SendVerificationErrorState(this.error);
}
//verify code
class VerifyCodeLoadingState extends HomeStates {}
class VerifyCodeSuccessState extends HomeStates {
 final VerifyCodeModel ? verifyCodeModel;

  VerifyCodeSuccessState(this.verifyCodeModel);
}
class VerifyCodeErrorState extends HomeStates {
 final String error ;
 VerifyCodeErrorState(this.error);
}

// get banners
class GetBannersLoadingState extends HomeStates {}
class GetBannersSuccessState extends HomeStates {}
class GetBannersErrorState extends HomeStates {
 final String error ;
  GetBannersErrorState(this.error);
}
// get Categories
class GetCategoriesLoadingState extends HomeStates {}
class GetCategoriesSuccessState extends HomeStates {}
class GetCategoriesErrorState extends HomeStates {
 final String error ;
 GetCategoriesErrorState(this.error);
}

