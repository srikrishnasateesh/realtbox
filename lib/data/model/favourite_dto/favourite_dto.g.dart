// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteDto _$FavouriteDtoFromJson(Map<String, dynamic> json) => FavouriteDto(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : FavouriteData.fromJson(json['data'] as Map<String, dynamic>),
    );

FavouriteData _$FavouriteDataFromJson(Map<String, dynamic> json) =>
    FavouriteData(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      propertyId: json['propertyId'] as String?,
      status: json['status'] as String?,
    );
