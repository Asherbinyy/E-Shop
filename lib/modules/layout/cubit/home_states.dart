import 'package:e_shop/modules/auth/models/auth_model.dart';
import 'package:e_shop/modules/cart/models/change_cart.dart';
import 'package:e_shop/modules/cart/models/get_carts.dart';
import 'package:e_shop/modules/cart/models/update_cart.dart';
import 'package:e_shop/shared/models/api/addresses/delete_address.dart';

import 'package:e_shop/shared/models/api/favourites/change_favourites.dart';
import 'package:e_shop/shared/models/api/user/change_password.dart';
import 'package:e_shop/shared/models/api/favourites/get_favourites.dart';
import 'package:e_shop/shared/models/api/user/sign_out.dart';
import 'package:e_shop/shared/models/api/user/email_verification.dart';
import 'package:e_shop/shared/models/api/user/verify_code.dart';

abstract class LayoutStates {}

class LayoutInitialState extends LayoutStates {}

/// LAYOUT
// bottom nav bar
class ChangeBottomNavState extends LayoutStates {}
// banner Slider
class ChangeBannerSlideState extends LayoutStates {}
class HideBannersState extends LayoutStates {}
//welcome screen
class HideWelcomeMessageState extends LayoutStates {}
// View Selection Style
class ChangeViewSelectionState extends LayoutStates {}
//Rate Product
class RateProductState extends LayoutStates {}
// Rate the App
class RateAppLoadingState extends LayoutStates {}
class RateAppSuccessState extends LayoutStates {}
class RateAppErrorState extends LayoutStates {
 final String error ;
 RateAppErrorState(this.error);
}

// class ToggleExpandedCartsState extends LayoutStates {}
/// METHODS
// GET HOME DATA
class GetHomeDataLoadingState extends LayoutStates {}
class GetHomeDataSuccessState extends LayoutStates {}
class GetHomeDataErrorState extends LayoutStates {
 final String error ;
 GetHomeDataErrorState(this.error);
}
class GetHomeProductsLoadingState extends LayoutStates {}
class GetHomeProductsSuccessState extends LayoutStates {}

//favourites
class ToggleLikeButtonState extends LayoutStates {}
class ChangeFavouritesSuccessState extends LayoutStates {
 final ChangeFavouritesModel ? changeFavouritesModel;

  ChangeFavouritesSuccessState({this.changeFavouritesModel});
}
class ChangeFavouritesErrorState extends LayoutStates {
 final String error ;
 ChangeFavouritesErrorState(this.error);
}
class GetFavouritesLoadingState extends LayoutStates {}
class GetFavouritesSuccessState extends LayoutStates {
 final GetFavouritesModel ? getFavouritesModel;

  GetFavouritesSuccessState({this.getFavouritesModel});
}
class GetFavouritesErrorState extends LayoutStates {
 final String error ;
 GetFavouritesErrorState(this.error);
}
// //carts
class ToggleCartButtonState extends LayoutStates {}
class ChangeCartSuccessState extends LayoutStates {
 final ChangeCartModel ? changeCartModel;

  ChangeCartSuccessState({this.changeCartModel});
}
class ChangeCartErrorState extends LayoutStates {
 final String error ;
 ChangeCartErrorState(this.error);
}
class GetCartLoadingState extends LayoutStates {}
class GetCartSuccessState extends LayoutStates {
 final GetCartsModel ? getCartsModel;

  GetCartSuccessState({this.getCartsModel});
}
class GetCartErrorState extends LayoutStates {
 final String error ;
 GetCartErrorState(this.error);
}
// update carts
class UpdateCartLoadingState extends LayoutStates {}
class UpdateCartSuccessState extends LayoutStates {
 final UpdateCartModel ? updateCartModel;

 UpdateCartSuccessState(this.updateCartModel);
}
class UpdateCartErrorState extends LayoutStates {
 final String error ;
 UpdateCartErrorState(this.error);
}


