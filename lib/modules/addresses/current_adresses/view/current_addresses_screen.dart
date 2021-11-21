import 'dart:collection';
import 'package:e_shop/modules/addresses/new_address/view/new_address_screen.dart';
import 'package:e_shop/modules/google_map/view/map_previewer.dart';
import 'package:e_shop/modules/layout/cubit/home_cubit.dart';
import 'package:e_shop/modules/layout/cubit/home_states.dart';
import 'package:e_shop/services/routing/navigation.dart';
import 'package:e_shop/shared/components/builders/myConditional_builder.dart';
import 'package:e_shop/shared/components/reusable/dialogue/default_dialogue.dart';
import 'package:e_shop/shared/components/reusable/painter/square_painter.dart';
import 'package:e_shop/shared/components/reusable/spaces_and_dividers/spaces.dart';
import 'package:e_shop/shared/cubits/app_cubit/app_cubit.dart';
import 'package:e_shop/shared/models/api/addresses/get_addresses.dart';
import 'package:e_shop/styles/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

/// REVIEWED
class AddressesScreen extends StatefulWidget {
  const AddressesScreen({Key? key}):super(key: key);
  @override
  State<AddressesScreen> createState() => AddressesScreenState();
}

class AddressesScreenState extends State<AddressesScreen> {
  // Completer<GoogleMapController> _controller = Completer();
  // static final CameraPosition _kInitialPosition = CameraPosition(
  //   target: LatLng(31.03296133580664, 31.393749655962),
  //   zoom: 14.4746,
  // );
  // static final CameraPosition _kLake = CameraPosition(
  //   target: LatLng(37.43296265331129, -122.08832357078792),
  //   tilt: 59.440717697143555,
  //   zoom: 19.151926040649414,
  // );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is DeleteAddressSuccessState) {
          LayoutCubit.get(context).getAddresses();
          if (state.deleteAddressModel!.status!)
            Utils.showSnackBar(
                context, state.deleteAddressModel!.message!,
                dialogueStates: DialogueStates.SUCCESS);
          else
            Utils.showSnackBar(
                context, state.deleteAddressModel!.message!,
                dialogueStates: DialogueStates.ERROR);
        }
      },
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        var isDark = AppCubit.get(context).isDark;
        var addressModel = cubit.addressModel?.data?.data;

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const _HeaderLabel(),
                  const _AddNewAddress(),

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
                    onBuild: (addressModel != null && addressModel.length > 0)
                        ? ListView.builder(
                            itemCount: (addressModel.length),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var address = addressModel[index];


                              return _AddressItem(cubit, isDark, index, address);
                            },
                          )
                        : Center(
                            child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Text('no_addresses'.tr()),
                          ),
                    ),
                    onError:const Center(
                      child: kLoadingFadingCircle,
                    ),
                  ),
                ],
              ),
            ),
          ),

        );
      },
    );
  }
}

class _HeaderLabel extends StatelessWidget {
  const _HeaderLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'your_addresses'.tr(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'update_your_address'.tr(),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}
class _AddNewAddress extends StatelessWidget {
  const _AddNewAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
           const NewAddressScreen(
                heroTag: 'new',
              ),
          ),
          child: Tooltip(
            padding: EdgeInsets.all(10.0),
            message:
                'add_new_address'.tr(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Icon(
                  Icons.add,
                  size: 50,
                ),
                YSpace.titan,
                 Text( 'add_new_address'.tr(),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddressItem extends StatelessWidget {
  final LayoutCubit cubit;
  final bool isDark ;
  final int index ;
  final AddressData address ;
  const _AddressItem( this.cubit,this.isDark, this.index, this.address,{Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      collapsedIconColor:
      isDark ? Colors.white : Colors.black87,
      title: Text('address'.tr()+' ${index + 1}'),
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
                color: Theme.of(context).primaryColor.withOpacity(0.7),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  Text(
                    'address'.tr()+' ${index + 1}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(
                        color: Colors.white),
                  ),
                  YSpace.hard,
                  _AddressSectionText(title:  'country'.tr(), subTitle: 'egypt'.tr()),
                  _AddressSectionText(title:  'city'.tr(), subTitle: '${address.city}'),
                  _AddressSectionText(title: 'region'.tr(), subTitle: '${address.region}'),
                  _AddressSectionText(title: 'region'.tr(), subTitle: '${address.region}'),
                 _AddressSectionText(title:  'address_type'.tr(), subTitle:  '${address.name}'),
                  _AddressSectionText(title:  'details'.tr(), subTitle:  '${address.details}'),
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
                  _AddressOnMap(address),
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
                      onPressed: () => Utils
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
  }
}
class _AddressSectionText extends StatelessWidget {
  final String title ;
  final String subTitle ;

  const _AddressSectionText({Key? key,required this.title,required this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
      Text(
        title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight:
        FontWeight.bold,
      ),
    ),
        XSpace.normal,
        Text(
          subTitle,
          style:const TextStyle(
              color: Colors.white),
        ),
      ],
    );
  }
}
class _AddressOnMap extends StatefulWidget {
  final AddressData address;
  const _AddressOnMap(this.address,{Key? key}) : super(key: key);

  @override
  _AddressOnMapState createState() => _AddressOnMapState();
}
class _AddressOnMapState extends State<_AddressOnMap> {

  var markers = HashSet<Marker>();
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.18,
      child: Hero(
        tag: '${widget.address.id}',
        child: GoogleMap(
          markers: markers,
          onMapCreated:
              (GoogleMapController
          controller) {
            setState(() {
              if (_controller.isCompleted) {
                markers.add(
                  Marker(
                    visible: true,
                    markerId: MarkerId(
                        '${widget.address.id}'),
                    position: LatLng(
                        widget.address
                            .latitude!,
                        widget.address
                            .longitude!,
                    ),
                  ),
                );
              }
            });
          },
          mapType: MapType.hybrid,
          onTap: (latLng) => navigateTo(context, MapPreviewer(widget.address)),
          initialCameraPosition:
          CameraPosition(
            zoom: 14.5,
            target: LatLng(
                widget.address.latitude!,
                widget.address.longitude!),
          ),
        ),
      ),
    );
  }
}


