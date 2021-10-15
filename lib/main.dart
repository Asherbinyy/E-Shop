import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:e_shop/generated/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import '/models/app/cached_settings.dart';
import '/shared/components/methods/operating_system_options.dart';
import '/network/local/cached_values.dart';
import '/network/remote/dio_helper.dart';
import '/styles/constants.dart';
import 'package:flutter/foundation.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/layout_screen.dart';
import '/network/local/cache_helper.dart';
import '/shared/cubit/app_cubit.dart';
import '/shared/cubit/app_state.dart';
import '/styles/bloc_observer.dart';
import '/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/landing/landing_screen.dart';
import 'shared/components/methods/starting_widget.dart';
///flutter pub run easy_localization:generate --source-dir ./assets/translations


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();

  DioHelper.init();

 //cached Data
  bool? landing = CacheHelper.getData(LANDING);
  stopWelcome = CacheHelper.getData(STOP_WELCOME) ?? false;
  token = CacheHelper.getData(TOKEN);
  appLanguage = CacheHelper.getData(APP_LANGUAGE);


  // sys orientation
  await OperatingSystemOptions.fixedOrientation();
  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: [Locale('en'),Locale('ar'),],
    fallbackLocale: Locale('en'),
    assetLoader: CodegenLoader(),
    // saveLocale: true,
    child: EShop(
      settings: CachedSettingsModel(
        colorIndex: CacheHelper.getData(COLOR_INDEX)??2,
        isDark:CacheHelper.getData(DARK_MODE) ?? false,
        fontSize: CacheHelper.getData(FONT_SIZE)??1.0,
      ),
      startingWidget: getStartingWidget(landing),
    ),
  ));



  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context)=> EShop(
  //       settings: CachedSettingsModel(
  //         colorIndex: CacheHelper.getData(COLOR_INDEX)??2,
  //         isDark:CacheHelper.getData(DARK_MODE) ?? false,
  //         fontSize: CacheHelper.getData(FONT_SIZE)??1.0,
  //       ),
  //       startingWidget: getStartingWidget(landing),
  //     ),
  //   ),
  // );
}
class EShop extends StatelessWidget {

  final Widget startingWidget;
  final CachedSettingsModel settings ;
  const EShop({
    Key? key,
    required this.startingWidget,
    required this.settings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..changeAppThemeModeSwitch(isDarkFromSharedPref: settings.isDark)
            ..changeAppColors(cachedIndex: settings.colorIndex)
          ..changeFontSize(cachedFontSize: settings.fontSize),
        ),
        BlocProvider(
          create: (context) => HomeCubit()
            ..getHomeData()
            ..getProfile()
            ..getFavourites()
            ..getCarts()
            ..searchProduct('')//See Explain under search product method in home cubit
            ..getCategories()
            ..getBanners(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            // locale: DevicePreview.locale(context), // Add the locale here
            // builder: DevicePreview.appBuilder, // Add the builder here
            debugShowCheckedModeBanner: false,
            title: 'E-Shop',
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            theme: lightMode,
            darkTheme: darkMode,
            routes: {
              /// Add routes here !
              LandingScreen.id: (context) => LandingScreen(),
              LayoutScreen.id: (context) => LayoutScreen(),
            },
            home: startingWidget,
          );
        },
      ),
    );
  }
}
