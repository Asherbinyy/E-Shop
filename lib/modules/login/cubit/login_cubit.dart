import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool showPassword = true ;
  var passwordLogInController = TextEditingController();
  final emailLogInController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isCheckBox = false ;

  ValueChanged<String> onFieldSubmitted(){
    return (String value) {
      print(value);
      emit(OnFieldSubmittedState());
    };
  }
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
