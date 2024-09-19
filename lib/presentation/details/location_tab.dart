import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  @override
  void initState() {
    super.initState();
    LatLng latLng = LatLng(widget.location[0], widget.location[1]);
    _center = CameraPosition(target: latLng, zoom: 14);
    _markers.add(Marker(
      markerId: MarkerId("1"),
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
    return GoogleMap(
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      mapType: MapType.satellite,
      myLocationButtonEnabled: false,
      initialCameraPosition: _center,
      markers: Set<Marker>.of(_markers),
      onMapCreated: (GoogleMapController controller) {
        _mapController.complete(controller);
      },
      onTap: (pos) {},
    );
  }
}
