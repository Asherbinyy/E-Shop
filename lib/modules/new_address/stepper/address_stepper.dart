import 'dart:async';
import 'package:e_shop/modules/new_address/cubit/address_cubit.dart';
import 'package:e_shop/modules/new_address/cubit/address_states.dart';

import '../new_address_screen.dart';
import '/layout/cubit/home_cubit.dart';
import '/layout/cubit/home_states.dart';
import '/models/api/addresses/get_addresses.dart';
import '/models/app/countries.dart';
import '/models/app/delivery_type.dart';
import '/modules/profile/profile_screen.dart';
import '/shared/components/builders/myConditional_builder.dart';
import '/shared/components/methods/navigation.dart';
import '/shared/components/reusable/spaces/spaces.dart';
import '/shared/components/reusable/text_field/default_text_field.dart';
import '/shared/cubit/app_cubit.dart';
import '/styles/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// class AddressStepper{
//   static List<GlobalKey<FormState>> keys = [
//     GlobalKey<FormState>(debugLabel: 'step1'),
//     GlobalKey<FormState>(debugLabel: 'step2'),
//   ];
//   static List<Step> steps (BuildContext context, AddressCubit addressCubit) =>
//       AddressStepperData.data.map((item) => Step(
//         state: addressCubit.currentStep > item.index
//             ? StepState.complete
//             : StepState.indexed,
//         isActive: addressCubit.currentStep >= item.index,
//         title: StepperTitle(item.title),
//         subtitle: addressCubit.currentStep == item.index
//             ? StepperSubTitle(item.subTitle)
//             : null,
//         content: item.content,
//       ),).toList();
// }



/// title
class StepperTitle extends StatelessWidget {
  final String label;
  const StepperTitle(
    this.label, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.subtitle2,
    );
  }
}

/// subTitle
class StepperSubTitle extends StatelessWidget {
  final String label;
  const StepperSubTitle(
    this.label, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.caption,
    );
  }
}

/// Step 1 Basic content
class BasicInfoContent extends StatelessWidget {
  const BasicInfoContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print( StepperControllers.city.text);
    print( StepperControllers.region.text);
    print( StepperControllers.details.text);
    print( StepperControllers.notes.text);
    return Builder(builder: (context) {
      return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            HomeCubit cubit = HomeCubit.get(context);
            var profile = HomeCubit.get(context).profileModel?.data;
            StepperControllers.name.text = profile?.name ?? '';
            StepperControllers.phone.text = profile?.phone ?? '';
            bool isDark = AppCubit.get(context).isDark;
            return Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey,
                  )),
                  child: Form(
                    key: StepperFormKeys.stepperKeys.first,
                    child: Column(
                      children: [
                        DefaultTextField(
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Name Must not be empty !';
                            else
                              return null;
                          },
                          prefixIcon: Icons.verified_user,
                          label: 'Name',
                          controller: StepperControllers.name,
                          isDark: isDark,
                          readOnly: true,
                        ),
                        DefaultTextField(
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'Phone number must be provided ';
                            else
                              return null;
                          },
                          prefixIcon: Icons.phone_android,
                          label: 'Phone',
                          controller: StepperControllers.phone,
                          isDark: isDark,
                          readOnly: true,
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    navigateTo(context, ProfileScreen());
                    cubit.isEditableProfile = true;
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.edit),
                      XSpace.tiny,
                      Text('Edit'),
                    ],
                  ),
                ),
              ],
            );
          });
    });
  }
}

