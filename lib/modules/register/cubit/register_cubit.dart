import 'package:bloc/bloc.dart';
import 'package:e_shop/models/api/user/login.dart';
import 'package:e_shop/modules/register/cubit/register_state.dart';
import 'package:e_shop/network/remote/dio_helper.dart';
import 'package:e_shop/network/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitialRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  // register
  LoginModel? registerModel;

  void signUpUser({
    required final String name,
    required final String email,
    required final String password,
    required final String phone,
  }) {
    emit(SignUpLoadingState());

    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      if (value.statusCode == 200) {
        registerModel = LoginModel.fromJson(value.data);
        emit(SignUpSuccessState(registerModel!));
      }
    }).catchError(
      (error) {
        print('Error when Signing up user is : ${error.toString()}');
        emit(SignUpErrorState(error.toString()));
      },
    );
  }










  bool showPassword = true;
  bool showRePassword = true;



  bool isCheckBox = false;
  FormFieldValidator<String> validator(String errorMessage) {
    return (value) {
      if (value!.isEmpty) {
        emit(PasswordValidatorState());
        return errorMessage;
      }
    };
  }

  VoidCallback? suffixPressed() {
    showPassword = !showPassword;
    emit(SuffixPressedState());
  }

  VoidCallback? suffixPressed1() {
    showRePassword = !showRePassword;
    emit(SuffixPressedState());
  }

  IconData suffixIcon() {
    return showPassword ? Icons.visibility : Icons.visibility_off;
  }

  IconData suffixIcon1() {
    return showRePassword ? Icons.visibility : Icons.visibility_off;
  }

  void checkBox() {
    isCheckBox = !isCheckBox;
    emit(CheckBoxState());
  }
}
