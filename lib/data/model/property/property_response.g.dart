// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyResponse _$PropertyResponseFromJson(Map<String, dynamic> json) =>
    PropertyResponse(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => PropertyData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PropertyResponseToJson(PropertyResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

PropertyData _$PropertyDataFromJson(Map<String, dynamic> json) => PropertyData(
      id: json['_id'] as String,
      category: json['category'] as String,
      categoryName: json['categoryName'] as String,
      subcategory: json['subcategory'] as String,
      subcategoryName: json['subcategoryName'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      asset: json['asset'] as String,
      assetName: json['assetName'] as String,
      projectName: json['projectName'] as String,
      currencyType: json['currencyType'] as String,
      price: (json['price'] as num?)?.toDouble(),
      created: DateTime.parse(json['created'] as String),
      formattedAddress: json['formattedAddress'] as String?,
      advanceFeatures: json['advanceFeatures'] == null
          ? null
          : AdvanceFeatures.fromJson(
              json['advanceFeatures'] as Map<String, dynamic>),
      pricePerUnit: (json['pricePerUnit'] as num?)?.toDouble(),
      numberOfTowers: (json['numberOfTowers'] as num?)?.toInt(),
      towers: (json['towers'] as List<dynamic>?)
          ?.map((e) => Tower.fromJson(e as Map<String, dynamic>))
          .toList(),
      vicinity: (json['vicinity'] as List<dynamic>?)
          ?.map((e) => VicinityElement.fromJson(e as Map<String, dynamic>))
          .toList(),
      favProperty: json['favProperty'] as bool?,
      units: (json['units'] as List<dynamic>?)
          ?.map((e) => Unit.fromJson(e as Map<String, dynamic>))
          .toList(),
      minimumPrice: (json['minimumPrice'] as num?)?.toDouble(),
      maximumPrice: (json['maximumPrice'] as num?)?.toDouble(),
      minimumSize: json['minimumSize'] == null
          ? null
          : SizeObject.fromJson(json['minimumSize'] as Map<String, dynamic>),
      maximumSize: json['maximumSize'] == null
          ? null
          : SizeObject.fromJson(json['maximumSize'] as Map<String, dynamic>),
      brochure: (json['brochure'] as List<dynamic>?)
          ?.map((e) => PropertyDoc.fromJson(e as Map<String, dynamic>))
          .toList(),
      floorPlan: (json['floorPlan'] as List<dynamic>?)
          ?.map((e) => PropertyDoc.fromJson(e as Map<String, dynamic>))
          .toList(),
      video:
          (json['video'] as List<dynamic>?)?.map((e) => e as String).toList(),
      galleryPics: (json['galleryPics'] as List<dynamic>?)
          ?.map((e) => PropertyDoc.fromJson(e as Map<String, dynamic>))
          .toList(),
      buildingPlan: (json['buildingPlan'] as List<dynamic>?)
          ?.map((e) => PropertyDoc.fromJson(e as Map<String, dynamic>))
          .toList(),
      headerSectionPhotos: (json['headerSectionPhotos'] as List<dynamic>?)
          ?.map((e) => PropertyDoc.fromJson(e as Map<String, dynamic>))
          .toList(),
      logo: (json['logo'] as List<dynamic>?)
          ?.map((e) => PropertyDoc.fromJson(e as Map<String, dynamic>))
          .toList(),
      address: json['address'] == null
          ? null
          : AddressData.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PropertyDataToJson(PropertyData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'category': instance.category,
      'categoryName': instance.categoryName,
      'subcategory': instance.subcategory,
      'subcategoryName': instance.subcategoryName,
      'description': instance.description,
      'status': instance.status,
      'asset': instance.asset,
      'assetName': instance.assetName,
      'projectName': instance.projectName,
      'currencyType': instance.currencyType,
      'price': instance.price,
      'pricePerUnit': instance.pricePerUnit,
      'created': instance.created.toIso8601String(),
      'formattedAddress': instance.formattedAddress,
      'advanceFeatures': instance.advanceFeatures,
      'address': instance.address,
      'numberOfTowers': instance.numberOfTowers,
      'towers': instance.towers,
      'vicinity': instance.vicinity,
      'favProperty': instance.favProperty,
      'units': instance.units,
      'minimumPrice': instance.minimumPrice,
      'maximumPrice': instance.maximumPrice,
      'minimumSize': instance.minimumSize,
      'maximumSize': instance.maximumSize,
      'brochure': instance.brochure,
      'floorPlan': instance.floorPlan,
      'video': instance.video,
      'galleryPics': instance.galleryPics,
      'buildingPlan': instance.buildingPlan,
      'headerSectionPhotos': instance.headerSectionPhotos,
      'logo': instance.logo,
    };

PropertyDoc _$PropertyDocFromJson(Map<String, dynamic> json) => PropertyDoc(
      objectUrl: json['objectUrl'] as String,
      document: json['document'] as String,
    );

Map<String, dynamic> _$PropertyDocToJson(PropertyDoc instance) =>
    <String, dynamic>{
      'objectUrl': instance.objectUrl,
      'document': instance.document,
    };

AdvanceFeatures _$AdvanceFeaturesFromJson(Map<String, dynamic> json) =>
    AdvanceFeatures(
      maxRooms: (json['maxRooms'] as num?)?.toInt(),
      beds: (json['beds'] as num?)?.toInt(),
      baths: (json['baths'] as num?)?.toInt(),
      amenity: (json['amenity'] as List<dynamic>?)
          ?.map((e) => AmenityData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdvanceFeaturesToJson(AdvanceFeatures instance) =>
    <String, dynamic>{
      'maxRooms': instance.maxRooms,
      'beds': instance.beds,
      'baths': instance.baths,
      'amenity': instance.amenity,
    };

Propertysize _$PropertysizeFromJson(Map<String, dynamic> json) => Propertysize(
      value: (json['value'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
    );

Map<String, dynamic> _$PropertysizeToJson(Propertysize instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unit': instance.unit,
    };

Tower _$TowerFromJson(Map<String, dynamic> json) => Tower(
      towerNumber: json['towerNumber'] as String?,
      value: (json['value'] as num?)?.toInt(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$TowerToJson(Tower instance) => <String, dynamic>{
      'towerNumber': instance.towerNumber,
      'value': instance.value,
      '_id': instance.id,
    };

VicinityElement _$VicinityElementFromJson(Map<String, dynamic> json) =>
    VicinityElement(
      facility: json['facility'] as String?,
      distance: json['distance'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$VicinityElementToJson(VicinityElement instance) =>
    <String, dynamic>{
      'facility': instance.facility,
      'distance': instance.distance,
      '_id': instance.id,
    };

Unit _$UnitFromJson(Map<String, dynamic> json) => Unit(
      unitName: json['unitName'] as String?,
      unitSize: json['unitSize'] == null
          ? null
          : UnitSize.fromJson(json['unitSize'] as Map<String, dynamic>),
      unitPrice: json['unitPrice'] == null
          ? null
          : UnitPrice.fromJson(json['unitPrice'] as Map<String, dynamic>),
      unitFacing: (json['unitFacing'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$UnitToJson(Unit instance) => <String, dynamic>{
      'unitName': instance.unitName,
      'unitSize': instance.unitSize,
      'unitPrice': instance.unitPrice,
      'unitFacing': instance.unitFacing,
      '_id': instance.id,
    };

UnitPrice _$UnitPriceFromJson(Map<String, dynamic> json) => UnitPrice(
      minPrice: (json['minPrice'] as num?)?.toDouble(),
      maxPrice: (json['maxPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UnitPriceToJson(UnitPrice instance) => <String, dynamic>{
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
    };

UnitSize _$UnitSizeFromJson(Map<String, dynamic> json) => UnitSize(
      unitType: json['unitType'] as String?,
      minSize: (json['minSize'] as num?)?.toInt(),
      maxSize: (json['maxSize'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UnitSizeToJson(UnitSize instance) => <String, dynamic>{
      'unitType': instance.unitType,
      'minSize': instance.minSize,
      'maxSize': instance.maxSize,
    };

SizeObject _$SizeObjectFromJson(Map<String, dynamic> json) => SizeObject(
      value: (json['value'] as num?)?.toInt(),
      unitType: json['unitType'] as String?,
    );

Map<String, dynamic> _$SizeObjectToJson(SizeObject instance) =>
    <String, dynamic>{
      'value': instance.value,
      'unitType': instance.unitType,
    };

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
      location: (json['location'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'location': instance.location,
    };
