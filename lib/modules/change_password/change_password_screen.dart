
import 'dart:async';

import 'package:e_shop/layout/cubit/home_cubit.dart';
import 'package:e_shop/layout/cubit/home_states.dart';
import 'package:e_shop/shared/components/reusable/buttons/rounded_button.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/spaces/spaces.dart';
import 'package:e_shop/shared/components/reusable/text_field/secondary_text_field.dart';
import 'package:e_shop/shared/cubit/app_cubit.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var _currentPasswordController = TextEditingController();
var _newPasswordController = TextEditingController();
var _formKey = GlobalKey<FormState>();

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  Timer ? timer ;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 4), (Timer t) {
      HomeCubit.get(context).checkUpdateButtonDisable(_currentPasswordController.text, _newPasswordController.text);
    });
  }
  @override
  void dispose() {
    timer?.cancel();
    _currentPasswordController.clear();
    _newPasswordController.clear();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState){
          if (state.changePasswordModel!.status!){
            DefaultDialogue.showSnackBar(context, state.changePasswordModel!.message!, dialogueStates: DialogueStates.SUCCESS);
            Navigator.pop(context);
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
          appBar: AppBar(
            title: Text('Change Password'),
          ),
          body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey ,
              child: Column(
                children: [
                  SecondaryTextField(
                      isDark: isDark,
                      primaryColor: kSecondaryColorDarker,
                      controller: _currentPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      label: 'Current Password',
                      suffixOnChanged:() => cubit.togglePasswordVisibility(),
                      obscurePassword: cubit.isPassword ,
                      suffixIcon: cubit.passwordSuffix,
                      prefixIcon: Icons.lock,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password must not be empty !';
                        } else {
                          return null;
                        }
                      }),
                  YSpace.extreme,
                  SecondaryTextField(
                      isDark: isDark,
                      primaryColor: kSecondaryColorDarker,
                      controller: _newPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      label: 'New Password',
                      suffixOnChanged: ()=> cubit.togglePasswordVisibility(),
                      obscurePassword: cubit.isPassword ,
                      suffixIcon:cubit.passwordSuffix,
                      prefixIcon: Icons.lock,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password must not be empty !';
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
                  RoundedButton(
                    isDisabled:cubit.isUpdateButtonDisabled,
                    label: 'Update Profile',
                    icon: Icons.edit,
                    isIcon: true,
                    color: isDark
                        ? kSecondaryColorDarker
                        : Colors.white,
                    backgroundColor: isDark
                        ? Colors.white
                        : kSecondaryColorDarker,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.changePassword(
                            oldPassword: _currentPasswordController.text,
                            newPassword:  _newPasswordController.text
                          ,);
                        // don't uses this
                        // sCubit.updateProfile(
                        //   email: _emailController.text,
                        //   name: _nameController.text,
                        //   phone: _phoneController.text,
                        // );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

  }
}
