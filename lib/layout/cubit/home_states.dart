import 'package:e_shop/models/api/change_favourites_model.dart';
import 'package:e_shop/models/api/get_favourites_model.dart';
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
class HideBannersState extends HomeStates {}
//welcome screen
class HideWelcomeMessageState extends HomeStates {}
// View Selection Style
class ChangeViewSelectionState extends HomeStates {}
//Rate Product
class RateProductState extends HomeStates {}
/// METHODS
// GET HOME DATA
class GetHomeDataLoadingState extends HomeStates {}
class GetHomeDataSuccessState extends HomeStates {}
class GetHomeDataErrorState extends HomeStates {
 final String error ;
 GetHomeDataErrorState(this.error);
}
//favourites
class ToggleLikeButtonState extends HomeStates {}
class ChangeFavouritesSuccessState extends HomeStates {
 final ChangeFavouritesModel ? changeFavouritesModel;

  ChangeFavouritesSuccessState({this.changeFavouritesModel});
}
class ChangeFavouritesErrorState extends HomeStates {
 final String error ;
 ChangeFavouritesErrorState(this.error);
}
class GetFavouritesLoadingState extends HomeStates {}
class GetFavouritesSuccessState extends HomeStates {
 final GetFavouritesModel ? getFavouritesModel;

  GetFavouritesSuccessState({this.getFavouritesModel});
}
class GetFavouritesErrorState extends HomeStates {
 final String error ;
 GetFavouritesErrorState(this.error);
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

// Search
class SearchProductLoadingState extends HomeStates {}
class SearchProductSuccessState extends HomeStates {}
class SearchProductErrorState extends HomeStates {
 final String error ;
 SearchProductErrorState(this.error);
}



