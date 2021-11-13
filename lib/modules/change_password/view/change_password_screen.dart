import 'dart:async';
import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/styles/constants/constants.dart';

import '/shared/components/reusable/app_bar/secondary_app_bar.dart';
import '/shared/components/reusable/buttons/rounded_button.dart';
import '/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import '/shared/components/reusable/text_field/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/// REVIEWED


class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  Timer ? timer ;
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _currentPasswordController.text='';
    _newPasswordController.text='';
    super.initState();
    timer = Timer.periodic(Duration(seconds: 4), (Timer t) {
      HomeCubit.get(context).checkUpdateButtonDisable(
          _currentPasswordController.text,
          _newPasswordController.text,
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState){
          if (state.changePasswordModel!.status!){
            DefaultDialogue.showSnackBar(context, state.changePasswordModel!.message!, dialogueStates: DialogueStates.SUCCESS);
           navigateBack(context);
          }
          else  DefaultDialogue.showSnackBar(context, state.changePasswordModel!.message!, dialogueStates: DialogueStates.ERROR);

          _currentPasswordController.clear();
          _newPasswordController.clear();
          HomeCubit.get(context).checkUpdateButtonDisable(_currentPasswordController.text, _newPasswordController.text);

        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        bool isDark= AppCubit.get(context).isDark;
        return Scaffold(
         appBar: SecondaryAppBar(title: 'change_password'.tr(),),
          body: Container(
            padding:const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey ,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    DefaultTextField(
                        isDark: isDark,
                        primaryColor: kSecondaryColor,
                        controller: _currentPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        label: 'current_password'.tr(),
                        suffixOnChanged:() => cubit.togglePasswordVisibility(),
                         obscurePassword: cubit.isPassword ,
                        suffixIcon: cubit.passwordSuffix,
                         prefixIcon: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'empty_password'.tr();
                          } else {
                            return null;
                          }
                        }),
                    YSpace.extreme,
                    DefaultTextField(
                        isDark: isDark,
                        primaryColor: kSecondaryColor,
                        controller: _newPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        label: 'new_password'.tr(),
                        suffixOnChanged: ()=> cubit.togglePasswordVisibility(),
                         obscurePassword: cubit.isPassword ,
                        suffixIcon:cubit.passwordSuffix,
                        prefixIcon: Icons.lock,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'empty_password'.tr();
                          }
                          else {
                            return null;
                          }
                        },
                      onSubmitted: (_){
                          cubit.checkUpdateButtonDisable(_currentPasswordController.text, _newPasswordController.text);
                      },
                      onTap: (){
                         Future.delayed(Duration(seconds: 2)).then((value) => cubit.checkUpdateButtonDisable(_currentPasswordController.text, _newPasswordController.text),
                      );},
                    ),
                    YSpace.extreme,
                    RoundedButton.icon(
                      isDisabled:cubit.isUpdateButtonDisabled,
                      label: 'update_profile'.tr(),
                      icon:  Icons.edit,
                      color: isDark
                          ? kSecondaryColor
                          : Colors.white,
                      backgroundColor: isDark
                          ? Colors.white
                          : kSecondaryColor,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.changePassword(
                              oldPassword: _currentPasswordController.text,
                              newPassword:  _newPasswordController.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

  }
}
