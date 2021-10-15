import 'dart:async';
import 'dart:collection';
import 'package:e_shop/models/api/addresses/get_addresses.dart';
import 'package:e_shop/shared/components/reusable/app_bar/secondary_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
///REVIEWED
class MapPreviewer extends StatefulWidget {
  final AddressData address;
  const MapPreviewer(this.address, {Key? key}) : super(key: key);

  @override
  State<MapPreviewer> createState() => _MapPreviewerState();
}

class _MapPreviewerState extends State<MapPreviewer> {
  var markers = HashSet<Marker>();
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(title: 'preview_map'.tr(),),
      body: Hero(
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
          onTap: (position){
            markers.add(
              Marker(
                visible: true,
                markerId: MarkerId(
                    '${position.longitude+position.longitude}'),
                position: LatLng(
                  position
                      .latitude,
                  position
                      .longitude,
                ),
              ),
            );
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.address.latitude!, widget.address.longitude!),
            zoom: 14.5,
          ),
        ),
      ),
    );
  }
}
