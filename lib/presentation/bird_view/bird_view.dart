import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realtbox/core/utils/custom_circle_icon.dart';

class BirdView extends StatefulWidget {
  const BirdView({super.key});

  @override
  State<BirdView> createState() => _BirdViewState();
}

class _BirdViewState extends State<BirdView> {
  final Completer<GoogleMapController> _mapController = Completer();
  static const CameraPosition _center =
      CameraPosition(target: LatLng(17.4065, 78.4772), zoom: 11);

  final List<Marker> _markers = [];
  final List<Marker> _branch = const [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(17.4435, 78.3772),
        infoWindow: InfoWindow(title: "Hitex")),
    Marker(
        markerId: MarkerId("2"),
        position: LatLng(17.41905996864118, 78.35000421534583),
        infoWindow: InfoWindow(title: "Ankur"))
  ];

  @override
  void initState() {
    super.initState();
    // _markers.addAll(_branch);
    loadMarkers();
  }

  Future<void> loadMarkers() async {
    final BitmapDescriptor circleIcon =
        await createCustomCircleIcon(60.0, Colors.red);

    setState(() {
      for (Marker loc in _branch) {
        debugPrint("Adding loc ${loc.markerId}");
        _markers.add(Marker(
          markerId: loc.markerId,
          position: loc.position,
          icon: circleIcon,
          infoWindow: loc.infoWindow,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBar(
        backgroundColor: Colors.transparent,
        //title: Text("Map"),
      ), */
      backgroundColor: Colors.transparent,
      body: GoogleMap(
        initialCameraPosition: _center,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
      ),
    );
  }
}
