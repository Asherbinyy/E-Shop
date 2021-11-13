import 'package:bloc/bloc.dart';
import 'package:e_shop/helpers/local/shared_pref/cache_helper.dart';
import 'package:e_shop/helpers/local/shared_pref/cached_values.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/modules/addresses/new_address/cubit/address_states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);



// // ThemeMode toggling ----------------------------------------------------------
  bool isDark = true ;

//   IconData modeIcon = Icons.dark_mode ;
  bool  changeAppThemeModeSwitch ({ bool ? isDarkFromSharedPref }){

    if (isDarkFromSharedPref != null ){
      isDark = isDarkFromSharedPref ;
      emit(AppChangeThemeModeState());
      return isDark ;
    }
    else {
      isDark = ! isDark ;
      // from button press
      CacheHelper.saveData(DARK_MODE, isDark).then((value) {
        emit(AppChangeThemeModeState());
      });
      return isDark ;
    }

  }


// ----------------------------------------------------------------------------


  // dropdown Setting country

  String initialValue = 'EG';
  void changeCountryValue(String newValue) {
    initialValue = newValue;
    emit(ChangeCountryValueState());
  }
  /// Change App Colors ------------------------------------------------------------
  void changeAppColors({int ? index,int ? cachedIndex}){
    if (cachedIndex != null ){
      colorIndex = cachedIndex ;
      emit(ChangeAppColorsSuccessState());
    }
    else {
      colorIndex =index ;
      CacheHelper.saveData(COLOR_INDEX, index).then((value) {
        emit(ChangeAppColorsSuccessState());

      }).catchError((error){
        emit(ChangeAppColorsErrorState(error.toString()));
      });
    }
    // kPrimaryColor = Palette.colors[index];
  }
  /// Font Size Slider ------------------------------------------------------------
  double fontSizeValue = 1.0 ;
  void changeFontSize ({ double ? newValue , double ? cachedFontSize}){
    if (cachedFontSize != null) {
      fontSizeValue = cachedFontSize ;
      emit(ChangeFontSizeState ());

    }
    else {
      fontSizeValue = newValue! ;
      CacheHelper.saveData(FONT_SIZE, fontSizeValue).then((value) {
        emit(ChangeFontSizeState ());
      });
    }

  }
  void restoreFontSize (){
    CacheHelper.removeData(FONT_SIZE).then((value) {
      fontSizeValue = 1.0;
      changeFontSize(newValue: fontSizeValue);
      emit(RestoreFontSizeState())  ;
    });

  }
  /// Change App Language ------------------------------------------------------------

  // from Dropdown in settings
  void changeLanguage (String  newValue,BuildContext context){
    appLanguage = newValue ;
    context.setLocale(Locale(newValue)).then((_) {
      CacheHelper.saveData(APP_LANGUAGE, newValue).then((value) {
        if (value) emit(ChangeLanguageSuccessState());
      },);
    }).catchError((error){
      print('change language error is : $error');
      emit(ChangeLanguageErrorState(error.toString()));

    });

  }





}
