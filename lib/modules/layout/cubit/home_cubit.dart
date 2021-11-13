import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:e_shop/helpers/local/shared_pref/cache_helper.dart';
import 'package:e_shop/helpers/local/shared_pref/cached_values.dart';
import 'package:e_shop/helpers/remote/dio_helper.dart';
import 'package:e_shop/helpers/remote/end_points.dart';
import 'package:e_shop/modules/auth/models/auth_model.dart';
import 'package:e_shop/shared/models/api/addresses/delete_address.dart';
import 'package:e_shop/shared/models/api/addresses/get_addresses.dart';
import 'package:e_shop/shared/models/api/banners/banners.dart';
import 'package:e_shop/shared/models/api/carts/change_cart.dart';
import 'package:e_shop/shared/models/api/carts/get_carts.dart';
import 'package:e_shop/shared/models/api/carts/update_cart.dart';
import 'package:e_shop/shared/models/api/categories/categories.dart';
import 'package:e_shop/shared/models/api/categories/category_products.dart';
import 'package:e_shop/shared/models/api/favourites/change_favourites.dart';
import 'package:e_shop/shared/models/api/favourites/get_favourites.dart';
import 'package:e_shop/shared/models/api/home/home.dart';
import 'package:e_shop/shared/models/api/products/product_details.dart';
import 'package:e_shop/shared/models/api/search/search.dart';
import 'package:e_shop/shared/models/api/user/change_password.dart';
import 'package:e_shop/shared/models/api/user/email_verification.dart';
import 'package:e_shop/shared/models/api/user/profile.dart';
import 'package:e_shop/shared/models/api/user/sign_out.dart';
import 'package:e_shop/shared/models/api/user/verify_code.dart';
import 'package:e_shop/shared/models/app/sort_by.dart';
import 'package:e_shop/shared/models/app/tab_bar.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/modules/home/category/categories_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);


  /// LAYOUT : --------------------------------------------------------------------------------------------------------------------
//appbar
  /// pinned in anywhere otherwise home screen
  // bool isAppBarPinned = false;