//profile
class GetProfileLoadingState extends LayoutStates {}
class GetProfileSuccessState extends LayoutStates {}
class GetProfileErrorState extends LayoutStates {
 final String error ;
 GetProfileErrorState(this.error);
}
class UpdateProfileLoadingState extends LayoutStates {}
class UpdateProfileSuccessState extends LayoutStates {
 final AuthModel updatedProfile;

  UpdateProfileSuccessState(this.updatedProfile);

}
class UpdateProfileErrorState extends LayoutStates {
 final String error ;
 UpdateProfileErrorState(this.error);
}

class ToggleEditProfileState extends LayoutStates {}



// pick image
class ImagePickedSuccessState extends LayoutStates{}
class ImagePickedErrorState extends LayoutStates{}


//sign out
class SignOutSuccessState extends LayoutStates {
 final SignOutModel signOutModel;
  SignOutSuccessState(this.signOutModel);

}
class SignOutErrorState extends LayoutStates {
 final String error ;
 SignOutErrorState(this.error);
}
//send email verification
class SendVerificationLoadingState extends LayoutStates {}
class SendVerificationSuccessState extends LayoutStates {
 final EmailVerificationModel verifyEmailModel;
  SendVerificationSuccessState(this.verifyEmailModel);
}
class SendVerificationErrorState extends LayoutStates {
 final String error ;
 SendVerificationErrorState(this.error);
}
//verify code
class VerifyCodeLoadingState extends LayoutStates {}
class VerifyCodeSuccessState extends LayoutStates {
 final VerifyCodeModel ? verifyCodeModel;

  VerifyCodeSuccessState(this.verifyCodeModel);
}
class VerifyCodeErrorState extends LayoutStates {
 final String error ;
 VerifyCodeErrorState(this.error);
}
//change password
 class ChangePasswordLoadingState extends LayoutStates {}

class ChangePasswordSuccessState extends LayoutStates {
 final ChangePasswordModel ? changePasswordModel;

  ChangePasswordSuccessState(this.changePasswordModel);
}
class ChangePasswordErrorState extends LayoutStates {
 final String error ;
 ChangePasswordErrorState(this.error);
}
class TogglePasswordVisibilityState extends LayoutStates{}
class EnableUpdateButtonState extends LayoutStates{}

// get banners
class GetBannersLoadingState extends LayoutStates {}
class GetBannersSuccessState extends LayoutStates {}
class GetBannersErrorState extends LayoutStates {
 final String error ;
  GetBannersErrorState(this.error);
}
// get Categories
class GetCategoriesLoadingState extends LayoutStates {}
class GetCategoriesSuccessState extends LayoutStates {}
class GetCategoriesErrorState extends LayoutStates {
 final String error ;
 GetCategoriesErrorState(this.error);
}
// get category products
class GetCategoryProductsLoadingState extends LayoutStates {}
class GetCategoryProductsSuccessState extends LayoutStates {}
class GetCategoryProductsErrorState extends LayoutStates {
 final String error ;
 GetCategoryProductsErrorState(this.error);
}

// Search
class SearchProductLoadingState extends LayoutStates {}
class SearchProductSuccessState extends LayoutStates {}
class SearchProductErrorState extends LayoutStates {
 final String error ;
 SearchProductErrorState(this.error);
}
// productDetails
class GetProductDetailsLoadingState extends LayoutStates {}
class GetProductDetailsSuccessState extends LayoutStates {}
class GetProductDetailsErrorState extends LayoutStates {
 final String error ;
 GetProductDetailsErrorState(this.error);
}

// addresses
class GetAddressesLoadingState extends LayoutStates {}
class GetAddressesSuccessState extends LayoutStates {}
class GetAddressesErrorState extends LayoutStates {
 final String error ;
 GetAddressesErrorState(this.error);
}
class DeleteAddressLoadingState extends LayoutStates {}

class DeleteAddressSuccessState extends LayoutStates {
final DeleteAddressModel ? deleteAddressModel;
DeleteAddressSuccessState(this.deleteAddressModel);
}
class DeleteAddressErrorState extends LayoutStates {
 final String error ;
 DeleteAddressErrorState(this.error);
}

