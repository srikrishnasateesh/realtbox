// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResponse _$TokenResponseFromJson(Map<String, dynamic> json) =>
    TokenResponse(
      success: json['success'] as bool,
      data: TokenData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenResponseToJson(TokenResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
    };

TokenData _$TokenDataFromJson(Map<String, dynamic> json) => TokenData(
      user: json['user'] as String,
      phoneNumber: json['phoneNumber'] as String,
      enrollmentType: json['enrollmentType'] as String,
      isValid: json['isValid'] as bool,
      id: json['_id'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$TokenDataToJson(TokenData instance) => <String, dynamic>{
      'user': instance.user,
      'phoneNumber': instance.phoneNumber,
      'enrollmentType': instance.enrollmentType,
      'isValid': instance.isValid,
      '_id': instance.id,
      'token': instance.token,
    };
