import 'package:json_annotation/json_annotation.dart';

part 'token_request_entity.g.dart';

@JsonSerializable()
class TokenRequest  {
  final String phoneNumber;
  final String otp;
  final String? name;
  TokenRequest(this.phoneNumber, this.otp, this.name);

  Map<String, dynamic> toJson()  => _$TokenRequestToJson(this);

  factory TokenRequest.fromJson(Map<String, dynamic> json) => _$TokenRequestFromJson(json);
}