import 'package:json_annotation/json_annotation.dart';

part 'self_response.g.dart';

@JsonSerializable()
class SelfResponse {
  SelfResponse({
    required this.success,
    required this.data,
  });

  final bool? success;
  final SelfData? data;

  factory SelfResponse.fromJson(Map<String, dynamic> json) =>
      _$SelfResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SelfResponseToJson(this);
}

@JsonSerializable()
class SelfData {
  SelfData({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.created,
    required this.enrollmentType,
    required this.createdBy,
    required this.profileUrl,
  });

  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? phoneNumber;
  final DateTime? created;
  final String? enrollmentType;
  final String? createdBy;
  final ProfileUrl? profileUrl;

  factory SelfData.fromJson(Map<String, dynamic> json) =>
      _$SelfDataFromJson(json);

  Map<String, dynamic> toJson() => _$SelfDataToJson(this);
}

@JsonSerializable()
class ProfileUrl {
  ProfileUrl({
    required this.document,
    required this.objectUrl,
  });

  final String? document;
  final String? objectUrl;

  factory ProfileUrl.fromJson(Map<String, dynamic> json) =>
      _$ProfileUrlFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileUrlToJson(this);
}
