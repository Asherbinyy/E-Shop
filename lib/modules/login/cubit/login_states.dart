

import 'package:e_shop/models/api/login_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  final LoginModel loginModel ;

  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates {
  final String error ;
  LoginErrorState(this.error);
}




//*********************************
class OnFieldSubmittedState extends LoginStates{}
class PasswordValidatorState extends LoginStates{}
class SuffixPressedState extends LoginStates{}
class SuffixIconState extends LoginStates{}
class CheckBoxState extends LoginStates{}

//*******************************