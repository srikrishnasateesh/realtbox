// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyDetailsDto _$PropertyDetailsDtoFromJson(Map<String, dynamic> json) =>
    PropertyDetailsDto(
      success: json['success'] as bool,
      data: PropertyData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PropertyDetailsDtoToJson(PropertyDetailsDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };
