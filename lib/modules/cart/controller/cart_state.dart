part of 'cart_cubit.dart';

@immutable
abstract class CartStates {}

class CartInitial extends CartStates {}
//
class ToggleExpandedCartsState extends CartStates {}

// //carts
// class ToggleCartButtonState extends CartStates {}
// class ChangeCartSuccessState extends CartStates {
//   final ChangeCartModel ? changeCartModel;
//
//   ChangeCartSuccessState({this.changeCartModel});
// }
// class ChangeCartErrorState extends CartStates {
//   final String error ;
//   ChangeCartErrorState(this.error);
// }
// // class GetCartLoadingState extends CartStates {}
// // class GetCartSuccessState extends CartStates {
// //   final GetCartsModel ? getCartsModel;
// //
// //   GetCartSuccessState({this.getCartsModel});
// // }
// // class GetCartErrorState extends CartStates {
// //   final String error ;
// //   GetCartErrorState(this.error);
// // }
// // update carts
// class UpdateCartLoadingState extends CartStates {}
// class UpdateCartSuccessState extends CartStates {
//   final UpdateCartModel ? updateCartModel;
//
//   UpdateCartSuccessState(this.updateCartModel);
// }
// class UpdateCartErrorState extends CartStates {
//   final String error ;
//   UpdateCartErrorState(this.error);
// }
//
//
// class ToggleExpandedCartsState extends CartStates {}
