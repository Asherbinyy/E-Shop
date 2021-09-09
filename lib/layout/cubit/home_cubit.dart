import 'package:bloc/bloc.dart';
import 'package:e_shop/models/api/home.dart';
import 'package:e_shop/models/api/profile.dart';
import 'package:e_shop/models/api/sign_out.dart';
import 'package:e_shop/models/api/verify_code.dart';
import 'package:e_shop/models/api/email_verification.dart';
import 'package:e_shop/modules/main_home/category/categories_screen.dart';
import 'package:e_shop/shared/components/methods/methods.dart';
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
  bool isAppBarShown = true;
// Bottom Nav Bar
  int currentIndex = 0;
  bool isHome = true;
  void changeBottomNav(int index) {
    currentIndex = index;
    if (index == 0)
      isHome = true;
    else
      isHome = false;
    emit(ChangeBottomNavState());
  }

// carousel banner slider
  int bannerSlideIndex = 0;
  void changeBannerSlide(int index) {
    bannerSlideIndex = index;
    emit(ChangeBannerSlideState());
  }

  // Welcome Message
  bool isWelcomeMessageVisible = true ;
  void hideWelcomeMessage (){
     isWelcomeMessageVisible = false ;
    emit(HideWelcomeMessageState());

  }
  /// METHODS : ----------------------------------------------------------------


  // Home Data
  HomeModel ? homeModel;
  // List <HomeProducts> ? randomProducts = [];
  List products = [] ;

  void getHomeData (){
    emit(GetHomeDataLoadingState());
    DioHelper.getData(url: HOME,token:'$token').then((value) {
      if (value.statusCode==200){
        homeModel=HomeModel.fromJson(value.data);

        // randomProducts = shuffleList(homeModel?.data?.products);

        emit(GetHomeDataSuccessState());

      }
    }).catchError((error){
      print('Error in Getting Home Data is : $error');
      emit(GetHomeDataErrorState(error.toString()));
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
  bool isEmailVerified = false ;
  void verifyCode({
    required String code,
  }) {
    VerifyCodeModel ? verifyCodeModel;
    emit(VerifyCodeLoadingState());
    DioHelper.postData(url: VERIFYCODE, data: {
      "email": profileModel?.data?.email,
      "code": code,
    })
        .then((value) {
          if (value.statusCode==200){
            verifyCodeModel = VerifyCodeModel.fromJson(value.data);
            if (verifyCodeModel!.status!) isEmailVerified = true;
            emit(VerifyCodeSuccessState(verifyCodeModel));
          }
    })
        .catchError((error) {
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
              '${element.name}', CategoryScreen(label: '${element.name}')));
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
}
