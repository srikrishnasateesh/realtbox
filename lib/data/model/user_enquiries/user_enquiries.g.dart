// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_enquiries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEnquiries _$UserEnquiriesFromJson(Map<String, dynamic> json) =>
    UserEnquiries(
      success: json['success'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UserEnquiryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

UserEnquiryData _$UserEnquiryDataFromJson(Map<String, dynamic> json) =>
    UserEnquiryData(
      id: json['_id'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      message: json['message'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      propertyId: json['propertyId'] == null
          ? null
          : PropertyId.fromJson(json['propertyId'] as Map<String, dynamic>),
      created: json['created'] as String?,
      createdBy: json['createdBy'] as String?,
      v: (json['__v'] as num?)?.toInt(),
    );

PropertyId _$PropertyIdFromJson(Map<String, dynamic> json) => PropertyId(
      id: json['_id'] as String?,
      projectName: json['projectName'] as String?,
      propertyDocs: (json['propertyDocs'] as List<dynamic>?)
          ?.map((e) => PropertyDoc.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

PropertyDoc _$PropertyDocFromJson(Map<String, dynamic> json) => PropertyDoc(
      objectUrl: json['objectUrl'] as String?,
      document: json['document'] as String?,
      id: json['_id'] as String?,
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
