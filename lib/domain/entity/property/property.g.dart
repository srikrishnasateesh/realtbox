// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      propertyId: json['propertyId'] as String,
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      subCategoryId: json['subCategoryId'] as String,
      subCategoryName: json['subCategoryName'] as String,
      description: json['description'] as String,
      assetId: json['assetId'] as String,
      assetName: json['assetName'] as String,
      propertySize: json['propertySize'] as String,
      projectName: json['projectName'] as String,
      price: json['price'] as String,
      location: json['location'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'propertyId': instance.propertyId,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'subCategoryId': instance.subCategoryId,
      'subCategoryName': instance.subCategoryName,
      'description': instance.description,
      'assetId': instance.assetId,
      'assetName': instance.assetName,
      'propertySize': instance.propertySize,
      'projectName': instance.projectName,
      'price': instance.price,
      'location': instance.location,
      'images': instance.images,
    };
