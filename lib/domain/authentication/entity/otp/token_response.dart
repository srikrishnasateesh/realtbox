import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse {
  final bool success;
  final TokenData data;

  TokenResponse({
    required this.success,
    required this.data,
  });

   Map<String, dynamic> toJson()  => _$TokenResponseToJson(this);

   factory TokenResponse.fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);
}

@JsonSerializable()
class TokenData {
  final String user;
  final String phoneNumber;
  final String enrollmentType;
  final bool isValid;
  final String id;
  final String token;

  TokenData({
    required this.user,
    required this.phoneNumber,
    required this.enrollmentType,
    required this.isValid,
    required this.id,
    required this.token,
  });

  Map<String, dynamic> toJson()  => _$TokenDataToJson(this);

   factory TokenData.fromJson(Map<String, dynamic> json) => _$TokenDataFromJson(json);
}
