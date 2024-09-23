import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/color_manager.dart';

enum BottomBarItems {
  propertyList('Properties'),
  mapView('Map View'),
  saved('Saved'),
  profile('Profile');

  // Fields to hold the parameters
  final String label;

  // Constructor to initialize the parameters
  const BottomBarItems(this.label);
}
