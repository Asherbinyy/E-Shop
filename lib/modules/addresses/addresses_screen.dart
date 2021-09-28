import 'dart:collection';
import '../../layout/cubit/home_cubit.dart';
import '../../layout/cubit/home_states.dart';
import '../../models/api/addresses/get_addresses.dart';
import '../google_map/map_previewer.dart';
import '../../shared/components/builders/myConditional_builder.dart';
import '../../shared/components/methods/navigation.dart';
import '../../shared/components/reusable/dialogue/default_dialogue.dart';
import '../../shared/components/reusable/painter/square_painter.dart';
import '../../shared/components/reusable/spaces/spaces.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../styles/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../new_address/new_address_screen.dart';

class AddressesScreen extends StatefulWidget {
  @override
  State<AddressesScreen> createState() => AddressesScreenState();
}

class AddressesScreenState extends State<AddressesScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(31.03296133580664, 31.393749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is DeleteAddressSuccessState) {
          HomeCubit.get(context).getAddresses();
          if (state.deleteAddressModel!.status!)
            DefaultDialogue.showSnackBar(
                context, state.deleteAddressModel!.message!,
                dialogueStates: DialogueStates.SUCCESS);
          else
            DefaultDialogue.showSnackBar(
                context, state.deleteAddressModel!.message!,
                dialogueStates: DialogueStates.ERROR);
        }
      },
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        bool isDark = AppCubit.get(context).isDark;
        List<AddressData>? addressModel = cubit.addressModel?.data?.data;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Your Addresses',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                  //   child: Text(
                  //     '* Update your address /addresses for the shipped products *',
                  //     style: Theme.of(context).textTheme.caption,
                  //   ),
                  // ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    child: DashedRect(
                      color: Colors.grey,
                      gap: 10,
                      child: MaterialButton(
                        textColor: Colors.grey,
                        padding: EdgeInsets.zero,
                        onPressed: () => navigateTo(
                            context,
                            NewAddressScreen(
                              'new',
                            )),
                        child: Tooltip(
                          padding: EdgeInsets.all(10.0),
                          message:
                              ' Update your address /addresses for the shipped products ',
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 50,
                              ),
                              YSpace.titan,
                              Text('Add new Address'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10.0),
                  //   child: Text(
                  //     'Current Addresses :',
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .subtitle2
                  //         ?.copyWith(color: kPrimaryColorDarker),
                  //   ),
                  // ),
                  //address card
                  MyConditionalBuilder(
                    condition: addressModel != null,
                    builder: (addressModel != null && addressModel.length > 0)
                        ? ListView.builder(
                            itemCount: (addressModel.length),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            // separatorBuilder: (context, index) {
                            //   return Divider();
                            // },
                            itemBuilder: (context, index) {
                              var address = addressModel[index];
                              var markers = HashSet<Marker>();
                              Completer<GoogleMapController> _controller =
                                  Completer();

                              return ExpansionTile(
                                initiallyExpanded: true,
                                collapsedIconColor:
                                    isDark ? Colors.white : Colors.black87,
                                title: Text('Address ${index + 1}'),
                                subtitle: Text(
                                  '${address.city?.toUpperCase() ?? ''}',
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                children: [
                                  Stack(
                                    alignment: AlignmentDirectional.topEnd,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10.0),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: kPrimaryColor,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Address ${index + 1}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                            YSpace.hard,
                                            Row(
                                              children: [
                                                Text(
                                                  'Country',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                XSpace.normal,
                                                Text(
                                                  'Egypt',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'City',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                XSpace.normal,
                                                Text(
                                                  '${address.city}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Region',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                XSpace.normal,
                                                Text(
                                                  '${address.region}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Address Type',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                XSpace.normal,
                                                Text(
                                                  '${address.name}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Details',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                XSpace.normal,
                                                Text(
                                                  '${address.details}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                        if (address.notes!=null)  Row(
                                              children: [
                                                Text(
                                                  'Notes',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                XSpace.normal,
                                                Text(
                                                  '${address.notes}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            YSpace.normal,
                                            // MAP
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.18,
                                              child: Hero(
                                                tag: '${address.id}',
                                                child: GoogleMap(
                                                  markers: markers,
                                                  onMapCreated:
                                                      (GoogleMapController
                                                          controller) {
                                                    setState(() {
                                                      if (_controller
                                                          .isCompleted) {
                                                        markers.add(
                                                          Marker(
                                                            visible: true,
                                                            markerId: MarkerId(
                                                                '${address.id}'),
                                                            position: LatLng(
                                                                address
                                                                    .latitude!,
                                                                address
                                                                    .longitude!),
                                                          ),
                                                        );
                                                      }
                                                    });
                                                  },
                                                  mapType: MapType.hybrid,
                                                  onTap: (latLng) => navigateTo(
                                                      context,
                                                      MapPreviewer(address)),
                                                  initialCameraPosition:
                                                      CameraPosition(
                                                    zoom: 14.5,
                                                    target: LatLng(
                                                        address.latitude!,
                                                        address.longitude!),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Delete / Edit
                                      Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Tooltip(
                                              message: 'edit address',
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.lightGreen,
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            XSpace.normal,
                                            Tooltip(
                                              message: 'delete address',
                                              child: IconButton(
                                                onPressed: () => DefaultDialogue
                                                    .showAlertDialog(
                                                  context,
                                                  title: 'Delete addresses  ',
                                                  content:
                                                      'Are you sure that you want to delete this address from your addresses ? ',
                                                  isDestructiveAction: true,
                                                  onPressedA: () {
                                                    cubit.deleteAddress(
                                                        address.id!);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                icon: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          )
                        : Center(
                            child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Text('No Addresses Added yet '),
                          )),
                    feedback: Center(
                      child: kLoadingFadingCircle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // GoogleMap(
          //   mapType: MapType.satellite,
          //   initialCameraPosition: _kInitialPosition,
          //   // onMapCreated: (GoogleMapController controller) {
          //   //   _controller.complete(controller);
          //   // },
          // ),
        );
      },
    );
  }
}
