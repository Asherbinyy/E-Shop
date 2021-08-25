import 'package:e_shop/components/reusable/buttons/buttons.dart';
import 'package:e_shop/components/reusable/text_field/text_field.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  static String id = 'LoginScreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 15.0,
            ),
            Center(
              child: Stack(
                children: [
                  Center(
                    heightFactor: 1.35,
                    child: Material(
                      borderRadius: BorderRadius.circular(screenWidth / 5),
                      shadowColor: kPrimaryColor.withRed(1),
                      elevation: 12.0,
                      child: CircleAvatar(
                        radius: screenWidth / 5.5,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                    ),
                    child: Center(
                      child: Container(
                        height: screenHeight / 3.1,
                        width: screenWidth / 2.2,
                        child: Image.asset(
                          'assets/images/logo4.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text('Welcome Back!',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
            Text('Login to your account',
                style: Theme.of(context).textTheme.button!.copyWith(
                      fontWeight: FontWeight.w400,
                    )),
            SizedBox(
              height: MediaQuery.of(context).size.height / 25.0,
            ),
            DefaultTextField(
              isPrimary: true,
              labelText: 'Email Address',
              prefixIcon: Icons.email_outlined,
              prefixIconColor: kPrimaryColor.withRed(1),
              formFieldShadowColor: kPrimaryColor.withRed(1),
              cursorColor: kPrimaryColor.withRed(1),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40.0,
            ),
            DefaultTextField(
              isPrimary: false,
              labelText: 'Password',
              prefixIcon: Icons.lock_open_outlined,
              suffixIcon: Icons.visibility,
              suffixIconColor: kSecondaryColor.withRed(1),
              suffixPressed: () {},
              prefixIconColor: kSecondaryColor.withRed(1),
              formFieldShadowColor: kSecondaryColor.withRed(1),
              iconShadowColor: kSecondaryColor.withRed(1),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 100.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Checkbox(
                        activeColor: kPrimaryColor.withRed(1),
                        value: false,
                        onChanged: (bool) {}),
                    Text('Remember Me'),
                  ],
                ),
                TextButton(
                  child: Text(
                    'Forget Password ?',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor.withRed(1)),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 150.0,
            ),
            DefaultLoginButton(
              title: 'Sign in',
              width: screenWidth / 2.5,
              onPressed: () {},
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.grey,
                  height: 1.5,
                  width: screenWidth / 5.0,
                ),
                SizedBox(
                  width: screenWidth / 30.0,
                ),
                Text('or Sign in with'),
                SizedBox(
                  width: screenWidth / 30.0,
                ),
                Container(
                  color: Colors.grey,
                  height: 1.5,
                  width: screenWidth / 5.0,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 30.0,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.google,
                    color: kSecondaryColor.withRed(100),
                    size: MediaQuery.of(context).size.width / 12.0,
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: screenWidth / 20,
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.facebookF,
                    color: kPrimaryColor.withGreen(135),
                    size: MediaQuery.of(context).size.width / 12.0,
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  width: screenWidth / 20,
                ),
                Container(
                  child: IconButton(
                    icon: Icon(
                      FontAwesomeIcons.instagram,
                      color: kThirdColor.withGreen(300),
                      size: MediaQuery.of(context).size.width / 12.0,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Do not have an account?'),
                TextButton(
                  child: Text('Sign up',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: kSecondaryColor.withRed(1),
                    fontWeight: FontWeight.bold
                  ),),
                  onPressed: (){},
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