// Bottom Nav Bar

  int currentIndex =  CacheHelper.getData(BOTTOM_NAV_INDEX) ?? 0;
  bool isHome = true;
  bool hideSearchBar = false;
  void changeBottomNav(int index) {
    currentIndex = index;
    if (index == 0) {
      isHome = true;
      hideSearchBar=false;
    } else {
      hideSearchBar=true;

      if (index == 1) {
        getFavourites();
        hideSearchBar=false;
      }
      if (index == 2){
        getAddresses();
      }
      isHome = false;
    }
    CacheHelper.saveData(BOTTOM_NAV_INDEX, currentIndex);
    emit(ChangeBottomNavState());
  }
  //  banner slider
  int bannerSlideIndex = 0;
  void changeBannerSlide(int index) {
    bannerSlideIndex = index;
    emit(ChangeBannerSlideState());
  }
  bool isBannerShown = true;
  void hideBanners() {
    isBannerShown = false;
    emit(HideBannersState());
  }

  // Welcome Message
  bool isWelcomeMessageVisible = true; /// Todo save in shared pref

  void hideWelcomeMessage() {
    isWelcomeMessageVisible = false;
    emit(HideWelcomeMessageState());
  }

  // View selection style
  String initialViewValue = '';
  bool isGrid = true;

  void changeViewSelection(String value) {
    initialViewValue = value;
    if (initialViewValue == 'Grid')
      isGrid = true;
    else
      isGrid = false;
    emit(ChangeViewSelectionState());
  }

  // Rating Products
  double? userRating;

  void rateProduct(double rating) {
    userRating = rating;
    emit(RateProductState());
  }
  // Rate the App
  void rateApp (){
    emit(RateAppLoadingState ());
    Future.delayed(Duration(seconds: 1)).then((value) {
      ///ToDo In Future : update this with firebase ابعت الريت و المسج للفايربيز
      emit(RateAppSuccessState());
    }).catchError((error){
      emit(RateAppErrorState(error));
    });
  }

  // expand  cart tiles
  bool isExpandedCarts=false;
  void toggleExpandedCarts(){
    isExpandedCarts = !isExpandedCarts;
    emit(ToggleExpandedCartsState());

  }
  /// METHODS : ----------------------------------------------------------------
  List<HomeProducts>? shuffleHomeLists(List<HomeProducts>? list) {
    list?.shuffle();
    return list;
  }

  // Home Data
  HomeModel? homeModel;
  List <HomeProducts> ? popularProducts = [];
  List <HomeProducts> ? randomProducts = [];
  List <HomeProducts> ? offerProducts = [];
  List <HomeProducts> ? higherPriceProducts = [];
  List <HomeProducts> ? lowerPriceProducts = [];


  /// This map should take : product Id (key) and returns >> isLiked bool (value)
  Map<int, bool>? favourites = {};
  Map<int, bool>? carts = {};
  void _fillFavourites (HomeProducts element) {

    if (element.id != null && element.inFavorites != null)
      favourites?.addAll({element.id!: element.inFavorites!});
    else
      throw 'error_adding_fav'.tr();
  }
  void _fillCarts (HomeProducts element){
    if (element.id != null && element.inCart != null)
      carts?.addAll({element.id!: element.inCart!});
    else
      throw 'error_adding_carts'.tr();
  }


  void _fillProductLists (HomeProducts element) {
    //popular products
    popularProducts?.add(element);
    // random products
    randomProducts?.add(element);
    shuffleHomeLists(randomProducts);
    // offer Products
    if (element.discount != 0) offerProducts?.add(element);
    // low To high
    lowerPriceProducts?.add(element);

    lowerPriceProducts?.sort((a, b) =>
        a.price
            .toString()
            .length
            .compareTo(b.price
            .toString()
            .length));
    lowerPriceProducts?.forEach((element) {
    });
    // high To low
    higherPriceProducts?.addAll(lowerPriceProducts!);
    higherPriceProducts?.reversed;
  }

  void getHomeData() {
    emit(GetHomeDataLoadingState());
    DioHelper.getData(url: HOME, token: '$token').then((value) {
      if (value.statusCode == 200) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel?.data?.products?.forEach((element) {
          _fillFavourites(element);
          _fillCarts(element);
          _fillProductLists(element);
          defaultHomeProduct?.add(element); // same as popular products
        });
        emit(GetHomeDataSuccessState());
      }
    }).catchError((error) {
      print('Error in Getting Home Data is : $error');
      emit(GetHomeDataErrorState(error.toString()));
    });
  }

  List<HomeProducts>? defaultHomeProduct =[];
 List <HomeProducts> ? getHomeProducts (SortByOptions options){

    // List <HomeProducts>? _list =[];
    defaultHomeProduct = [];
    emit(GetHomeProductsLoadingState());
    switch (options){
      case SortByOptions.POPULAR:
      defaultHomeProduct = popularProducts;
      print('You got popularProducts ');
      break;
      case SortByOptions.RANDOM:
        defaultHomeProduct = randomProducts;
        print('You got randomProducts ');

        break;
      case SortByOptions.OFFERS:
        defaultHomeProduct = offerProducts;
        print('You got offerProducts ');

        break;
      case SortByOptions.LOWER:
        defaultHomeProduct = lowerPriceProducts;
        print('You got lowerPriceProducts ');

        break;
      case SortByOptions.Higher:
        defaultHomeProduct = lowerPriceProducts?.reversed.cast<HomeProducts>().toList();
        print('You got higherPriceProducts ');
        break;
    }
    emit(GetHomeProductsSuccessState());
    return defaultHomeProduct;
  }
  // Change Favourites
  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int productId) {
    // toggle the button first in background
    favourites?[productId] = !favourites![productId]!;
    emit(ToggleLikeButtonState());

    DioHelper.postData(
      url: FAVOURITES,
      token: '$token',
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavouritesModel = ChangeFavouritesModel.fromJson(value.data);

      if (changeFavouritesModel?.status == false)
        // if error happens toggle back (status=false) ex : if not token
        favourites?[productId] = !favourites![productId]!;

      emit(ChangeFavouritesSuccessState(
          changeFavouritesModel: changeFavouritesModel));
    }).catchError((error) {
      // if error happens toggle back
      favourites?[productId] = !favourites![productId]!;
      print('Error in Changing Favourites is : $error');
      emit(ChangeFavouritesErrorState(error.toString()));
    });
  }
  // Change Carts
  ChangeCartModel? changeCartModel;
  void changeCarts (int productId) {
    // toggle the button first in background
    carts?[productId] = !carts![productId]!;
    emit(ToggleCartButtonState());

    DioHelper.postData(
      url: CARTS,
      token: '$token',
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeCartModel = ChangeCartModel.fromJson(value.data);

      if (changeCartModel?.status == false)
        // if error happens toggle back (status=false) ex : if not token
        carts?[productId] = !carts![productId]!;

      emit(ChangeCartSuccessState(changeCartModel : changeCartModel));
    }).catchError((error) {
      // if error happens toggle back
      carts?[productId] = !carts![productId]!;
      print('Error in Changing Cart is : $error');
      emit(ChangeCartErrorState(error.toString()));
    });
  }

  /// Whether The animation Dialogue plays again
  bool showFavouritesDialogue = true;
  // Get Favourites
  GetFavouritesModel? getFavouritesModel;
  void getFavourites() {
    getFavouritesModel = null;
    emit(GetFavouritesLoadingState());
    DioHelper.getData(url: FAVOURITES, token: '$token').then((value) {
      getFavouritesModel = GetFavouritesModel.fromJson(value.data);

      emit(GetFavouritesSuccessState(getFavouritesModel: getFavouritesModel));
      Future.delayed(Duration(seconds: 5))
          .then((value) => showFavouritesDialogue = false);
    }).catchError((error) {
      print('Error in Getting Favourites is : $error');
      emit(GetFavouritesErrorState(error.toString()));
    });
  }
  bool showCartsDialogue = true;
  // Get Carts
  GetCartsModel ? getCartsModel;
  // cart Id : amount
  Map  <int,int> cartAmount = {};
  void getCarts() {
    // getCartsModel = null;
    emit(GetCartLoadingState());
    DioHelper.getData(url: CARTS, token: '$token').then((value) {
      getCartsModel = GetCartsModel.fromJson(value.data);
      getCartsModel?.data?.cartItems?.forEach((element) {
       cartAmount.addAll({element.id!:element.quantity!});

      });


      emit(GetCartSuccessState(getCartsModel:  getCartsModel));
      Future.delayed(Duration(seconds: 5))
          .then((value) => showCartsDialogue = false);
    }).catchError((error) {
      print('Error in Getting Carts is : $error');
      emit(GetFavouritesErrorState(error.toString()));
    });
  }

  /// Updates the cart one by one using the GetCartsModel and queries / cartID
   UpdateCartModel ? updateCartModel;
   void updateCart (int cartID,CartOperation operation,{int ? dropDownAmount}){

     emit(UpdateCartLoadingState());
     int ? _amount =  cartAmount[cartID] ;
     if (operation==CartOperation.INCREMENT)
       _amount = cartAmount[cartID]! + 1  ; // old cart amount value
     else if ( (operation==CartOperation.DECREMENT)){
       if(cartAmount[cartID]! !=1 )
         _amount = cartAmount[cartID]! - 1 ;
     }
     else _amount =dropDownAmount;

     print(CARTS+'/$cartID');
     print(_amount);

     DioHelper.putData(
        url: '$CARTS/$cartID',
        data: {
          'quantity': _amount ,
        },
        token:'$token',
     ).then((value) {
        updateCartModel = UpdateCartModel.fromJson(value.data);
        getCarts();
        emit(UpdateCartSuccessState(updateCartModel));

        }).catchError((error){
          print('Error in Updating Card is : ${error.toString()}');
          emit(UpdateCartErrorState(error.toString()));
    });
   }


  ProfileModel? profileModel;
  void getProfile() {
    emit(GetProfileLoadingState());

    DioHelper.getData(url: PROFILE, token: '$token').then(
      (value) {
        if (value.statusCode == 200) {
          profileModel = ProfileModel.fromJson(value.data);
          emit(GetProfileSuccessState());
        }
      },
    ).catchError((error) {
      emit(GetProfileErrorState(error.toString()));
    });
  }
  //edit profile
  bool isEditableProfile = false ;
  void toggleEditProfile (){
    isEditableProfile = ! isEditableProfile;
    emit(ToggleEditProfileState());
  }
  //update profile
  AuthModel ? updatedProfile ;
  void updateProfile ({
  required String name ,
  required String email ,
  required String phone ,
  // required String name ,
}){
    emit(UpdateProfileLoadingState());

    DioHelper.putData(
        url: UPDATE_PROFILE,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
        },
        token: '$token',
    ).then((value) {

      updatedProfile = AuthModel.fromJson(value.data);
      print(updatedProfile?.data?.name);
      emit(UpdateProfileSuccessState(updatedProfile!));
      getProfile();
    }
    ).catchError((error){
      print('Error in Updating Profile is :${error.toString()} ');
      emit(UpdateProfileErrorState(error.toString()));
    });
  }
  // ImagePicker from camera or gallery--------------------------------------------
  File? pickedImage;
 void pickImage () {
    ImagePicker().pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        pickedImage = File(value.path);
        emit(ImagePickedSuccessState());
      }
    }).catchError((e) {
      emit(ImagePickedErrorState());
      print(e.toString());
    });
  }
  // Sign Out
  SignOutModel? signOutModel;

  void signOut() {
    DioHelper.postData(
            url: LOGOUT,
            data: {
              'fcm_token': 'SomeFcmToken',

              /// TODO : this should be updated later .
            },
            token: '$token')
        .then((value) {
      signOutModel = SignOutModel.formJson(value.data);
    }).catchError((error) {
      print('Error in Signing Out user is : $error');
      emit(SignOutErrorState(error));
    });
  }

  // verifyEmail
  bool isVerificationSent = false;
  EmailVerificationModel? emailVerificationModel;

  void sendEmailVerification() {
    emit(SendVerificationLoadingState());

    DioHelper.postData(url: VERIFY_EMAIL, data: {
      'email': profileModel?.data?.email,

      /// userModel email
    }).then((value) {
      if (value.statusCode == 200) {
        emailVerificationModel = EmailVerificationModel.fromJson(value.data);

        if (emailVerificationModel!.status!) isVerificationSent = true;
        emit(SendVerificationSuccessState(emailVerificationModel!));
      }
    }).catchError((error) {
      print('Error in Verifying Email is : ${error.toString()}');
      emit(SendVerificationErrorState(error.toString()));
    });
  }

  // verify code
  bool isEmailVerified = false;

  void verifyCode({
    required String code,
  }) {
    VerifyCodeModel? verifyCodeModel;
    emit(VerifyCodeLoadingState());
    DioHelper.postData(url: VERIFY_CODE, data: {
      "email": profileModel?.data?.email,
      "code": code,
    }).then((value) {
      if (value.statusCode == 200) {
        verifyCodeModel = VerifyCodeModel.fromJson(value.data);
        if (verifyCodeModel!.status!) isEmailVerified = true;
        emit(VerifyCodeSuccessState(verifyCodeModel));
      }
    }).catchError((error) {
      print('Error in Verifying Code  is : ${error.toString()}');
      emit(VerifyCodeErrorState(error.toString()));
    });
  }

  // change password
  ChangePasswordModel? _changePasswordMode ;
  void changePassword ({
  required String oldPassword,
  required String newPassword,
}){
    emit(ChangePasswordLoadingState());
    DioHelper.postData(url: CHANGE_PASSWORD,token: '$token', data: {
      "current_password":oldPassword,
      "new_password": newPassword,
    }).then((value) {
      if (value.statusCode == 200) {
        _changePasswordMode = ChangePasswordModel.fromJson(value.data);
        emit(ChangePasswordSuccessState(_changePasswordMode));
      }
    }).catchError((error) {
      print('Error in Verifying Code  is : ${error.toString()}');
      emit(ChangePasswordErrorState(error.toString()));
    });
  }

  bool isPassword = true ;
  IconData passwordSuffix = Icons.visibility_off;
  void togglePasswordVisibility (){
    isPassword?
    passwordSuffix =Icons.visibility : passwordSuffix=Icons.visibility_off;
    isPassword = ! isPassword;
    emit(TogglePasswordVisibilityState());
  }
 //update password button
  bool isUpdateButtonDisabled = true ;
  void checkUpdateButtonDisable (String _currentPass,String newPass){
     if (_currentPass.isNotEmpty && newPass.isNotEmpty )isUpdateButtonDisabled = false;
     else isUpdateButtonDisabled = true ;
     emit(EnableUpdateButtonState());
  }
  // get banners
  List<BannerData> banners = [];

  void getBanners() {
    emit(GetBannersLoadingState());

    ///not used

    DioHelper.getData(url: BANNERS).then((value) {
      if (value.statusCode == 200) {
        BannerModel.fromJson(value.data).data?.forEach((element) {
          banners.add(element);
        });
        emit(GetBannersSuccessState());
      }
    }).catchError((error) {
      print('Error in Getting Banners is : $error');
      emit(GetBannersErrorState(error));
    });
  }

  // get categories
  CategoriesModel? categoriesModel;
  /// not used
  List<TabBarModel> tabBarData = [];
  /// Used in Tab bar onTap to get data depends on the category #
  Map <String?,int?> categoriesIDs = {};
  void getCategories() {
    emit(GetCategoriesLoadingState());
    /// not used

    DioHelper.getData(url: CATEGORIES).then((value) {
      if (value.statusCode == 200) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        List<TabBarModel> categoriesTitles = [];
        categoriesModel?.categoriesData?.dataList?.forEach((element) {
          categoriesTitles.add(TabBarModel(
              label: '${element.name}', screen: CategoryScreen(element)));

          categoriesIDs.addAll({element.name:element.id});

        });

        /// spread operator
        tabBarData = [...TabBarModel.staticTabs, ...categoriesTitles];
        emit(GetCategoriesSuccessState());
      }
    }).catchError((error) {
      print('Error in Getting Categories is : $error');
      emit(GetCategoriesErrorState(error));
    });
  }
 // category Products
 CategoryProductModel ? categoryProductModel;
  void getCategoryProducts (int categoryID){
    emit(GetCategoryProductsLoadingState());

    DioHelper.getData(
        url: PRODUCTS,
      token: '$token',
      query: {
          'category_id':categoryID,
      },
    ).
    then((value) {
      categoryProductModel=CategoryProductModel.fromJson(value.data);

      emit(GetCategoryProductsSuccessState());

    }
    ).catchError((error){
      emit(GetCategoryProductsErrorState(error.toString()));
      print('Error in Getting Category Products is : $error');
    });
  }


  // search
  SearchModel ? searchModel ;
  void searchProduct(String searchText) {
    searchModel=null;
    emit(SearchProductLoadingState());

    DioHelper.postData(
        url: SEARCH,
        data: {
          'text':searchText,
        },
    ).then((value) {

      searchModel=SearchModel.fromJson(value.data);
      // Because HomeData don't have full products and I wanna get rest of products
      // after a quick tries i found that searching '' returns all Data
      /// This method is called in main.dart
      /// We updated favourites & Carts with the rest data which weren't in the
      /// Home Api
      if (searchText==''){
        searchModel?.data?.data?.forEach((element) {
         _updateFavourites(element);
         _updateCarts(element);
        });
      }

      emit(SearchProductSuccessState());
    }).catchError((error) {
      print('Error in Searching For product is : $error');
      emit(SearchProductErrorState(error.toString()));
    });
  }
  void _updateFavourites (ProductSearchData element) {
    if (element.id != null && element.inFavorites != null)
      favourites?.addAll({element.id!: element.inFavorites!});
    else
      throw 'error_updating_fav'.tr();
  }
  void _updateCarts (ProductSearchData element){
    if (element.id != null && element.inCart != null)
      carts?.addAll({element.id!: element.inCart!});
    else
      throw 'error_updating_carts'.tr();
  }



  // productDetails

  ProductDetailsModel ?  productDetailsModel;

  void getProductDetails(int productID){
    productDetailsModel=null;
    emit(GetProductDetailsLoadingState());

    DioHelper.getData(
      url: '$PRODUCTS/$productID',
      token: '$token',
    ).then((value) {

      productDetailsModel=ProductDetailsModel.fromJson(value.data);

      emit(GetProductDetailsSuccessState());
    }).catchError((error) {
      print('Error in Getting Product Details is : $error');
      emit(GetProductDetailsErrorState(error.toString()));
    });
  }


// addresses
// get
  GetAddressModel ? addressModel ;
  void getAddresses (){
    addressModel=null;
    emit(GetAddressesLoadingState());

    DioHelper.getData(
        url: ADDRESSES,
        token: '$token',
    ).then((value) {
      if (value.statusCode == 200) {
        addressModel = GetAddressModel.fromJson(value.data);
        emit(GetAddressesSuccessState());
      }
    }).catchError((error) {
      print('Error in Getting Addresses Data is : $error');
      emit(GetAddressesErrorState(error.toString()));
    });

  }

  // delete
DeleteAddressModel ? _deleteAddressModel;
void deleteAddress(int addressId){
  emit(DeleteAddressLoadingState());
  DioHelper.deleteData(url: '$ADDRESSES/$addressId',token: '$token').then((value) {
    _deleteAddressModel=DeleteAddressModel.fromJson(value.data);
    emit(DeleteAddressSuccessState(_deleteAddressModel));
  }).catchError((error){
    print('Error in Deleting Address Details is : ${error.toString()}');
    emit(DeleteAddressErrorState(error));
  });
}
}

enum CartOperation{INCREMENT,DECREMENT,ONCHANGE}