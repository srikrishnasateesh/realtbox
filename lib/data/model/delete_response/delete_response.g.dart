// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteResponse _$DeleteResponseFromJson(Map<String, dynamic> json) =>
    DeleteResponse(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      message: json['message'] as String?,
    );
