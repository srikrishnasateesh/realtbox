import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/core/utils/data_utils.dart';

class LocationTab extends StatefulWidget {
  final List<double> location;
  final String id;
  final String address;
  final String projectName;
  const LocationTab({
    super.key,
    required this.location,
    required this.id,
    required this.address,
    required this.projectName,
  });

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  final Completer<GoogleMapController> _mapController = Completer();

  late CameraPosition _center;
  final List<Marker> _markers = [];
  late LatLng latLng;
  @override
  void initState() {
    super.initState();
    latLng = LatLng(widget.location[0], widget.location[1]);
    _center = CameraPosition(target: latLng, zoom: 14);
    _markers.add(Marker(
      markerId: const MarkerId("1"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      position: latLng,
      infoWindow: InfoWindow(
        title: widget.projectName,
        snippet: widget.address,
      ),
      onTap: () {},
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        mapType: MapType.terrain,
        myLocationButtonEnabled: false,
        initialCameraPosition: _center,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) async {
          _mapController.complete(controller);
          await Future.delayed(const Duration(milliseconds: 500)); // Add a slight delay to ensure map is fully initialized
          controller.showMarkerInfoWindow(const MarkerId("1"));
        },
        onTap: (pos) {},
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.directions,
        color: Colors.white,
        size: 40,),
        onPressed: () {
        openMap(latLng.latitude, latLng.longitude);
      },
      ),
    );
  }
}
