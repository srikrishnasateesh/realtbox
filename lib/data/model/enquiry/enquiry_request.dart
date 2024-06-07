import 'package:json_annotation/json_annotation.dart';
part 'enquiry_request.g.dart';

@JsonSerializable()
class EnquiryRequest {
  final String phoneNumber;
  final String message;

  EnquiryRequest({
    required this.phoneNumber,
    required this.message,
  });

  factory EnquiryRequest.fromJson(Map<String, dynamic> json) =>
      _$EnquiryRequestFromJson(json);
  Map<String, dynamic> toJson() => _$EnquiryRequestToJson(this);
}
