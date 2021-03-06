import 'dart:async';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/shared/models/app/countries.dart';
import 'package:e_shop/shared/models/app/delivery_type.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../profile/view/profile_screen.dart';
import '/shared/components/builders/myConditional_builder.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import '/shared/components/reusable/text_field/default_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:e_shop/modules/addresses/new_address/cubit/address_cubit.dart';
import 'package:e_shop/modules/addresses/new_address/cubit/address_states.dart';
import 'package:e_shop/modules/addresses/new_address/model/stepper/stepper_controller.dart';
import 'package:e_shop/modules/addresses/new_address/model/stepper/stepper_keys.dart';
import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/components/builders/myConditional_builder.dart';
import 'package:e_shop/styles/constants/constants.dart';
///REVIEWED


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
    return Builder(builder: (context) {
      return BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            LayoutCubit cubit = LayoutCubit.get(context);
            var profile = LayoutCubit.get(context).profileModel?.data;
            StepperControllers.name.text = profile?.name ?? '';
            StepperControllers.phone.text = profile?.phone ?? '';
            var isDark = AppCubit.get(context).isDark;
            return Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  padding:const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.grey,
                  )),
                  child: Form(
                    key: StepperFormKeys.stepperKeys.first,
                    child: Column(
                      children: [
                        DefaultTextField(
                          primaryColor:  Theme.of(context).primaryColor.withOpacity(0.6),
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'empty_name'.tr();
                            else
                              return null;
                          },
                          prefixIcon: Icons.verified_user,
                          label: 'name'.tr(),
                          controller: StepperControllers.name,
                          isDark: isDark,
                          readOnly: true,
                        ),
                        DefaultTextField(
                          primaryColor:  Theme.of(context).primaryColor.withOpacity(0.6),

                          validator: (value) {
                            if (value!.isEmpty)
                              return 'empty_phone'.tr();
                            else
                              return null;
                          },
                          prefixIcon: Icons.phone_android,
                          label: 'phone'.tr(),
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
                    navigateTo(context,const ProfileScreen());
                    cubit.isEditableProfile = true;
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.edit),
                      XSpace.tiny,
                       Text('edit'.tr()),
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
    var isDark = AppCubit.get(context).isDark;
    return Builder(builder: (context) {
      return BlocConsumer<AddressCubit, AddressStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AddressCubit.get(context);
            return Form(
              key: StepperFormKeys.stepperKeys.last,
              child: Column(
                children: [
                  DropdownButtonFormField<dynamic>(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:const BorderSide(color: Colors.transparent),
                        ),
                        label: Text(
                          'country'.tr(),
                          style: TextStyle(
                              color:
                                  isDark ? Colors.white : Theme.of(context).primaryColor),
                        ),
                      ),
                      iconDisabledColor: Colors.grey,
                      dropdownColor:
                          isDark ? kDarkSecondaryColor : kLightSecondaryColor,
                      iconEnabledColor: Theme.of(context).primaryColor,
                      value: cubit.initialValue,
                      onChanged: (value) => cubit.changeCountryValue(value!),
                      items: CountriesModel.getCountries
                          .map((e) => DropdownMenuItem<dynamic>(
                                value: e.value,
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
                                              : Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList()),
                  DefaultTextField(
                    primaryColor:  Theme.of(context).primaryColor.withOpacity(0.6),

                    controller: StepperControllers.city,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'empty_city'.tr();
                      else
                        return null;
                    },
                    isDark: isDark,
                    label: 'city'.tr(),
                    prefixIcon: FontAwesomeIcons.city,
                  ),
                  DefaultTextField(
                    primaryColor:  Theme.of(context).primaryColor.withOpacity(0.6),

                    controller: StepperControllers.region,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty)
                        return 'empty_region'.tr();
                      else
                        return null;
                    },
                    isDark: isDark,
                    label: 'region'.tr(),
                    prefixIcon: FontAwesomeIcons.locationArrow,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      hintColor: isDark ? Colors.amber : Colors.amber.shade700,
                    ),
                    child: DefaultTextField(
                      primaryColor:  Theme.of(context).primaryColor.withOpacity(0.6),

                      controller: StepperControllers.details,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty)
                          return 'empty_details'.tr();
                        else
                          return null;
                      },
                      isDark: isDark,
                      label: 'details_address'.tr(),
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
                      primaryColor:  Theme.of(context).primaryColor.withOpacity(0.6),

                      controller: StepperControllers.notes,
                      keyboardType: TextInputType.name,
                      isDark: isDark,
                      label: 'notes'.tr(),
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
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
          var addressCubit = AddressCubit.get(context);
          return MyConditionalBuilder(
            condition: addressCubit.isMapSelection,
            onBuild: const _LocateOnMap(),
            onError:const _SelectionMenu(),
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
    return BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          var lastKnowAddress = cubit.addressModel?.data?.data?.last ;
          List<Marker> _markers = [];
          Completer<GoogleMapController> _controller =  Completer();
          return MyConditionalBuilder(
            condition: lastKnowAddress != null,
            onBuild: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: GoogleMap(
                onMapCreated: (GoogleMapController googleMapController) {

                  setState(() {
                    if (_controller.isCompleted) {
                      _markers.add(
                        Marker(
                          position: kDefaultLatLng,
                          markerId:const MarkerId('kDefaultLatLng'),
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
                  print('new_point'.tr()+'$point}');
                  AddressCubit.get(context).saveAddressLatLng(point);
                  Marker _newMarker = Marker(
                      infoWindow: InfoWindow(title: 'new_point'),
                      position: point,
                      markerId: MarkerId(point.toString()),
                  );
                  _markers.add(_newMarker);
                  setState(() {});
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      lastKnowAddress?.latitude ?? kDefaultLatLng.latitude,
                      lastKnowAddress?.longitude ?? kDefaultLatLng.longitude,
                  ),
                  zoom: 14.5,
                ),
              ),
            ),
            onError: _loading(),
          );
        });
  }

  Widget _loading() => Padding(
        padding: const EdgeInsets.all(20.0),
        child :const Center(child: kLoadingWanderingCubes),
      );
}

class _SelectionMenu extends StatelessWidget {
  const _SelectionMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressStates>(
        listener: (context, state) {
      // if (state is GetCurrentLocationSuccessState) {}
    }, builder: (context, state) {
      var addressCubit = AddressCubit.get(context);
      return MyConditionalBuilder(
        condition: state is GetCurrentLocationLoadingState,
        onBuild: Padding(
          padding: const EdgeInsets.all(20.0),
          child: const Center(child: kLoadingPulse),
        ),
        onError: Container(
          padding: const EdgeInsets.all(8.0),
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
                  label:  Text('my_current_location'.tr()),
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
                  label:  Text(
                    'locate_on_map'.tr(),
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
