import 'package:bloc/bloc.dart';
import 'package:e_shop/modules/register/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(): super(InitialRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);





  bool showPassword = true ;
  bool showRePassword = true ;

  var passwordController = TextEditingController();
  var confirmPasswordRegisterController = TextEditingController();
  final emailRegisterController = TextEditingController();
  final nameRegisterController = TextEditingController();
  final phoneRegisterController = TextEditingController();
  final formKey = GlobalKey<FormState>();



///
  bool isCheckBox = false ;
  FormFieldValidator<String> validator (String errorMessage){
    return (value){
      if(value!.isEmpty){
        emit(PasswordValidatorState());
        return errorMessage ;
      }
    };
  }
  VoidCallback? suffixPressed(){
    showPassword = !showPassword ;
    emit(SuffixPressedState());
  }
  VoidCallback? suffixPressed1(){
    showRePassword = !showRePassword ;
    emit(SuffixPressedState());
  }
  IconData suffixIcon(){
    return showPassword? Icons.visibility : Icons.visibility_off;
  }
  IconData suffixIcon1(){
    return showRePassword? Icons.visibility : Icons.visibility_off;
  }
  void checkBox(){
    isCheckBox = !isCheckBox ;
    emit(CheckBoxState());
  }
///








}