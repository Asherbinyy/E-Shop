import 'package:e_shop/models/api/addresses/get_addresses.dart';
import 'package:e_shop/shared/components/reusable/app_bar/secondary_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPreviewer extends StatelessWidget {
  final AddressData address;
  const MapPreviewer(this.address, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: 'Preview Map',),
      body: Hero(
        tag: '${address.id}',
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
            target: LatLng(address.latitude!, address.longitude!),
            zoom: 14.5,
          ),
        ),
      ),
    );
  }
}
