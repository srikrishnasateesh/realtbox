

import 'package:realtbox/data/model/amenities/amenity-list-dto.dart';
import 'package:realtbox/data/model/property/property_response.dart';

class Property {
  final String propertyId;
  final String categoryId;
  final String categoryName;
  final String subCategoryId;
  final String subCategoryName;
  final String description;
  final String assetId;
  final String assetName;
  final String propertySize;
  final String projectName;
  final String price;
  final String location;
  final List<String> images;
  final List<String> headerImages;
  final List<String> floorImages;
  final List<String> videos;
  final List<AmenityData> amenities;
  final List<Unit> units;
  final List<double> geoLocation;

  Property({
    required this.propertyId,
    required this.categoryId,
    required this.categoryName,
    required this.subCategoryId,
    required this.subCategoryName,
    required this.description,
    required this.assetId,
    required this.assetName,
    required this.propertySize,
    required this.projectName,
    required this.price,
    required this.location,
    required this.images,
    required this.headerImages,
    required this.floorImages,
    required this.videos,
    required this.amenities,
    required this.units,
    required this.geoLocation,
  });
}
