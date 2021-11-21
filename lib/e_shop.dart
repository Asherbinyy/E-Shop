import 'package:e_shop/modules/auth/login/view/login_imports.dart';
import 'package:e_shop/modules/auth/register/view/register_imports.dart';
import 'package:e_shop/modules/cart/controller/cart_cubit.dart';
import 'package:e_shop/modules/cart/view/cart_imports.dart';
import 'package:e_shop/modules/home/all/all_screen.dart';
import 'package:e_shop/modules/profile/view/profile_screen.dart';
import 'package:e_shop/modules/setting/view/setting_screen.dart';
import 'package:e_shop/modules/welcome_message/view/import_welcome_messages.dart';
import 'package:e_shop/services/methods/app_initializer_service.dart';
import 'package:e_shop/services/methods/starting_widget.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_state.dart';
import 'package:e_shop/shared/models/app/cached_settings.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:e_shop/styles/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'generated/codegen_loader.g.dart';
import 'modules/landing/view/landing_imports.dart';
import 'modules/layout/cubit/home_cubit.dart';
import 'modules/layout/layout_screen.dart';
///flutter pub run easy_localization:generate --source-dir ./assets/translations

class EShop extends StatelessWidget {

  final CachedSettingsModel settings ;
  const EShop({
    Key? key,
    required this.settings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return EasyLocalization(
            path: 'assets/translations',
            supportedLocales: [
              Locale('en'),
              Locale('ar'),
            ],
            fallbackLocale: Locale('en'),
            assetLoader: CodegenLoader(),
            // saveLocal    e: true,
            child:MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => AppCubit()
                    ..changeAppThemeModeSwitch(isDarkFromSharedPref: settings.isDark)
                    ..changeAppColors(cachedIndex: settings.colorIndex)
                    ..changeFontSize(cachedFontSize: settings.appFontSize),
                ),
                BlocProvider(
                  create: (context) => LayoutCubit()
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
                    // home:  LoginScreen (),
                    home:  getStartingWidget(landing),
                  );
                },
              ),
            ),
        );
  }
}  // runApp(
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
