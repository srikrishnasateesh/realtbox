import 'package:json_annotation/json_annotation.dart';
part 'version-request.g.dart';

@JsonSerializable()
class VersionRequest {
  late String packageName;
  late int versionCode;
  late String versionName;
  late String fcmToken;

  VersionRequest(
    this.packageName,
    this.versionCode,
    this.versionName,
    this.fcmToken,
  );

  Map<String, dynamic> toJson() => _$VersionRequestToJson(this);

  factory VersionRequest.fromJson(Map<String, dynamic> json) =>
      _$VersionRequestFromJson(json);
}