/// Step 2 Address content
class AddressContent extends StatelessWidget {
  const AddressContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = AppCubit.get(context).isDark;
    return Builder(builder: (context) {
      return BlocConsumer<AddressCubit, AddressStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AddressCubit cubit = AddressCubit.get(context);
            return Form(
              key: StepperFormKeys.stepperKeys.last,
              child: Column(
                children: [
                  DropdownButtonFormField<dynamic>(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        label: Text(
                          'Country',
                          style: TextStyle(
                              color:
                                  isDark ? Colors.white : kPrimaryColor),
                        ),
                      ),
                      iconDisabledColor: Colors.grey,
                      dropdownColor:
                          isDark ? kDarkSecondaryColor : kLightSecondaryColor,
                      iconEnabledColor: kPrimaryColor,
                      value: cubit.initialValue,
                      onChanged: (value) => cubit.changeCountryValue(value!),
                      items: CountriesModel.getCountries
                          .map((e) => DropdownMenuItem<dynamic>(
                                value: e.name,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        e.image,
                                        height: 20,
                                        width: 20,
                                      ),
                                      XSpace.normal,
                                      Text(
                                        e.name,
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : kPrimaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList()),
                  DefaultTextField(
                    controller: StepperControllers.city,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'City Must not be empty';
                      else
                        return null;
                    },
                    isDark: isDark,
                    label: 'City',
                    prefixIcon: FontAwesomeIcons.city,
                  ),
                  DefaultTextField(
                    controller: StepperControllers.region,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'Region Must not be empty';
                      else
                        return null;
                    },
                    isDark: isDark,
                    label: 'Region',
                    prefixIcon: FontAwesomeIcons.locationArrow,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      hintColor: isDark ? Colors.amber : Colors.amber.shade700,
                    ),
                    child: DefaultTextField(
                      controller: StepperControllers.details,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'Please, add some details for example : street and flat number';
                        else
                          return null;
                      },
                      isDark: isDark,
                      label: 'Detailed Address St..etc',
                      maxLength: 80,
                      maxLines: 3,
                      prefixIcon: FontAwesomeIcons.searchLocation,
                    ),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      hintColor: isDark ? Colors.amber : Colors.amber.shade700,
                    ),
                    child: DefaultTextField(
                      controller: StepperControllers.notes,
                      keyboardType: TextInputType.name,
                      isDark: isDark,
                      label: '( Optional ) Notes',
                      maxLength: 80,
                      maxLines: 3,
                      prefixIcon: FontAwesomeIcons.solidStickyNote,
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}

/// Step 3 Delivery content
class DeliveryTypeContent extends StatelessWidget {
  const DeliveryTypeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final bool isDark = AppCubit.get(context).isDark;
      final TextTheme textTheme = Theme.of(context).textTheme;
      final Color unselectedColor = Colors.grey;
      final Color selectedColor = kSecondaryColor;
      return BlocConsumer<AddressCubit, AddressStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AddressCubit cubit = AddressCubit.get(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Specify your address type :',style: TextStyle(color: Colors.grey),),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: DeliveryTypeModel.getAddressesType.length,
                    itemBuilder: (context, index) {
                      var model = DeliveryTypeModel.getAddressesType[index];
                      return Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: unselectedColor,
                        ),
                        child: RadioListTile<String>(
                          activeColor: selectedColor,
                          title: Text(
                            '${model.label}',
                            style: textTheme.bodyText2?.copyWith(
                                color: model.label! == cubit.groupValue
                                    ? selectedColor
                                    : unselectedColor),
                          ),
                          subtitle: model.label! == cubit.groupValue
                              ? Text(
                                  '${model.subTitle}',
                                  style: textTheme.caption?.copyWith(
                                    color: unselectedColor,
                                  ),
                                )
                              : null,
                          value: model.label!,
                          groupValue: cubit.groupValue,
                          onChanged: (String? value) =>
                              cubit.changeRadioTile(value!),
                        ),
                      );
                    }),
              ],
            );
          });
    });
  }
}

/// Step 4 Location content
class LocationContent extends StatelessWidget {
  const LocationContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AddressCubit addressCubit = AddressCubit.get(context);
          return MyConditionalBuilder(
            condition: addressCubit.isMapSelection,
            builder: _LocateOnMap(),
            feedback: _SelectionMenu(),
          );
        });
  }
}

class _LocateOnMap extends StatefulWidget {
  const _LocateOnMap({Key? key}) : super(key: key);

  @override
  State<_LocateOnMap> createState() => _LocateOnMapState();
}

class _LocateOnMapState extends State<_LocateOnMap> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);

          AddressData? lastKnowAddress = cubit.addressModel?.data?.data?.last;

          /// Egypt co-ordinates used if no previous address provided
          const LatLng kDefaultLatLng =
              LatLng(30.346642654529937, 31.17326803807425);
          List<Marker> _markers = [];
          Completer<GoogleMapController> _controller = Completer();

          return MyConditionalBuilder(
            condition: lastKnowAddress != null,
            builder: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: GoogleMap(
                onMapCreated: (GoogleMapController googleMapController) {
                  // if (_controller.isCompleted){
                  //   print('isCompleted');
                  setState(() {
                    if (_controller.isCompleted) {
                      _markers.add(
                        Marker(
                          position: kDefaultLatLng,
                          markerId: MarkerId('kDefaultLatLng'),
                          // draggable: true,
                        ),
                      );
                    }
                    AddressCubit.get(context).saveAddressLatLng(kDefaultLatLng);
                  });
                },
                markers: _markers.map((e) => e).toSet(),
                mapType: MapType.hybrid,
                onTap: (LatLng point) {
                  print('New Point is : $point}');
                  AddressCubit.get(context).saveAddressLatLng(point);
                  Marker _newMarker = Marker(
                      infoWindow: InfoWindow(title: 'New Point'),
                      position: point,
                      markerId: MarkerId(point.toString()));
                  _markers.add(_newMarker);
                  setState(() {});
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      lastKnowAddress?.latitude ?? kDefaultLatLng.latitude,
                      lastKnowAddress?.longitude ?? kDefaultLatLng.longitude),
                  zoom: 14.5,
                ),
              ),
            ),
            feedback: _loading(),
          );
        });
  }

  Widget _loading() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: kLoadingWanderingCubes),
      );
}

class _SelectionMenu extends StatelessWidget {
  const _SelectionMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressStates>(
        listener: (context, state) {
      if (state is GetCurrentLocationSuccessState) {}
    }, builder: (context, state) {
      AddressCubit addressCubit = AddressCubit.get(context);
      return MyConditionalBuilder(
        condition: state is GetCurrentLocationLoadingState,
        builder: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(child: kLoadingPulse),
        ),
        feedback: Container(
          padding: const EdgeInsets.all(8.0),
          // color:kPrimaryColorDarker.withOpacity(0.1),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: kSecondaryColor,
                  ),
                  onPressed: () =>
                      addressCubit.getCurrentLocationAsNewAddress(),
                  icon: const Icon(Icons.my_location),
                  label: const Text('My Current Location'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: AppCubit.get(context).isDark
                        ? Colors.white10
                        : Colors.black,
                  ),
                  onPressed: () => addressCubit.toggleIsMapSelection(),
                  icon: const Icon(Icons.location_on_rounded),
                  label: const Text(
                    'Locate on Map',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
