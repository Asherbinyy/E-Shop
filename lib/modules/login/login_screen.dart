import '../../shared/components/builders/signing_methods.dart';
import '../../shared/components/reusable/spaces/spaces.dart';
import '../../layout/layout_screen.dart';
import '../../network/local/cache_helper.dart';
import '../../network/local/cached_values.dart';
import '../../shared/components/builders/myConditional_builder.dart';
import '../../modules/error/error_screen.dart';
import '../../shared/components/methods/navigation.dart';
import '../../shared/components/reusable/dialogue/default_dialogue.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../modules/register/register_screen.dart';
import '../../shared/components/reusable/buttons/signing_button.dart';
import '../../shared/components/reusable/text_field/signing_text_field.dart';
import '../../styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';
import 'package:easy_localization/easy_localization.dart';
/// reviewed

final _passwordLogInController = TextEditingController();
final _emailLogInController = TextEditingController();
var _formKey = GlobalKey<FormState>();


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void loginScreenListener(BuildContext context, LoginStates state) {
    /// In case Status code is 200
    if (state is LoginSuccessState) {
      if (state.loginModel.status!) {
        if (LoginCubit.get(context).isCheckBox) {
          CacheHelper.saveData(TOKEN, state.loginModel.data?.token)
              .then((value) {
            if (value) {
              token = state.loginModel.data?.token;
              navigateToAndFinish(context, LayoutScreen());
            }
          });
        } else {
          token = state.loginModel.data?.token;
          navigateToAndFinish(context, LayoutScreen());
        }
      } else {
        DefaultDialogue.showSnackBar(context, state.loginModel.message!,
            dialogueStates: DialogueStates.ERROR,
            isDark: AppCubit.get(context).isDark);
      }
    }

    /// In case Status code isNot 200 (connection lost)
    if (state is LoginErrorState) {
      _passwordLogInController.clear();
      _emailLogInController.clear();
      navigateToAndFinish(context, ErrorScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    bool isDark = AppCubit.get(context).isDark;


    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) => loginScreenListener(context, state),
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            // backgroundColor: isDark?kDarkPrimaryColor:Colors.white,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _HeaderBuilder(isDark, _height, _width),
                      _SigningFieldsBuilder(cubit, isDark, state),
                      SigningMethods(SigningMethodStyle.LOGIN,onPressed: ()=>navigateToAndFinish(context, RegisterScreen()),),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeaderBuilder extends StatelessWidget {
  final bool isDark;
  final double height;
  final double width;
  const _HeaderBuilder(this.isDark, this.height, this.width, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Material(
              shape: CircleBorder(),
              shadowColor: kPrimaryColorLight.withRed(0),
              elevation: 12.0,
              child: CircleAvatar(
                radius: 100,
                backgroundColor:
                    isDark ? kDarkSecondaryColor : kLightSecondaryColor,
              ),
            ),
            Hero(
              tag: 'AppIcon',
              child: SizedBox(
                height: height * 0.3,
                width: width * 0.4,
                child: Image.asset(isDark ? kLogoDark : kLogoLight),
              ),
            ),
          ],
        ),
        Text(
          'welcome_back'.tr(),
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 150.0,
        ),
        Text('login_to_your_acc'.tr(),
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        SizedBox(
          height: MediaQuery.of(context).size.height / 25.0,
        ),
      ],
    );
  }
}

class _SigningFieldsBuilder extends StatelessWidget {
  final LoginCubit cubit;
  final LoginStates state;
  final bool isDark;
  const _SigningFieldsBuilder(this.cubit, this.isDark, this.state, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var _width = MediaQuery.of(context).size.width;
      Widget _space() => SizedBox(
            height: MediaQuery.of(context).size.height / 30.0,
          );
      Widget _rememberMe() => Align(
        alignment: AlignmentDirectional.topStart,
        child: FittedBox(
          fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.grey),
                    child: Checkbox(
                        activeColor: kPrimaryColorLight,
                        value: cubit.isCheckBox,
                        onChanged: (isCheckBox) {
                          cubit.checkBox();
                        }),
                  ),
                  Text('remember_me'.tr(),
                      style: Theme.of(context).textTheme.subtitle2),
                  TextButton(
                    child: Text(
                      'forgot_password'.tr(),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColorLight.withRed(1)),
                    ),
                    onPressed: () =>{},
                  ),
                ],
              ),
            ),
      );
      Widget _loading ()=>const Center(
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      );
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SigningTextField(
            isPrimary: true,
            labelText: 'email_address'.tr(),
            prefixIcon: Icons.email_outlined,
            prefixIconColor: kPrimaryColorLight.withRed(1),
            formFieldShadowColor: kPrimaryColorLight.withRed(1),
            cursorColor: kPrimaryColorLight.withRed(1),
            iconShadowColor: kPrimaryColorLight.withRed(1),
            controller: _emailLogInController,
            keyboardType: TextInputType.emailAddress,
            validator: cubit.validator('enter_your_email_address'.tr()),
          ),
          _space(),
          SigningTextField(
            isPrimary: false,
            labelText: 'password'.tr(),
            prefixIcon: Icons.lock_open_outlined,
            suffixIcon: cubit.suffixIcon(),
            suffixIconColor: kSecondaryColorLight.withRed(0),
            prefixIconColor: kSecondaryColorLight.withRed(0),
            formFieldShadowColor: kSecondaryColorLight.withRed(0),
            iconShadowColor: kSecondaryColorLight.withRed(0),
            cursorColor: kSecondaryColorLight.withRed(0),
            controller: _passwordLogInController,
            keyboardType: TextInputType.visiblePassword,
            validator: cubit.validator('enter_your_password'.tr()),
            suffixPressed: () => cubit.suffixPressed(),
            obscureText: cubit.showPassword,
          ),
          _space(),
          _rememberMe(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 150.0,
          ),
          MyConditionalBuilder(
            condition: state is! LoginLoadingState,
            builder: SigningButton(
              textColor: Colors.grey[200],
              title: 'sign_in'.tr(),
              width: _width / 2.5,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  cubit.userLogin(
                      email: _emailLogInController.text,
                      password: _passwordLogInController.text);
                  print(_passwordLogInController.text);
                  print(_emailLogInController.text);
                }
              },
            ),
            feedback: Center(
                child: CircularProgressIndicator(
              color: kPrimaryColor.withRed(1),
            )),
          ),
          YSpace.extreme,
          MyConditionalBuilder(
            condition: 0 == 0, /// TODO : UPDATE THIS
            builder: OutlinedSigningButton(
              color: kPrimaryColor,
              height: 50,
              isDark: isDark,
              title: 'go_anonymously'.tr(),
              onPressed: () {},
            ),
            feedback: kLoadingFadingCircle,
          ),
          _space(),
        ],
      );
    });
  }
}

