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
      icon: json['icon'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$AmenityDataToJson(AmenityData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'created': instance.created?.toIso8601String(),
      'createdBy': instance.createdBy,
    };
