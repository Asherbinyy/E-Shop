import 'dart:ui';
import '/modules/error/error_screen.dart';
import '/network/local/cache_helper.dart';
import '/network/local/cached_values.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import '/shared/cubit/app_cubit.dart';
import '/layout/layout_screen.dart';
import '/modules/login/login_screen.dart';
import '/shared/components/methods/navigation.dart';
import '/shared/components/reusable/buttons/default_login_button.dart';
import '/shared/components/reusable/text_field/text_field.dart';
import '/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';

var passwordController = TextEditingController();
var confirmPasswordRegisterController = TextEditingController();
final emailRegisterController = TextEditingController();
final nameRegisterController = TextEditingController();
final phoneRegisterController = TextEditingController();
final formKey = GlobalKey<FormState>();

class RegisterScreen extends StatelessWidget {
  static String id = 'RegisterScreen';

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider (
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          /// In case Status code is 200
          if (state is SignUpSuccessState) {
            if (state.registerModel.status!) {
              if (RegisterCubit.get(context).isCheckBox){
                CacheHelper.saveData(TOKEN, state.registerModel.data?.token).then((value) {
                  if (value) {
                    token = state.registerModel.data?.token;
                    navigateToAndFinish(context, LayoutScreen());
                  }
                });
              }
              else {
                token = state.registerModel.data?.token;
                navigateToAndFinish(context, LayoutScreen());
              }
            }
            else{
              DefaultDialogue.showSnackBar(context,state.registerModel.message!,dialogueStates: DialogueStates.ERROR,isDark: AppCubit.get(context).isDark);
            }
          }

          /// In case Status code isNot 200 (connection lost)

          if (state is SignUpErrorState){
            passwordLogInController.clear();
            emailLogInController.clear();
            navigateToAndFinish(context, ErrorScreen());
          }

        },
        builder: (context, state) {
          var scaffoldKey = GlobalKey<ScaffoldState>();

          return Scaffold(
            backgroundColor: AppCubit.get(context).isDark?kDarkPrimaryColor:Colors.white,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 15.0,
                    ),
                    // Center(
                    //   heightFactor: 1.35,
                    //   child: Material(
                    //     borderRadius:
                    //         BorderRadius.circular(screenWidth / 5),
                    //     shadowColor: kPrimaryColor.withRed(1),
                    //     elevation: 12.0,
                    //     child: CircleAvatar(
                    //       radius: screenWidth / 5.5,
                    //       backgroundColor: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                      ),
                      child: Container(
                        height: screenHeight / 3.1,
                        width: screenWidth / 2.2,
                        child: Image.asset(AppCubit.get(context).isDark?kLogoDark:kLogoLight),
                      ),
                    ),
                    Text('Welcome!',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 150.0,
                    ),
                    Text('Create your new account',
                        style: Theme.of(context).textTheme.button!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 11.0,
                            )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25.0,
                    ),

                    DefaultTextField(
                      isPrimary: true,
                      labelText: 'Full Name',
                      prefixIcon: FontAwesomeIcons.user,
                      prefixIconSize: 22.0,
                      prefixIconColor: kPrimaryColor.withRed(1),
                      formFieldShadowColor: kPrimaryColor.withRed(1),
                      cursorColor: kPrimaryColor.withRed(1),
                      iconShadowColor: kPrimaryColor.withRed(1),
                      controller: nameRegisterController,
                      keyboardType: TextInputType.name,
                      validator: RegisterCubit.get(context)
                          .validator('You Should Enter Your Name '),
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30.0,
                    ),
                    DefaultTextField(
                      isPrimary: true,
                      labelText: 'Phone',
                      prefixIcon: Icons.phone_outlined,
                      prefixIconSize: 25.0,
                      prefixIconColor: kPrimaryColor.withRed(1),
                      formFieldShadowColor: kPrimaryColor.withRed(1),
                      cursorColor: kPrimaryColor.withRed(1),
                      iconShadowColor: kPrimaryColor.withRed(1),
                      controller: phoneRegisterController,
                      keyboardType: TextInputType.phone,
                      validator: RegisterCubit.get(context)
                          .validator('You should Enter Email Your Phone'),
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30.0,
                    ),
                    DefaultTextField(
                      isPrimary: true,
                      labelText: 'Email Address',
                      prefixIcon: Icons.email_outlined,
                      prefixIconColor: kPrimaryColor.withRed(1),
                      formFieldShadowColor: kPrimaryColor.withRed(1),
                      cursorColor: kPrimaryColor.withRed(1),
                      iconShadowColor: kPrimaryColor.withRed(1),
                      controller: emailRegisterController,
                      keyboardType: TextInputType.emailAddress,
                      validator: RegisterCubit.get(context)
                          .validator('You should Enter Email Address'),
                      onFieldSubmitted: (value) {
                        print(value);
                      },
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30.0,
                    ),
                    DefaultTextField(
                      isPrimary: false,
                      labelText: 'Password',
                      prefixIcon: Icons.lock_open_outlined,
                      // suffixIcon: RegisterCubit.get(context).suffixIcon(),
                      suffixIconColor: kSecondaryColor.withRed(1),
                      prefixIconColor: kSecondaryColor.withRed(1),
                      formFieldShadowColor: kSecondaryColor.withRed(1),
                      iconShadowColor: kSecondaryColor.withRed(1),
                      cursorColor: kSecondaryColor.withRed(1),
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: RegisterCubit.get(context)
                          .validator('You should Enter Password'),
                      suffixPressed: () {
                        RegisterCubit.get(context).suffixPressed();
                      },
                      obscureText: RegisterCubit.get(context).showPassword,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30.0,
                    ),
                    DefaultTextField(
                      isPrimary: false,
                      labelText: 'Confirm Password',
                      prefixIcon: Icons.lock_open_outlined,
                      // suffixIcon: RegisterCubit.get(context).suffixIcon1(),
                      suffixIconColor: kSecondaryColor.withRed(1),
                      prefixIconColor: kSecondaryColor.withRed(1),
                      formFieldShadowColor: kSecondaryColor.withRed(1),
                      iconShadowColor: kSecondaryColor.withRed(1),
                      cursorColor: kSecondaryColor.withRed(1),
                      controller:confirmPasswordRegisterController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: RegisterCubit.get(context)
                          .validator('You should Enter Password'),
                      suffixPressed: () {
                        RegisterCubit.get(context).suffixPressed1();
                      },
                      obscureText: RegisterCubit.get(context).showRePassword,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 100.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            activeColor: kSecondaryColor.withRed(1),
                            value: RegisterCubit.get(context).isCheckBox,
                            onChanged: (isCheckBox) {
                              RegisterCubit.get(context).checkBox();
                            }),
                        Text(
                          'I agree with',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                            child: Text(
                              'Terms and Conditions',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: kSecondaryColor.withRed(1)),
                            ),
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return curvedBottomSheetDecoration(AppCubit.get(context).isDark,child:Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(kDummyText),
                                          Align(
                                            alignment: AlignmentDirectional
                                                .bottomEnd,
                                            child: TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child:
                                                Text('I Understand')),
                                          ),
                                        ],
                                      ),
                                    ),);
                                  });
                            },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 150.0,
                    ),
                    DefaultLoginButton(
                      title: 'Sign up',
                      width: screenWidth / 2.5,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                        RegisterCubit.get(context).signUpUser(
                            name: nameRegisterController.text,
                            email: emailRegisterController.text,
                            password: passwordController.text,
                            phone: phoneRegisterController.text);
                        }
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.grey.shade400,
                          height: 1.5,
                          width: screenWidth / 5.0,
                        ),
                        SizedBox(
                          width: screenWidth / 30.0,
                        ),
                        Text(
                          'or Sign in via',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: screenWidth / 30.0,
                        ),
                        Container(
                          color: Colors.grey.shade400,
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
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.instagram,
                            color: kThirdColor.withGreen(300),
                            size: MediaQuery.of(context).size.width / 12.0,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  color: Colors.black54,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          child: Text(
                            'Sign in',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: kSecondaryColor.withRed(1),
                                    fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                        )
                      ],
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          navigateToAndFinish(context, LayoutScreen()),
                      child: Text('Skip Now'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
