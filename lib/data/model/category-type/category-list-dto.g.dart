// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category-list-dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryList _$CategoryListFromJson(Map<String, dynamic> json) => CategoryList(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );
