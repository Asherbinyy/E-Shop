import 'package:bloc/bloc.dart';
import 'package:e_shop/models/api/change_favourites_model.dart';
import 'package:e_shop/models/api/get_favourites_model.dart';
import 'package:e_shop/models/api/home.dart';
import 'package:e_shop/models/api/profile.dart';
import 'package:e_shop/models/api/search_model.dart';
import 'package:e_shop/models/api/sign_out.dart';
import 'package:e_shop/models/api/verify_code.dart';
import 'package:e_shop/models/api/email_verification.dart';
import 'package:e_shop/modules/home/category/categories_screen.dart';
import 'package:e_shop/styles/constants.dart';
import '/models/api/banners.dart';
import '/models/api/categories.dart';
import '/models/app/tab_bar_model.dart';
import '/network/remote/dio_helper.dart';
import '/network/remote/end_points.dart';
import '/layout/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  /// LAYOUT : -----------------------------------------------------------------
//appbar
  /// pinned in anywhere otherwise home screen
  // bool isAppBarPinned = false;

// Bottom Nav Bar
  int currentIndex = 0;
  bool isHome = true;
  void changeBottomNav(int index) {
    currentIndex = index;
    if (index == 0) {
      isHome = true;
      // isAppBarPinned=false;
    } else {
      if (index == 1) getFavourites();

      isHome = false;
      // isAppBarPinned=false ;
    }

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
  bool isWelcomeMessageVisible = true;

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

  /// METHODS : ----------------------------------------------------------------
  List<HomeProducts>? shuffleHomeLists(List<HomeProducts>? list) {
    list?.shuffle();
    return list;
  }

  // Home Data
  HomeModel? homeModel;
  //
  // List <HomeProducts> ? products = [];
  // List <HomeProducts> ? randomProducts = [];
  // List <HomeProducts> ? offerProducts = [];
  // List <HomeProducts> ? highPriceProducts = [];
  // List getProducts (HomeProducts products){
  //
  // }

  /// This map should take : product Id (key) and returns >> isLiked bool (value)
  Map<int, bool>? favourites = {};
  void _fillFavourites(HomeProducts element) {
    if (element.id != null && element.inFavorites != null)
      favourites?.addAll({element.id!: element.inFavorites!});
    else
      throw 'something went wrong when adding favourites';
  }

  void getHomeData() {
    emit(GetHomeDataLoadingState());
    DioHelper.getData(url: HOME, token: '$token').then((value) {
      if (value.statusCode == 200) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel?.data?.products?.forEach((element) {
          _fillFavourites(element);
        });

        // products = homeModel?.data?.products;
        // // random products
        // randomProducts = shuffleHomeLists(homeModel?.data?.products);
        // products?.forEach((element) {
        //   // offer products
        //   if (element.discount != 0) offerProducts?.add(element);
        //
        //   highPriceProducts = products;
        //
        //   highPriceProducts?.sort((a, b) =>
        //       a.price
        //           .toString()
        //           .length
        //           .compareTo(b.price
        //           .toString()
        //           .length));
        //   highPriceProducts?.forEach((element) {
        //     print(element.price);
        //   });
        // });
        emit(GetHomeDataSuccessState());
      }
    }).catchError((error) {
      print('Error in Getting Home Data is : $error');
      emit(GetHomeDataErrorState(error.toString()));
    });
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

  //profile
  ProfileModel? profileModel;

  void getProfile() {
    emit(GetProfileLoadingState());

    DioHelper.getData(url: PROFILE, token: '$token').then(
      (value) {
        if (value.statusCode == 200) {
          profileModel = ProfileModel.fromJson(value.data);
          print(value.data);
          emit(GetProfileSuccessState());
        }
      },
    ).catchError((error) {
      emit(GetProfileErrorState(error.toString()));
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

      emit(SignOutSuccessState(signOutModel!));
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

    DioHelper.postData(url: VERIFYEMAIL, data: {
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
    DioHelper.postData(url: VERIFYCODE, data: {
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
          print(element);
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

      emit(SearchProductSuccessState());
    }).catchError((error) {
      print('Error in Searching For product is : $error');
      emit(SearchProductErrorState(error));
    });
  }
}
