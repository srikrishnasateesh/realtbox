// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenRequest _$TokenRequestFromJson(Map<String, dynamic> json) => TokenRequest(
      json['phoneNumber'] as String,
      json['otp'] as String,
      json['name'] as String?,
    );

Map<String, dynamic> _$TokenRequestToJson(TokenRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'otp': instance.otp,
      'name': instance.name,
    };
