// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enquiry_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnquiryRequest _$EnquiryRequestFromJson(Map<String, dynamic> json) =>
    EnquiryRequest(
      phoneNumber: json['phoneNumber'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$EnquiryRequestToJson(EnquiryRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'message': instance.message,
    };
