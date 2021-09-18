import 'package:e_shop/models/api/user/login.dart';

abstract class RegisterState{}

class InitialRegisterState extends RegisterState{}

// register
class SignUpLoadingState extends RegisterState {}
class SignUpSuccessState extends RegisterState {
  final LoginModel registerModel;

  SignUpSuccessState(this.registerModel);
}
class SignUpErrorState extends RegisterState {
  final String error ;
   SignUpErrorState(this.error);
}





class OnFieldSubmittedState extends RegisterState{}
class PasswordValidatorState extends RegisterState{}
class SuffixPressedState extends RegisterState{}
class SuffixIconState extends RegisterState{}
class CheckBoxState extends RegisterState{}