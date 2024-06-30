// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionDto _$VersionDtoFromJson(Map<String, dynamic> json) => VersionDto(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : VersionData.fromJson(json['data'] as Map<String, dynamic>),
    );

VersionData _$VersionDataFromJson(Map<String, dynamic> json) => VersionData(
      forceUpgrade: json['forceUpgrade'] as bool?,
      recommendUpgrade: json['recommendUpgrade'] as bool?,
    );
