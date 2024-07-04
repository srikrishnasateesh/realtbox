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
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$TokenDataToJson(TokenData instance) => <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };
