import 'package:bloc/bloc.dart';
import 'package:e_shop/models/api/banners_model.dart';
import 'package:e_shop/models/api/categories_model.dart';
import 'package:e_shop/network/remote/dio_helper.dart';
import 'package:e_shop/network/remote/end_points.dart';
import 'package:e_shop/styles/constants.dart';
import '/layout/cubit/home_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  /// LAYOUT : -------------------------------------------------------------------
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

//TabBar
// carousel
  int bannerSlideIndex = 0;
  void changeBannerSlide(int index) {
    bannerSlideIndex = index;
    emit(ChangeBannerSlideState());
  }

  /// METHODS : -------------------------------------------------------------------
  // get banners
  List<BannerData> banners = [];
  void getBanners() {
    emit(GetBannersLoadingState()); ///not used

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

  void getCategories() {

    emit(GetCategoriesLoadingState()); /// not used

    DioHelper.getData(url: CATEGORIES)
        .then((value) {
      if (value.statusCode == 200) {

       categoriesModel=CategoriesModel.fromJson(value.data);

        emit(GetCategoriesSuccessState());
      }
    }).
    catchError((error) {
      print('Error in Getting Categories is : $error');
      emit(GetCategoriesErrorState(error));
    });
  }
}
