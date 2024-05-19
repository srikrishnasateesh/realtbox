import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  bool? success;
  Data? data;
  LoginError? error;

  LoginResponse({this.success, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class Data {
  String? message;
  bool? isExists;

  Data({this.message, this.isExists});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class LoginError {
  String? message;
  LoginError({this.message});

  factory LoginError.fromJson(Map<String,dynamic> json) => _$LoginErrorFromJson(json);

  Map<String,dynamic> toJson() => _$LoginErrorToJson(this);

}
