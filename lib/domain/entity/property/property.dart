import 'package:json_annotation/json_annotation.dart';


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
  final List<String> amenities;

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
    required this.amenities,
  });
}
