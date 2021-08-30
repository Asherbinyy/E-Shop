import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:e_shop/network/remote/dio_helper.dart';
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
import 'modules/login/login_screen.dart';
import 'modules/register/register_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
   DioHelper.init();
  // bool landing = CacheHelper.getData('landing');
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => EShop(), // Wrap your app
    ),
  );
}

class EShop extends StatelessWidget {
  // final bool ? landing ;
  const EShop({
    Key? key,
    // this.landing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:(context)=> AppCubit()..changeThemeMode()),
        BlocProvider(create:(context)=> HomeCubit()..getBanners()..getCategories()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            locale: DevicePreview.locale(context), // Add the locale here
            builder: DevicePreview.appBuilder, // Add the builder here
            debugShowCheckedModeBanner: false,
            title: 'E-Shop',
            themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            theme: lightMode,
            darkTheme: darkMode,
            routes: {
              /// Add routes here !
              LandingScreen.id: (context) => LandingScreen(),
              LayoutScreen.id: (context) => LayoutScreen(),
              LoginScreen.id: (context) => LoginScreen(),
              RegisterScreen.id: (context) => RegisterScreen(),
            },
            home: LoginScreen(),
          );
        },
      ),
    );
  }
}
