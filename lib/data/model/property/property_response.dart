import 'package:json_annotation/json_annotation.dart';
part 'property_response.g.dart';

@JsonSerializable()
class PropertyResponse {
  final bool success;
  final List<PropertyData> data;

  PropertyResponse({
    required this.success,
    required this.data,
  });

  factory PropertyResponse.fromJson(Map<String, dynamic> json) =>
      _$PropertyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyResponseToJson(this);
}

@JsonSerializable()
class PropertyData {
  @JsonKey(name: "_id")
  final String id;
  final String category;
  final String categoryName;
  final String subcategory;
  final String subcategoryName;
  final String description;
  final String status;
  final String asset;
  final String assetName;
  final String? location;
  final String propertysize;
  final String projectName;
  final String currencyType;
  final int price;
  final List<PropertyDoc> propertyDocs;
  final DateTime created;
  final String? formattedAddress;
  final AdvanceFeatures? advanceFeatures;

  PropertyData({
    required this.id,
    required this.category,
    required this.categoryName,
    required this.subcategory,
    required this.subcategoryName,
    required this.description,
    required this.status,
    required this.asset,
    required this.assetName,
    required this.location,
    required this.propertysize,
    required this.projectName,
    required this.currencyType,
    required this.price,
    required this.propertyDocs,
    required this.created,
    required this.formattedAddress,
    required this.advanceFeatures,
  });

  factory PropertyData.fromJson(Map<String, dynamic> json) =>
      _$PropertyDataFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyDataToJson(this);
}

@JsonSerializable()
class PropertyDoc {
  final String objectUrl;
  final String document;

  PropertyDoc({
    required this.objectUrl,
    required this.document,
  });

  factory PropertyDoc.fromJson(Map<String, dynamic> json) =>
      _$PropertyDocFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyDocToJson(this);
}

@JsonSerializable()
class AdvanceFeatures {
  final int? maxRooms;
  final int? beds;
  final int? baths;
  final List<String>? amenity;

  AdvanceFeatures({
    required this.maxRooms,
    required this.beds,
    required this.baths,
    required this.amenity,
  });

  factory AdvanceFeatures.fromJson(Map<String, dynamic> json) => _$AdvanceFeaturesFromJson(json);

  Map<String, dynamic> toJson() => _$AdvanceFeaturesToJson(this);
}
