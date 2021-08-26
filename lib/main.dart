import 'package:e_shop/layout/layout_screen.dart';
import 'package:e_shop/modules/landing_screen/landing_screen.dart';
import 'package:e_shop/modules/register_screen/register_screen.dart';
import 'package:e_shop/styles/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'modules/login_screen/login_screen.dart';

void main() {
  runApp(EShop());
}

class EShop extends StatelessWidget {
  const EShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Shop',
      themeMode: ThemeMode.system,
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        /// Add routes here !
        LandingScreen.id:(context)=>LandingScreen(),
        LayoutScreen.id:(context)=>LayoutScreen(),
        LoginScreen.id:(context) =>LoginScreen(),
        RegisterScreen.id:(context) =>RegisterScreen(),
      },
      home: LoginScreen(),
    );
  }
}
