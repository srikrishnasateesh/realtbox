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
      location: json['location'] as String?,
      propertySize:
          Propertysize.fromJson(json['propertySize'] as Map<String, dynamic>),
      projectName: json['projectName'] as String,
      currencyType: json['currencyType'] as String,
      price: (json['price'] as num).toDouble(),
      propertyDocs: (json['propertyDocs'] as List<dynamic>)
          .map((e) => PropertyDoc.fromJson(e as Map<String, dynamic>))
          .toList(),
      created: DateTime.parse(json['created'] as String),
      formattedAddress: json['formattedAddress'] as String?,
      advanceFeatures: json['advanceFeatures'] == null
          ? null
          : AdvanceFeatures.fromJson(
              json['advanceFeatures'] as Map<String, dynamic>),
      pricePerUnit: (json['pricePerUnit'] as num).toDouble(),
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
      'location': instance.location,
      'propertySize': instance.propertySize,
      'projectName': instance.projectName,
      'currencyType': instance.currencyType,
      'price': instance.price,
      'pricePerUnit': instance.pricePerUnit,
      'propertyDocs': instance.propertyDocs,
      'created': instance.created.toIso8601String(),
      'formattedAddress': instance.formattedAddress,
      'advanceFeatures': instance.advanceFeatures,
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
      amenity:
          (json['amenity'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
