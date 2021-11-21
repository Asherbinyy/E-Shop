import 'package:bloc/bloc.dart';
import 'package:e_shop/helpers/local/shared_pref/cache_helper.dart';
import 'package:e_shop/helpers/local/shared_pref/cached_values.dart';
import 'package:e_shop/modules/auth/models/user_model.dart';
import 'package:e_shop/services/firebase_service/firestore_user_service.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../helpers/remote/dio_helper.dart';
import '../../../../helpers/remote/end_points.dart';
import '../../models/auth_model.dart';
import 'register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  final _auth = FirebaseAuth.instance;
  final registerNameController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  var registerFormKey = GlobalKey<FormState>();

  // register
  AuthModel? get authModel=> _authModel;
  AuthModel? _authModel;

  void _signUpUser({
    required final String name,
    required final String email,
    required final String password,
    required final String phone,
  }) {
    DioHelper.postData(
        url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      if (value.statusCode == 200) {
        _authModel = AuthModel.fromJson(value.data);
        emit(SignUpSuccessState(_authModel!));
        print('auth model =>id :${_authModel?.data?.id},token : ${_authModel?.data?.token}');
      }
    }).catchError(
      (error) {
        print('Error when Signing up user is : ${error.toString()}');
        emit(SignUpErrorState(error.toString()));
      },
    );
  }
// firebase
  Future<void> signUpWithEmailAndPassword() async {
    print('step 0');
    emit(SignUpLoadingState());
    _auth.createUserWithEmailAndPassword(
      email: registerEmailController.text,
      password: registerPasswordController.text,
    ).then((credential)async {
      print('Credential from fireAuth => ${credential.user}');
      print('step 1');
      final user = credential.user;
      _signUpUser(
          name: registerNameController.text,
          email: user!.email??registerEmailController.text,
          password: registerPasswordController.text,
          phone: registerPhoneController.text,
      );
      print('step 2');

      await CacheHelper.saveData(UID, credential.user!.uid).then((value) {
        if (value){
          uId=credential.user!.uid;
        }
      });
      print('step 3');

      _createFireStoreUser(user);
      print('step 4');

    }).catchError((error){
      print('Error when Signing up user is : ${error.toString()}');
      emit(SignUpErrorState(error.toString()));
    });
}
  /// used with mail and password
  void _createFireStoreUser(User? user) {
     FireStoreUserService().addUserToFireStore(
         UserModel(
      name: user?.displayName??registerNameController.text ,
      email: user?.email??registerEmailController.text,
      firebaseId: user?.uid??'',
      id:_authModel?.data?.id??null,
      password: registerPasswordController.text  ,
      credit: _authModel?.data?.credit ??0,
      image: user?.photoURL ?? kNoImageFound ,
      phone:  _authModel?.data?.phone ??registerPhoneController.text ,
      token:  _authModel?.data?.token ?? null,
      points: _authModel?.data?.points ??0,
    )).then((value) => emit(RegisterCreateUserSuccessState()) );
  }


  // *******************************************************************************
  bool showPassword = true;
  bool isCheckBox = false;
  FormFieldValidator<String> validator(String errorMessage) {
    return (value) {
      if (value!.isEmpty) {
        emit(RegisterPasswordValidatorState());
        return errorMessage;
      }
    };
  }
  VoidCallback? suffixPressed() {
    showPassword = !showPassword;
    emit(RegisterSuffixPressedState());
  }
  IconData suffixIcon()=> showPassword ? Icons.visibility : Icons.visibility_off;
  void checkBox() {
    isCheckBox = !isCheckBox;
    emit(RegisterCheckBoxState());
  }
}
