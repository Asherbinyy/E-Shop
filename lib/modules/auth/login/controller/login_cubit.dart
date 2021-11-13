import 'dart:async';

import 'package:e_shop/helpers/local/shared_pref/cache_helper.dart';
import 'package:e_shop/helpers/local/shared_pref/cached_values.dart';
import 'package:e_shop/modules/auth/models/user_model.dart';
import 'package:e_shop/modules/auth/register/controller/register_cubit.dart';
import 'package:e_shop/modules/auth/register/controller/register_state.dart';
import 'package:e_shop/services/firebase_service/firestore_user_service.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../helpers/remote/dio_helper.dart';
import '../../../../helpers/remote/end_points.dart';
import '../../models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);



  final _auth = FirebaseAuth.instance;
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


//
// void d (){
//   RegisterCubit().stream.listen((event) {
//     if (event is InitialRegisterState) {}
//   });
// }


// Login via api ***********************************************

  AuthModel? authModel ;
  void signInUser({
  required String email,
  required String password,
}) {
    DioHelper.postData(
        url: LOGIN ,
        data:{
          'email': emailController.text,
          'password': passwordController.text,
        } ,
    ).then((value) {
     // signInWithEmailAndPassword();
      print('Sign in via api => ${value.data}');
      authModel = AuthModel.fromJson(value.data);// *** vip ***
      emit(LoginSuccessState(authModel!));
      print('Success ! . user signed in in both api and firebase !');
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print('Error in LoginScreen is : ${error.toString()}');
    });
  }
  // // login via firebase // Login via api ***************************************
  /// Sign in user with Email And Password account
  void signInWithEmailAndPassword(){
    emit(LoginLoadingState());
    final _signUser = _auth.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
       _signUser.then((value) async {
         /// save uid as token
         await CacheHelper.saveData(UID, value.user!.uid);
         print('Credential from fireAuth => ${value.user}');
         signInUser(email: value.user!.email!,password: passwordController.text);
      }).catchError((error){
      emit(LoginErrorState(error.toString()));
      print('Error in LoginScreen is : ${error.toString()}');
    });
  }
 // ----------------------------------------------------------------------------





//***********************************************************************
  bool showPassword = true ;
  bool isCheckBox = false ;

  FormFieldValidator<String> validator(String errorMessage){
    return (value){
      if(value!.isEmpty){
        emit(LoginPasswordValidatorState());
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
     emit(LoginSuffixPressedState());
  }
  IconData suffixIcon(){
    return showPassword? Icons.visibility : Icons.visibility_off;
  }
      void checkBox(){
      isCheckBox = !isCheckBox ;
      emit(LoginCheckBoxState());
}
  }
