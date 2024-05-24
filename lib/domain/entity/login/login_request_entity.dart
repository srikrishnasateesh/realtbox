import 'package:json_annotation/json_annotation.dart';

part 'login_request_entity.g.dart';

@JsonSerializable()
class LoginRequest  {
  late String phoneNumber;
  LoginRequest(this.phoneNumber);

  Map<String, dynamic> toJson()  => _$LoginRequestToJson(this);

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
}
