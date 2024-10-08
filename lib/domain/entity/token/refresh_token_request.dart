import 'package:json_annotation/json_annotation.dart';
part 'refresh_token_request.g.dart';

@JsonSerializable()
class RefreshTokenRequest {
  final String refreshToken;

  RefreshTokenRequest({
    required this.refreshToken,
  });

  Map<String, dynamic> toJson()  => _$RefreshTokenRequestToJson(this);

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) => _$RefreshTokenRequestFromJson(json);
}
