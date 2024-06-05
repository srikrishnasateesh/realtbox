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
      propertysize: json['propertysize'] as String,
      projectName: json['projectName'] as String,
      currencyType: json['currencyType'] as String,
      price: (json['price'] as num).toInt(),
      propertyDocs: (json['propertyDocs'] as List<dynamic>)
          .map((e) => PropertyDoc.fromJson(e as Map<String, dynamic>))
          .toList(),
      created: DateTime.parse(json['created'] as String),
      formattedAddress: json['formattedAddress'] as String?,
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
      'propertysize': instance.propertysize,
      'projectName': instance.projectName,
      'currencyType': instance.currencyType,
      'price': instance.price,
      'propertyDocs': instance.propertyDocs,
      'created': instance.created.toIso8601String(),
      'formattedAddress': instance.formattedAddress,
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
