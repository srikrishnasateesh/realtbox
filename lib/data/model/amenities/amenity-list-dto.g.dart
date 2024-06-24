// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amenity-list-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmenityList _$AmenityListFromJson(Map<String, dynamic> json) => AmenityList(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AmenityData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

AmenityData _$AmenityDataFromJson(Map<String, dynamic> json) => AmenityData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      createdBy: json['createdBy'] as String?,
    );
