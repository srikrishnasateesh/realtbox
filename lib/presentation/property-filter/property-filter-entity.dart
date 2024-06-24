import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/domain/entity/amenity.dart';

class PropertyFilter extends Equatable {
  List<Amenity> selectedAmenities;
  Budget selectedBudget;
  Location? selectedLocation;
  SortBy sortBy;

  PropertyFilter({
    required this.selectedAmenities,
    required this.selectedBudget,
    required this.selectedLocation,
    required this.sortBy,
  });

  @override
  List<Object?> get props => [selectedAmenities, selectedBudget];
}

class SortBy {
  final String selectedId;
  SortBy({required this.selectedId});
}

class Budget extends Equatable {
  RangeValues rangeValues;

  Budget({
    required this.rangeValues,
  });

  @override
  List<Object?> get props => [
        rangeValues,
      ];
}

class Location extends Equatable {
  final String address;
  final double lattitude;
  final double longitude;

  Location({
    required this.address,
    required this.lattitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [address, lattitude, longitude];
}
