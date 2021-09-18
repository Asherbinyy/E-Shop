import '../../../models/api/user/login.dart';
import '/network/remote/dio_helper.dart';
import '/network/remote/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool showPassword = true ;

  bool isCheckBox = false ;
//***********************************************
  LoginModel? loginModel ;

  void userLogin({
    required String email,
    required String password ,
})
  {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN ,
        data:{
          'email': email,
          'password': password,
        } ,
    ).then((value) {
      print(value.data);
      loginModel =  LoginModel.fromJson(value.data);// *** vip ***
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print('Error in LoginScreen is : ${error.toString()}');
    });
  }

//***********************************************************************

  FormFieldValidator<String> validator(String errorMessage){
    return (value){
      if(value!.isEmpty){
        emit(PasswordValidatorState());
        return errorMessage ;
      }
    };
  }
  ValueChanged<String> onChanged(){
    return (value) {
      print(value);
    };
  }
  VoidCallback? suffixPressed(){
     showPassword = !showPassword ;
     emit(SuffixPressedState());
  }
  IconData suffixIcon(){
    return showPassword? Icons.visibility : Icons.visibility_off;
  }
      void checkBox(){
      isCheckBox = !isCheckBox ;
      emit(CheckBoxState());
}
  }
