// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version-request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionRequest _$VersionRequestFromJson(Map<String, dynamic> json) =>
    VersionRequest(
      json['packageName'] as String,
      (json['versionCode'] as num).toInt(),
      json['versionName'] as String,
      json['fcmToken'] as String,
    );

Map<String, dynamic> _$VersionRequestToJson(VersionRequest instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'versionCode': instance.versionCode,
      'versionName': instance.versionName,
      'fcmToken': instance.fcmToken,
    };
