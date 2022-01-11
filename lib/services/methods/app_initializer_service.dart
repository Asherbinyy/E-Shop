import 'package:bloc/bloc.dart';
import 'package:e_shop/helpers/local/shared_pref/cache_helper.dart';
import 'package:e_shop/helpers/local/shared_pref/cached_values.dart';
import 'package:e_shop/helpers/remote/dio_helper.dart';
import 'package:e_shop/modules/auth/models/user_model.dart';
import 'package:e_shop/services/firebase_service/firestore_user_service.dart';
import 'package:e_shop/services/methods/operating_system_options.dart';
import 'package:e_shop/shared/bloc_observer.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AppInitializer {
  AppInitializer._();

  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = MyBlocObserver();
    await CacheHelper.init();
    await Firebase.initializeApp();
    await EasyLocalization.ensureInitialized();
    DioHelper.init();
    //cached Data
    landing = CacheHelper.getData(LANDING);
    stopWelcome = CacheHelper.getData(STOP_WELCOME) ?? false;
    token = CacheHelper.getData(TOKEN);
    uId = CacheHelper.getData(UID);
    appLanguage = CacheHelper.getData(APP_LANGUAGE);
    // sys orientation
    await OperatingSystemOptions.fixedOrientation();
  }
}