import 'package:bloc/bloc.dart';
import 'package:e_shop/layout/layout_screen.dart';
import 'package:e_shop/modules/landing_screen/landing_screen.dart';
import 'package:e_shop/network/local/cache_helper.dart';
import 'package:e_shop/styles/bloc_observer.dart';
import 'package:e_shop/styles/theme.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  // bool landing = CacheHelper.getData('landing');
  runApp(EShop());
}

class EShop extends StatelessWidget {
  // final bool ? landing ;
  const EShop ({Key? key,
    // this.landing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Shop',
      themeMode: ThemeMode.light,
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        /// Add routes here !
        LandingScreen.id:(context)=>LandingScreen(),
        LayoutScreen.id :(context)=>LayoutScreen(),
      },
      home: LandingScreen(),
    );
  }
}
