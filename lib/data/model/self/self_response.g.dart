// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelfResponse _$SelfResponseFromJson(Map<String, dynamic> json) => SelfResponse(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : SelfData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SelfResponseToJson(SelfResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

SelfData _$SelfDataFromJson(Map<String, dynamic> json) => SelfData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      enrollmentType: json['enrollmentType'] as String?,
      createdBy: json['createdBy'] as String?,
      profileUrl: json['profileUrl'] == null
          ? null
          : ProfileUrl.fromJson(json['profileUrl'] as Map<String, dynamic>),
      email: json['email'] as String?,
    );

Map<String, dynamic> _$SelfDataToJson(SelfData instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'created': instance.created?.toIso8601String(),
      'enrollmentType': instance.enrollmentType,
      'createdBy': instance.createdBy,
      'profileUrl': instance.profileUrl,
      'email': instance.email,
    };

ProfileUrl _$ProfileUrlFromJson(Map<String, dynamic> json) => ProfileUrl(
      document: json['document'] as String?,
      objectUrl: json['objectUrl'] as String?,
    );

Map<String, dynamic> _$ProfileUrlToJson(ProfileUrl instance) =>
    <String, dynamic>{
      'document': instance.document,
      'objectUrl': instance.objectUrl,
    };
