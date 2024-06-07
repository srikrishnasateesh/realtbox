import 'package:json_annotation/json_annotation.dart';

part 'token_request_entity.g.dart';

@JsonSerializable()
class TokenRequest  {
  final String phoneNumber;
  final String otp;
  final String? name;
  final String? fcmToken;
  final String? email;
  TokenRequest({required this.phoneNumber, required this.otp, this.name, this.fcmToken, this.email});

  Map<String, dynamic> toJson()  => _$TokenRequestToJson(this);

  factory TokenRequest.fromJson(Map<String, dynamic> json) => _$TokenRequestFromJson(json);
}