// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enquiry_list_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnquiryList _$EnquiryListFromJson(Map<String, dynamic> json) => EnquiryList(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => EnquiryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

EnquiryData _$EnquiryDataFromJson(Map<String, dynamic> json) => EnquiryData(
      id: json['_id'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      message: json['message'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      propertyId: json['propertyId'] as String?,
      created: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      createdBy: json['createdBy'] as String?,
    );

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      profileUrl: json['profileUrl'] == null
          ? null
          : ProfileUrl.fromJson(json['profileUrl'] as Map<String, dynamic>),
    );

ProfileUrl _$ProfileUrlFromJson(Map<String, dynamic> json) => ProfileUrl(
      document: json['document'] as String?,
      objectUrl: json['objectUrl'] as String?,
    );
