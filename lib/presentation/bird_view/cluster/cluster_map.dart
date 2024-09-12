/* import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' hide ClusterManager;
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart' as MapsClusterer;
import 'package:realtbox/presentation/bird_view/cluster/place.dart';

class ClusterMap extends StatefulWidget {
  @override
  _ClusterMapState createState() => _ClusterMapState();
}

class _ClusterMapState extends State<ClusterMap> {
  late GoogleMapController mapController;
  late MapsClusterer.ClusterManager<Place> clusterManager;

  final List<Place> places = [
    Place(name: 'Location 1', latLng: LatLng(17.4435, 78.3772)),
    Place(
        name: 'Location 2',
        latLng: LatLng(17.41905996864118, 78.35000421534583)),
    // Add more locations as needed
  ];

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    clusterManager = MapsClusterer.ClusterManager<Place>(
      places,
      _updateMarkers,
      markerBuilder: _markerBuilder,
    );
  }

  void _updateMarkers(Set<Marker> newMarkers) {
    setState(() {
      markers = newMarkers;
    });
  }

  Future<Marker> _markerBuilder(dynamic item) async {
    Place place = item as Place;
    return Marker(
      markerId: MarkerId(place.name),
      position: place.latLng,
      infoWindow: InfoWindow(title: place.name),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    clusterManager.setMapId(controller.mapId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Maps Clustering')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 10,
        ),
        onCameraMove: clusterManager.onCameraMove,
        markers: markers,
      ),
    );
  }
}
 */