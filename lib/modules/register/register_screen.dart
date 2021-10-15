import 'dart:ui';
import '../../shared/components/builders/myConditional_builder.dart';
import '../../shared/components/builders/signing_methods.dart';
import '../../shared/components/reusable/spaces/spaces.dart';
import '/modules/error/error_screen.dart';
import '/network/local/cache_helper.dart';
import '/network/local/cached_values.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import '/shared/cubit/app_cubit.dart';
import '/layout/layout_screen.dart';
import '/modules/login/login_screen.dart';
import '/shared/components/methods/navigation.dart';
import '/shared/components/reusable/buttons/signing_button.dart';
import '/shared/components/reusable/text_field/signing_text_field.dart';
import '/styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';
import 'package:easy_localization/easy_localization.dart';

/// reviewed
final _passwordController = TextEditingController();
final _confirmPasswordRegisterController = TextEditingController();
final _emailRegisterController = TextEditingController();
final _nameRegisterController = TextEditingController();
final _phoneRegisterController = TextEditingController();
final _registerFormKey = GlobalKey<FormState>();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  void registerScreenListener(BuildContext context, RegisterState state) {
    /// In case Status code is 200
    if (state is SignUpSuccessState) {
      if (state.registerModel.status!) {
        if (RegisterCubit.get(context).isCheckBox) {
          CacheHelper.saveData(TOKEN, state.registerModel.data?.token)
              .then((value) {
            if (value) {
              token = state.registerModel.data?.token;
              navigateToAndFinish(context, LayoutScreen());
            }
          });
        } else {
          token = state.registerModel.data?.token;
          navigateToAndFinish(context, LayoutScreen());
        }
      } else
        DefaultDialogue.showSnackBar(context, state.registerModel.message!,
            dialogueStates: DialogueStates.ERROR,
            isDark: AppCubit.get(context).isDark);
    }

    /// In case Status code isNot 200 (connection lost)

    if (state is SignUpErrorState) {
      _passwordController.clear();
      _confirmPasswordRegisterController.clear();
      _emailRegisterController.clear();
      _nameRegisterController.clear();
      _phoneRegisterController.clear();
      navigateToAndFinish(context, ErrorScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;
    bool isDark = AppCubit.get(context).isDark;
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) => registerScreenListener(context, state),
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _registerFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _HeaderBuilder(isDark, _height, _width),
                      _SigningFieldsBuilder(cubit, state, isDark),
                      SigningMethods(
                        SigningMethodStyle.REGISTER,
                        onPressed: () =>
                            navigateToAndFinish(context, LoginScreen()),
                      ),
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
        Hero(
          tag: 'AppIcon',
          child: SizedBox(
            height: height * 0.3,
            width: width * 0.5,
            child: Image.asset(isDark ? kLogoDark : kLogoLight),
          ),
        ),
        Text('welcome'.tr(),
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        SizedBox(
          height: MediaQuery.of(context).size.height / 150.0,
        ),
        Text('create_new_account'.tr(),
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 11.0,
                )),
        SizedBox(
          height: MediaQuery.of(context).size.height / 25.0,
        ),
      ],
    );
  }
}

