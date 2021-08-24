import 'package:bloc/bloc.dart';
import 'package:e_shop/modules/landing_screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingCubit extends Cubit {
  LandingCubit() : super(LandingInitialState());


  LandingCubit get (BuildContext context) => BlocProvider.of(context);









}