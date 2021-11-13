


import 'package:e_shop/modules/auth/models/auth_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  final AuthModel loginModel ;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates {
  final String error ;
  LoginErrorState(this.error);
}




//*********************************
class LoginOnFieldSubmittedState extends LoginStates{}
class LoginPasswordValidatorState extends LoginStates{}
class LoginSuffixPressedState extends LoginStates{}
class LoginSuffixIconState extends LoginStates{}
class LoginCheckBoxState extends LoginStates{}

//*******************************