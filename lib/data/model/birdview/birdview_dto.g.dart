// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'birdview_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BirdViewDto _$BirdViewDtoFromJson(Map<String, dynamic> json) => BirdViewDto(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BirdViewData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

BirdViewData _$BirdViewDataFromJson(Map<String, dynamic> json) => BirdViewData(
      id: json['_id'] as String?,
      address: json['address'] == null
          ? null
          : LatLngAddress.fromJson(json['address'] as Map<String, dynamic>),
      projectName: json['projectName'] as String?,
      minimumPrice: (json['minimumPrice'] as num?)?.toDouble(),
      minimumSize: json['minimumSize'] == null
          ? null
          : MinimumSize.fromJson(json['minimumSize'] as Map<String, dynamic>),
      projectImage: json['projectImage'] == null
          ? null
          : ProjectImage.fromJson(json['projectImage'] as Map<String, dynamic>),
    );

LatLngAddress _$LatLngAddressFromJson(Map<String, dynamic> json) =>
    LatLngAddress(
      location: (json['location'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

MinimumSize _$MinimumSizeFromJson(Map<String, dynamic> json) => MinimumSize(
      value: (json['value'] as num?)?.toInt(),
      unitType: json['unitType'] as String?,
      valueInSqFt: (json['valueInSqFt'] as num?)?.toInt(),
    );

ProjectImage _$ProjectImageFromJson(Map<String, dynamic> json) => ProjectImage(
      objectUrl: json['objectUrl'] as String?,
      document: json['document'] as String?,
      id: json['_id'] as String?,
    );
