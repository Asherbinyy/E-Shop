
import 'package:e_shop/modules/auth/models/auth_model.dart';

abstract class RegisterStates{}

class InitialRegisterState extends RegisterStates{}

// register
class SignUpLoadingState extends RegisterStates {}
class SignUpSuccessState extends RegisterStates {
  final AuthModel registerModel;

  SignUpSuccessState(this.registerModel);
}
class SignUpErrorState extends RegisterStates {
  final String error ;
   SignUpErrorState(this.error);
}
class RegisterCreateUserSuccessState extends RegisterStates{}
class RegisterOnFieldSubmittedState extends RegisterStates{}
class RegisterPasswordValidatorState extends RegisterStates{}
class RegisterSuffixPressedState extends RegisterStates{}
class RegisterSuffixIconState extends RegisterStates{}
class RegisterCheckBoxState extends RegisterStates{}