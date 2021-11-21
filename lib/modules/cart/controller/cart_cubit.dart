import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitial());

  static CartCubit get(BuildContext context) => BlocProvider.of(context);


  // expand  cart tiles
  bool isExpandedCarts = false;

  void toggleExpandedCarts() {
    isExpandedCarts = !isExpandedCarts;
    emit(ToggleExpandedCartsState());
  }
}
