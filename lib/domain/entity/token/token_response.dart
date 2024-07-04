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
  final String token;
  final String refreshToken;

  TokenData({
    required this.token,
    required this.refreshToken,
  });

  Map<String, dynamic> toJson()  => _$TokenDataToJson(this);

   factory TokenData.fromJson(Map<String, dynamic> json) => _$TokenDataFromJson(json);
}
