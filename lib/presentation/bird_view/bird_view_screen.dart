import 'dart:async';
import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realtbox/config/resources/color_manager.dart';
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
                      _customInfoWindowWidget(
                        loc.projectName,
                        loc.image,
                        formatStringPrice(loc.minPrice),
                        loc.minSize,
                      ),
                      position,
                    )
                  });
            });
          },
        ));
      }
    });
  }

  Future<void> loadMarkers() async {
    final BitmapDescriptor circleIcon =
        await createCustomCircleIcon(60.0, Colors.red);

    /*  setState(() {
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
                      _customInfoWindowWidget("ww"),
                      loc.position,
                    )
                  });
            });
          },
        ));
      }
    }); */
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
            height: 300,
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
  ) {
    return Column(
      children: [
        Image.network(imageUrl,
        width: double.infinity,
        height: 150,),
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
                    textStyle:
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: kSecondaryColor,
                            ),
                  ),
                  const SizedBox(height: 8,),
                  BasicText(
                    text: "Price: $price onwards",
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: kSecondaryColor,
                        ),
                  ),
                  const SizedBox(height: 8,),
                  BasicText(
                    text: "Size: $size onwards",
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: kSecondaryColor,
                        ),
                  ),
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
