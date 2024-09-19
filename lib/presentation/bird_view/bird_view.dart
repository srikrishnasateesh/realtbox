import 'dart:async';
import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
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
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  CameraPosition _center =
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
          //infoWindow: loc.infoWindow,
          onTap: () {
            _customInfoWindowController.hideInfoWindow!();
            setState(() {
              _center = CameraPosition(target: loc.position, zoom: 14);
              Future.delayed(const Duration(seconds: 1)).then((value) => {
                    _customInfoWindowController.addInfoWindow!(
                      _customInfoWindowWidget(),
                      loc.position,
                    )
                  });
            });
          },
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            mapType: MapType.satellite,
            myLocationButtonEnabled: false,
            initialCameraPosition: _center,
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
              _customInfoWindowController.googleMapController = controller;
            },
            onTap: (pos) {
              _customInfoWindowController.hideInfoWindow!();
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 100,
            width: 200,
            offset: 0,
          ),
        ],
      ),
    );
  }

  Widget _customInfoWindowWidget() {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "I am here",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                  )
                ],
              ),
            ),
          ),
        ),
        Triangle.isosceles(
          edge: Edge.BOTTOM,
          child: Container(
            color: Colors.blue,
            width: 20.0,
            height: 10.0,
          ),
        ),
      ],
    ); /* Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
          ),
        ],
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Custom Info Window',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text('This is a custom description'),
        ],
      ),
    ); */
  }
}
