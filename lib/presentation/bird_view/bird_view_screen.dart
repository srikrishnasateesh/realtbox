import 'dart:async';
import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realtbox/config/resources/color_manager.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/core/utils/custom_circle_icon.dart';
import 'package:realtbox/core/utils/price-fromatter.dart';
import 'package:realtbox/domain/entity/birdview.dart';
import 'package:realtbox/domain/usecase/birdview.dart';
import 'package:realtbox/presentation/widgets/basic_text.dart';

class BirdViewScreen extends StatefulWidget {
  final GetBirdView getBirdView;
  const BirdViewScreen({super.key, required this.getBirdView});

  @override
  State<BirdViewScreen> createState() => _BirdViewScreenState();
}

class _BirdViewScreenState extends State<BirdViewScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  CameraPosition _center =
      CameraPosition(target: LatLng(17.4065, 78.4772), zoom: 11);

  final List<Marker> _markers = [];
  late List<BirdView> _markersData;

  @override
  void initState() {
    super.initState();

    //loadMarkers();
    fetchMarkers();
  }

  Future<void> fetchMarkers() async {
    final response = await widget.getBirdView();
    _markersData = response.data ?? List.empty();
    final BitmapDescriptor circleIcon =
        await createCustomCircleIcon(60.0, Colors.red);

    setState(() {
      for (BirdView loc in _markersData) {
        debugPrint("Adding loc ${loc.image}");
        LatLng position = LatLng(loc.location[0], loc.location[1]);
        _markers.add(Marker(
          markerId: MarkerId(loc.id),
          position: position,
          icon: circleIcon,
          //infoWindow: loc.infoWindow,
          onTap: () {
            _customInfoWindowController.hideInfoWindow!();
            setState(() {
              _center = CameraPosition(target: position, zoom: 14);
              Future.delayed(const Duration(seconds: 1)).then((value) => {
                    _customInfoWindowController.addInfoWindow!(
                      _customInfoWindowWidget(loc.projectName, loc.image,
                          formatStringPrice(loc.minPrice), loc.minSize, loc.id),
                      position,
                    )
                  });
            });
          },
        ));
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _setMapBounds();
      });
    });
  }


  Future<void> _setMapBounds() async {
    final GoogleMapController controller = await _mapController.future;

    if (_markers.isNotEmpty) {
      LatLngBounds bounds = _getLatLngBounds(_markers);

      // Move the camera to show all markers within bounds with padding
      CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
      controller.animateCamera(cameraUpdate);
    }
  }

// Function to calculate LatLngBounds based on markers
  LatLngBounds _getLatLngBounds(List<Marker> markers) {
    double? minLat, maxLat, minLng, maxLng;

    for (var marker in markers) {
      final lat = marker.position.latitude;
      final lng = marker.position.longitude;

      if (minLat == null || lat < minLat) {
        minLat = lat;
      }
      if (maxLat == null || lat > maxLat) {
        maxLat = lat;
      }
      if (minLng == null || lng < minLng) {
        minLng = lng;
      }
      if (maxLng == null || lng > maxLng) {
        maxLng = lng;
      }
    }

    // Return LatLngBounds using the southwest (minLat, minLng) and northeast (maxLat, maxLng)
    return LatLngBounds(
      southwest: LatLng(minLat!, minLng!),
      northeast: LatLng(maxLat!, maxLng!),
    );
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
            mapType: MapType.normal,
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
            height: 330,
            width: 300,
            offset: 15,
          ),
        ],
      ),
    );
  }

  Widget _customInfoWindowWidget(
    String title,
    String imageUrl,
    String price,
    String size,
    String id,
  ) {
    return Column(
      children: [
        Image.network(
          imageUrl,
          width: double.infinity,
          height: 150,
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasicText(
                    text: title,
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: kSecondaryColor,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BasicText(
                    text: "Price: $price onwards",
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: kSecondaryColor,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BasicText(
                    text: "Size: $size onwards",
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: kSecondaryColor,
                        ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: FilledButton.icon(
                      onPressed: () {
                        Object args = {"id": id};
                        Navigator.pushNamed(context, RouteNames.propertyDetails,
                            arguments: args);
                      },
                      icon: const Icon(Icons.remove_red_eye_sharp),
                      label: const Text('View Details'),
                      iconAlignment: IconAlignment.end,
                      style: FilledButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: Colors.white),
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
            color: kPrimaryColor,
            width: 20.0,
            height: 10.0,
          ),
        ),
      ],
    ); 
  }
}
