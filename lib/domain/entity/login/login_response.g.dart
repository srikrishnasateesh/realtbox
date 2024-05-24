// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    )..error = json['error'] == null
        ? null
        : LoginError.fromJson(json['error'] as Map<String, dynamic>);

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'error': instance.error,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      message: json['message'] as String?,
      isExists: json['isExists'] as bool?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'message': instance.message,
      'isExists': instance.isExists,
    };

LoginError _$LoginErrorFromJson(Map<String, dynamic> json) => LoginError(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LoginErrorToJson(LoginError instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
