import 'package:json_annotation/json_annotation.dart';
import 'package:realtbox/core/utils/price-fromatter.dart';
import 'package:realtbox/data/model/amenities/amenity-list-dto.dart';
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
  //final String? location;
  // final Propertysize propertySize;
  final String projectName;
  final String? projectBy;
  final String currencyType;
  final double? price;
  final double? pricePerUnit;
  final DateTime created;
  final String? formattedAddress;
  final AdvanceFeatures? advanceFeatures;
  final AddressData? address;
  //
  final int? numberOfTowers;
  final List<Tower>? towers;
  final List<VicinityElement>? vicinity;
  final bool? favProperty;
  final List<Unit>? units;
  final double? minimumPrice;
  final double? maximumPrice;
  final SizeObject? minimumSize;
  final SizeObject? maximumSize;
  final List<PropertyDoc>? brochure;
  final List<PropertyDoc>? floorPlan;
  final List<String>? video;
  final List<PropertyDoc>? galleryPics;
  final List<PropertyDoc>? buildingPlan;
  final List<PropertyDoc>? headerSectionPhotos;
  final List<PropertyDoc>? logo;
  
  final String? totalPrice;

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
    required this.projectName,
    required this.projectBy,
    required this.currencyType,
    required this.price,
    required this.created,
    required this.formattedAddress,
    required this.advanceFeatures,
    required this.pricePerUnit,
    required this.numberOfTowers,
    required this.towers,
    required this.vicinity,
    required this.favProperty,
    required this.units,
    required this.minimumPrice,
    required this.maximumPrice,
    required this.minimumSize,
    required this.maximumSize,
    required this.brochure,
    required this.floorPlan,
    required this.video,
    required this.galleryPics,
    required this.buildingPlan,
    required this.headerSectionPhotos,
    required this.logo,
    required this.address,
    required this.totalPrice,
  });

  factory PropertyData.fromJson(Map<String, dynamic> json) =>
      _$PropertyDataFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyDataToJson(this);
}

@JsonSerializable()
class PropertyDoc {
  final String objectUrl;
  final String document;
  final bool? isImage;

  PropertyDoc({
    required this.objectUrl,
    required this.document,
    required this.isImage,
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
  final List<AmenityData>? amenity;

  AdvanceFeatures({
    required this.maxRooms,
    required this.beds,
    required this.baths,
    required this.amenity,
  });

  factory AdvanceFeatures.fromJson(Map<String, dynamic> json) =>
      _$AdvanceFeaturesFromJson(json);

  Map<String, dynamic> toJson() => _$AdvanceFeaturesToJson(this);
}

@JsonSerializable()
class Propertysize {
  final double? value;
  final String? unit;

  Propertysize({
    required this.value,
    required this.unit,
  });

  factory Propertysize.fromJson(Map<String, dynamic> json) =>
      _$PropertysizeFromJson(json);

  Map<String, dynamic> toJson() => _$PropertysizeToJson(this);

  @override
  String toString() {
    return "$value $unit";
  }
}



@JsonSerializable()
class Tower {
  Tower({
    required this.towerNumber,
    required this.value,
    required this.id,
  });

  final String? towerNumber;
  final int? value;

  @JsonKey(name: '_id')
  final String? id;

  factory Tower.fromJson(Map<String, dynamic> json) => _$TowerFromJson(json);
}

@JsonSerializable()
class VicinityElement {
  VicinityElement({
    required this.facility,
    required this.distance,
    required this.id,
  });

  final String? facility;
  final String? distance;

  @JsonKey(name: '_id')
  final String? id;

  factory VicinityElement.fromJson(Map<String, dynamic> json) =>
      _$VicinityElementFromJson(json);
}

@JsonSerializable()
class Unit {
  Unit({
    required this.unitName,
    required this.unitSize,
    required this.unitPrice,
    required this.unitFacing,
    required this.id,
  });

  final String? unitName;
  final UnitSize? unitSize;
  final UnitPrice? unitPrice;
  final List<String?>? unitFacing;

  String getUnitSize() {
    StringBuffer sb = StringBuffer();
    final unitType = unitSize?.unitType ?? "";
    if (unitSize?.minSize != null) {
      sb.write("${unitSize?.minSize} $unitType");
    }
    if (unitSize?.maxSize != null) {
      if (sb.length > 0) {
        sb.write(" - ");
      }
      sb.write("${unitSize?.maxSize} $unitType");
    }
    return sb.toString();
  }

  String getUnitPrice() {
    StringBuffer sb = StringBuffer();
    if (unitPrice?.minPrice != null) {
      sb.write(formatPrice(unitPrice?.minPrice ?? 0));
    }
    if (unitPrice?.maxPrice != null) {
      if (sb.length > 0) {
        sb.write(" - ");
      }
      sb.write(formatPrice(unitPrice?.maxPrice ?? 0));
    }

    return sb.toString();
  }

  String getUnitFacing() {
    StringBuffer sb = StringBuffer();
    if(unitFacing!=null){
      sb.write(unitFacing?.join(","));
    }
    return sb.toString();
  }

  @JsonKey(name: '_id')
  final String? id;

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);
}

@JsonSerializable()
class UnitPrice {
  UnitPrice({
    required this.minPrice,
    required this.maxPrice,
  });

  final double? minPrice;
  final double? maxPrice;

  factory UnitPrice.fromJson(Map<String, dynamic> json) =>
      _$UnitPriceFromJson(json);
}

@JsonSerializable()
class UnitSize {
  UnitSize({
    required this.unitType,
    required this.minSize,
    required this.maxSize,
  });

  final String? unitType;
  final int? minSize;
  final int? maxSize;

  factory UnitSize.fromJson(Map<String, dynamic> json) =>
      _$UnitSizeFromJson(json);
}

@JsonSerializable()
class SizeObject {
  SizeObject({
    required this.value,
    required this.unitType,
  });

  final int? value;
  final String? unitType;

  factory SizeObject.fromJson(Map<String, dynamic> json) =>
      _$SizeObjectFromJson(json);
}

@JsonSerializable()
class AddressData {
    AddressData({
        required this.location,
        /* required this.line1,
        required this.line2,
        required this.city,
        required this.state,
        required this.country,
        required this.pincode,
        required this.locality, */
    });

    final List<double>? location;
    /* final String? line1;
    final String? line2;
    final String? city;
    final String? state;
    final String? country;
    final String? pincode;
    final String? locality; */

    factory AddressData.fromJson(Map<String, dynamic> json) => _$AddressDataFromJson(json);

}



//propertySize: {value: 1000, unit: sq.ft},