class _SigningFieldsBuilder extends StatelessWidget {
  final RegisterCubit cubit;
  final RegisterState state;
  final bool isDark;
  const _SigningFieldsBuilder(this.cubit, this.state, this.isDark, {Key? key})
      : super(key: key);
//
//   @override
//   State<_SigningFieldsBuilder> createState() => _SigningFieldsBuilderState();
// }
//
// class _SigningFieldsBuilderState extends State<_SigningFieldsBuilder> {
//   @override
//   void dispose() {
//     _nameRegisterController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordRegisterController.dispose();
//     _emailRegisterController.dispose();
//     _phoneRegisterController.dispose();
//     super.dispose();
//   }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      var _width = MediaQuery.of(context).size.width;
      Widget _space() => SizedBox(
            height: MediaQuery.of(context).size.height / 30.0,
          );
      Widget _agreeWithTerms() => Align(
            alignment: AlignmentDirectional.topStart,
            child: FittedBox(
              // fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.grey),
                    child: Checkbox(
                        activeColor: kSecondaryColorLight.withRed(1),
                        value: RegisterCubit.get(context).isCheckBox,
                        onChanged: (isCheckBox) {
                          RegisterCubit.get(context).checkBox();
                        }),
                  ),
                  Text('i_agree_with'.tr(),
                      style: Theme.of(context).textTheme.subtitle2),
                  TextButton(
                    child: Text(
                      'terms_and_conditions'.tr(),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: kSecondaryColorLight.withRed(0)),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return curvedBottomSheetDecoration(
                              isDark,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('dummy_text'.tr()),
                                    Align(
                                      alignment: AlignmentDirectional.bottomEnd,
                                      child: TextButton(
                                          onPressed: () =>
                                              navigateBack(context),
                                          child: Text('i_understand'.tr())),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
          );
      return Column(
        children: [
          SigningTextField(
            isPrimary: true,
            labelText: 'full_name'.tr(),
            prefixIcon: FontAwesomeIcons.user,
            controller: _nameRegisterController,
            keyboardType: TextInputType.name,
            validator: cubit.validator('enter_your_name'.tr()),
          ),
          _space(),
          SigningTextField(
            isPrimary: true,
            labelText: 'phone'.tr(),
            prefixIcon: Icons.phone_outlined,
            controller: _phoneRegisterController,
            keyboardType: TextInputType.phone,
            validator: cubit.validator('enter_your_phone'.tr()),
          ),
          _space(),
          SigningTextField(
            isPrimary: true,
            labelText: 'email_address'.tr(),
            prefixIcon: Icons.email_outlined,
            prefixIconColor: kPrimaryColorLight.withRed(1),
            formFieldShadowColor: kPrimaryColorLight.withRed(1),
            cursorColor: kPrimaryColorLight.withRed(1),
            iconShadowColor: kPrimaryColorLight.withRed(1),
            controller: _emailRegisterController,
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
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            validator: cubit.validator('enter_your_password'.tr()),
            suffixPressed: () => cubit.suffixPressed(),
            obscureText: cubit.showPassword,
          ),
          _space(),
          SigningTextField(
            isPrimary: false,
            labelText: 'confirm_password'.tr(),
            prefixIcon: Icons.lock_open_outlined,
            suffixIcon: cubit.suffixIcon(),
            suffixIconColor: kSecondaryColorLight.withRed(0),
            prefixIconColor: kSecondaryColorLight.withRed(0),
            formFieldShadowColor: kSecondaryColorLight.withRed(0),
            iconShadowColor: kSecondaryColorLight.withRed(0),
            cursorColor: kSecondaryColorLight.withRed(0),
            controller: _confirmPasswordRegisterController,
            keyboardType: TextInputType.visiblePassword,
            validator: cubit.validator('password_match'.tr()),
            obscureText: cubit.showPassword,
            suffixPressed: () => cubit.suffixPressed(),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 100.0,
          ),
          _agreeWithTerms(),
          SizedBox(
            height: MediaQuery.of(context).size.height / 150.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyConditionalBuilder(
                condition: state is! SignUpLoadingState,
                builder: SigningButton(
                  textColor: Colors.grey[200],
                  title: 'sign_up'.tr(),
                  width: _width / 2.5,
                  onPressed: () {
                    if (_registerFormKey.currentState!.validate()) {
                      RegisterCubit.get(context).signUpUser(
                          name: _nameRegisterController.text,
                          email: _emailRegisterController.text,
                          password: _passwordController.text,
                          phone: _phoneRegisterController.text);
                    }
                  },
                ),
                feedback: Expanded(child: kLoadingFadingCircle),
              ),
              XSpace.normal,
              Expanded(
                child: MyConditionalBuilder(
                  condition: 1 == 1,

                  /// TODO : UPDATE THIS
                  builder: OutlinedSigningButton(
                    height: 50,
                    isDark: isDark,
                    title: 'go_anonymously'.tr(),
                    onPressed: () => {},
                  ),
                  feedback: kLoadingFadingCircle,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
