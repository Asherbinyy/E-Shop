import 'package:bloc/bloc.dart';
import 'package:e_shop/models/api/addresses/new_address.dart';
import 'package:e_shop/models/app/delivery_type.dart';
import 'package:e_shop/modules/new_address/stepper/address_stepper.dart';
import 'package:e_shop/network/location/location.dart';
import 'package:e_shop/network/remote/dio_helper.dart';
import 'package:e_shop/network/remote/end_points.dart';
import 'package:e_shop/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../new_address_screen.dart';
import 'address_states.dart';

class AddressCubit extends Cubit<AddressStates> {
  AddressCubit() : super(AddressInitialState());

  static AddressCubit get(context) => BlocProvider.of(context);
//------------------------------------------------------------------------------

  int currentStep = 0;

  void changeStep(int index,int stepperLength, List<GlobalKey<FormState>> keys) {
    currentStep = index ;
    emit(ChangeStepState());
  }

  void onStepContinue(int stepperLength, List<GlobalKey<FormState>> keys) {
    bool isLastStep = currentStep == stepperLength - 1;
     // String _city = '';
     // String _region = '';
     // String _details = '';
     // String _notes = '';

    if (isLastStep) {
      addNewAddress(
        city: StepperControllers.city.text,
        deliverType: groupValue!,
        region: StepperControllers.region.text,
        details: StepperControllers.details.text,
        notes: StepperControllers.notes.text ,
        lat: '${selectedAddress?.latitude}',
        lon: '${selectedAddress?.longitude}',
      );
      // print( StepperControllers.city.text);
      // print(groupValue);
      // print( StepperControllers.region.text);
      // print( StepperControllers.details.text);
      // print( StepperControllers.notes.text);
      // print( selectedAddress?.latitude);
      // print( selectedAddress?.longitude);
    }
    else if (currentStep == 2) {
      print('hideeeeeeeeeeee');
      currentStep++;
      emit(PlaceYourLocationState());
    } else if (currentStep == 3){
      currentStep++;
    }
    else {
      if (keys[currentStep].currentState!.validate()) {
        print('valid');
        currentStep++;
      } else
        print('invalid');
    }

    emit(OnStepContinueState());
  }

  //
  // bool validate (GlobalKey<FormState> formKey){
  //   if (formKey.currentState!.validate())
  //     return true ;
  //   else return false;
  // }

  /// whether to build google map widget or selection menu
  bool isMapSelection = false;
  void toggleIsMapSelection() {
    isMapSelection = !isMapSelection;
    emit(ToggleIsMapSelectionState());
  }

  // void onStepCancel (int stepperLength){
  void onStepCancel() {
    if (currentStep != 0) {
      currentStep--;
      if (currentStep == 2)
        toggleIsMapSelection(); //returns (Place on Location) widget to original state
    }
    emit(OnStepCancelState());
  }

  // Radio ListTiles
  String? groupValue = DeliveryTypeModel.getAddressesType.first.label;
  bool isSelected = false;
  void changeRadioTile(String newValue) {
    groupValue = newValue;
    emit(ChangeRadioTileState());
  }

  // dropdown country

  String initialValue = 'EG';
  void changeCountryValue(String newValue) {
    initialValue = newValue;
    emit(ChangeRadioTileState());
  }

  /// The selected address by user on map
  LatLng? selectedAddress;
  void saveAddressLatLng(LatLng point) {
    selectedAddress = point;
  }

  void getCurrentLocationAsNewAddress() {
    emit(GetCurrentLocationLoadingState());

    LocationHelper.getCurrentPosition().then((value) {
      saveAddressLatLng(LatLng(value.latitude, value.longitude));
      emit(GetCurrentLocationSuccessState());
      currentStep ++ ;
    }).catchError((error) {
      emit(GetCurrentLocationErrorState(error.toString()));
    });
  }

  NewAddressModel? _newAddressModel;
  void addNewAddress({
    required final String city,
    required final String deliverType,
    required final String region,
     final String ?details,
     final String ?notes,
    required final String lat,
    required final String lon,
  }) {
    emit(AddNewAddressLoadingState());
    DioHelper.postData(
      url: ADDRESSES,
      data: {
        'name': deliverType,
        'city': city,
        'region': region,
        'details': details?? '',
        'notes': notes ?? '',
        'latitude': lat,
        'longitude': lon,
      },
      token: '$token',
    ).then(
      (value) {
        _newAddressModel = NewAddressModel.fromJson(value.data);
        // StepperControllers.clear();
        /// call get Addresses from Home cubit
        emit(AddNewAddressSuccessState(_newAddressModel));
      },
    ).catchError(
      (error) {
        emit(AddNewAddressErrorState(error.toString()));
      },
    );
  }
}
