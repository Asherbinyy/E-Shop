import 'package:e_shop/models/api/addresses/new_address.dart';

abstract class AddressStates {}

class AddressInitialState extends AddressStates {}

class PlaceYourLocationState extends AddressStates {}

// stepper
class ChangeStepState extends AddressStates {}
class OnStepContinueState extends AddressStates {}

class ToggleIsMapSelectionState extends AddressStates {}

class OnStepCancelState extends AddressStates {}



// Radio ListTiles
class ChangeRadioTileState extends AddressStates {}


// location
class AddNewAddressLoadingState extends AddressStates{}
class AddNewAddressSuccessState extends AddressStates{
  final   NewAddressModel ? newAddressModel;
  AddNewAddressSuccessState(this.newAddressModel);
}
class AddNewAddressErrorState extends AddressStates{
  final String error ;
  AddNewAddressErrorState(this.error);
}

class GetCurrentLocationLoadingState extends AddressStates {}
class GetCurrentLocationSuccessState extends AddressStates {}
class GetCurrentLocationErrorState extends AddressStates {
  final String error ;
  GetCurrentLocationErrorState(this.error);
}





