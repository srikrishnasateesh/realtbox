/* import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: ClusterMap()));
}

class ClusterMap extends StatefulWidget {
  @override
  _ClusterMapState createState() => _ClusterMapState();
}

class _ClusterMapState extends State<ClusterMap> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  final List<LatLng> _locations = [
    LatLng(37.7749, -122.4194), // San Francisco
    LatLng(37.7750, -122.4180), // Close to the first marker
    LatLng(37.7760, -122.4170), // Close to the first marker
    LatLng(37.7780, -122.4200), // Another location
    LatLng(37.7790, -122.4300), // Another location
    LatLng(37.7785, -122.4195), // Close to the first marker
    LatLng(37.7775, -122.4205), // Close to the first marker
  ];

  @override
  void initState() {
    super.initState();
    _initMarkers();
  }

  void _initMarkers() {
    for (var location in _locations) {
      _markers.add(
        Marker(
          markerId: MarkerId(location.toString()),
          position: location,
          infoWindow: InfoWindow(title: 'Location'),
        ),
      );
    }
    setState(() {
      
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Function to cluster markers
  Set<Marker> _clusterMarkers() {
    final Map<String, List<LatLng>> clusters = {};
    const double clusterRadius = 0.01; // Adjust this value for clustering sensitivity

    for (var location in _locations) {
      String clusterKey = '';

      // Determine which cluster this location belongs to
      for (var key in clusters.keys) {
        if (_isNearby(location, clusters[key]!.first, clusterRadius)) {
          clusterKey = key;
          break;
        }
      }

      if (clusterKey.isEmpty) {
        // Create a new cluster
        clusterKey = location.toString();
        clusters[clusterKey] = [location];
      } else {
        // Add to existing cluster
        clusters[clusterKey]!.add(location);
      }
      setState(() {
        
      });
    }

    // Create markers for clusters
    final Set<Marker> clusterMarkers = {};
    for (var entry in clusters.entries) {
      final clusterLocations = entry.value;
      final clusterPosition = _calculateClusterPosition(clusterLocations);
      clusterMarkers.add(
        Marker(
          markerId: MarkerId(entry.key),
          position: clusterPosition,
          infoWindow: InfoWindow(
            title: 'Cluster of ${clusterLocations.length} locations',
          ),
        ),
      );
    }

    return clusterMarkers;
  }

  // Check if two locations are nearby
  bool _isNearby(LatLng loc1, LatLng loc2, double radius) {
    final distance = _calculateDistance(loc1, loc2);
    return distance < radius;
  }

  // Calculate distance between two LatLng points
  double _calculateDistance(LatLng loc1, LatLng loc2) {
    final lat1 = loc1.latitude;
    final lon1 = loc1.longitude;
    final lat2 = loc2.latitude;
    final lon2 = loc2.longitude;

    const R = 6371; // Radius of the Earth in km
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) *
        sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance in km
  }

  double _toRadians(double degree) {
    return degree * (pi / 180);
  }

  // Calculate the average position of the cluster
  LatLng _calculateClusterPosition(List<LatLng> locations) {
    double latSum = 0;
    double lngSum = 0;

    for (var loc in locations) {
      latSum += loc.latitude;
      lngSum += loc.longitude;
    }

    return LatLng(latSum / locations.length, lngSum / locations.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Maps Clustering')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 12,
        ),
        markers: _clusterMarkers(),
      ),
    );
  }
} */