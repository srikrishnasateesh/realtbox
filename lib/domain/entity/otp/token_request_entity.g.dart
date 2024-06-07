// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRequest _$TokenRequestFromJson(Map<String, dynamic> json) => TokenRequest(
      phoneNumber: json['phoneNumber'] as String,
      otp: json['otp'] as String,
      name: json['name'] as String?,
      fcmToken: json['fcmToken'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$TokenRequestToJson(TokenRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'otp': instance.otp,
      'name': instance.name,
      'fcmToken': instance.fcmToken,
      'email': instance.email,
    };
