import 'package:e_shop/models/api/addresses/delete_address.dart';
import 'package:e_shop/models/api/carts/change_cart.dart';
import 'package:e_shop/models/api/carts/update_cart.dart';
import 'package:e_shop/models/api/favourites/change_favourites.dart';
import 'package:e_shop/models/api/user/change_password.dart';
import 'package:e_shop/models/api/carts/get_carts.dart';
import 'package:e_shop/models/api/favourites/get_favourites.dart';
import 'package:e_shop/models/api/user/login.dart';
import 'package:e_shop/models/api/user/profile.dart';
import 'package:e_shop/models/api/user/sign_out.dart';
import 'package:e_shop/models/api/user/email_verification.dart';
import 'package:e_shop/models/api/user/verify_code.dart';

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
// Rate the App
class RateAppLoadingState extends HomeStates {}
class RateAppSuccessState extends HomeStates {}
class RateAppErrorState extends HomeStates {
 final String error ;
 RateAppErrorState(this.error);
}

class ToggleExpandedCartsState extends HomeStates {}
/// METHODS
// GET HOME DATA
class GetHomeDataLoadingState extends HomeStates {}
class GetHomeDataSuccessState extends HomeStates {}
class GetHomeDataErrorState extends HomeStates {
 final String error ;
 GetHomeDataErrorState(this.error);
}
class GetHomeProductsLoadingState extends HomeStates {}
class GetHomeProductsSuccessState extends HomeStates {}

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
//carts
class ToggleCartButtonState extends HomeStates {}
class ChangeCartSuccessState extends HomeStates {
 final ChangeCartModel ? changeCartModel;

  ChangeCartSuccessState({this.changeCartModel});
}
class ChangeCartErrorState extends HomeStates {
 final String error ;
 ChangeCartErrorState(this.error);
}
class GetCartLoadingState extends HomeStates {}
class GetCartSuccessState extends HomeStates {
 final GetCartsModel ? getCartsModel;

  GetCartSuccessState({this.getCartsModel});
}
class GetCartErrorState extends HomeStates {
 final String error ;
 GetCartErrorState(this.error);
}
// update carts
class UpdateCartLoadingState extends HomeStates {}
class UpdateCartSuccessState extends HomeStates {
 final UpdateCartModel ? updateCartModel;

 UpdateCartSuccessState(this.updateCartModel);
}
class UpdateCartErrorState extends HomeStates {
 final String error ;
 UpdateCartErrorState(this.error);
}
// class QuantityIncreasedState extends HomeStates{}
// class QuantityDecreasedState extends HomeStates{}
// increment & decrement

//profile
class GetProfileLoadingState extends HomeStates {}
class GetProfileSuccessState extends HomeStates {}
class GetProfileErrorState extends HomeStates {
 final String error ;
 GetProfileErrorState(this.error);
}
class UpdateProfileLoadingState extends HomeStates {}
class UpdateProfileSuccessState extends HomeStates {
 final LoginModel updatedProfile;

  UpdateProfileSuccessState(this.updatedProfile);

}
class UpdateProfileErrorState extends HomeStates {
 final String error ;
 UpdateProfileErrorState(this.error);
}

class ToggleEditProfileState extends HomeStates {}



// pick image
class ImagePickedSuccessState extends HomeStates{}
class ImagePickedErrorState extends HomeStates{}


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
//change password
 class ChangePasswordLoadingState extends HomeStates {}

class ChangePasswordSuccessState extends HomeStates {
 final ChangePasswordModel ? changePasswordModel;

  ChangePasswordSuccessState(this.changePasswordModel);
}
class ChangePasswordErrorState extends HomeStates {
 final String error ;
 ChangePasswordErrorState(this.error);
}
class TogglePasswordVisibilityState extends HomeStates{}
class EnableUpdateButtonState extends HomeStates{}

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
// get category products
class GetCategoryProductsLoadingState extends HomeStates {}
class GetCategoryProductsSuccessState extends HomeStates {}
class GetCategoryProductsErrorState extends HomeStates {
 final String error ;
 GetCategoryProductsErrorState(this.error);
}

// Search
class SearchProductLoadingState extends HomeStates {}
class SearchProductSuccessState extends HomeStates {}
class SearchProductErrorState extends HomeStates {
 final String error ;
 SearchProductErrorState(this.error);
}
// productDetails
class GetProductDetailsLoadingState extends HomeStates {}
class GetProductDetailsSuccessState extends HomeStates {}
class GetProductDetailsErrorState extends HomeStates {
 final String error ;
 GetProductDetailsErrorState(this.error);
}

// addresses
class GetAddressesLoadingState extends HomeStates {}
class GetAddressesSuccessState extends HomeStates {}
class GetAddressesErrorState extends HomeStates {
 final String error ;
 GetAddressesErrorState(this.error);
}
class DeleteAddressLoadingState extends HomeStates {}

class DeleteAddressSuccessState extends HomeStates {
final DeleteAddressModel ? deleteAddressModel;
DeleteAddressSuccessState(this.deleteAddressModel);
}
class DeleteAddressErrorState extends HomeStates {
 final String error ;
 DeleteAddressErrorState(this.error);
}

