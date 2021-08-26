import 'package:bloc/bloc.dart';
import 'package:e_shop/modules/register_screen/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(): super(InitialRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool showPassword = true ;
  bool showRePassword = true ;

  var passwordRegisterController = TextEditingController();
  var rePasswordRegisterController = TextEditingController();
  final emailRegisterController = TextEditingController();
  final nameRegisterController = TextEditingController();
  final phoneRegisterController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isCheckBox = false ;


  FormFieldValidator<String> validator(String errorMessage){
    return (value){
      if(value!.isEmpty){
        emit(PasswordValidator());
        return errorMessage ;
      }
    };
  }
  VoidCallback? suffixPressed(){
    showPassword = !showPassword ;
    emit(SuffixPressed());
  }
  VoidCallback? suffixPressed1(){
    showRePassword = !showRePassword ;
    emit(SuffixPressed());
  }
  IconData suffixIcon(){
    emit(SuffixIcon());
    return showPassword? Icons.visibility : Icons.visibility_off;
  }
  IconData suffixIcon1(){
    emit(SuffixIcon());
    return showRePassword? Icons.visibility : Icons.visibility_off;
  }
  void checkBox(){
    isCheckBox = !isCheckBox ;
    emit(CheckBox());
  }



}