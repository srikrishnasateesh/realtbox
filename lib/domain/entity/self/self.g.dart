// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Self _$SelfFromJson(Map<String, dynamic> json) => Self(
      createdBy: json['createdBy'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      created: DateTime.parse(json['created'] as String),
      enrollmentType: json['enrollmentType'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
    );

Map<String, dynamic> _$SelfToJson(Self instance) => <String, dynamic>{
      'createdBy': instance.createdBy,
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'created': instance.created.toIso8601String(),
      'enrollmentType': instance.enrollmentType,
      'profileImageUrl': instance.profileImageUrl,
    };
