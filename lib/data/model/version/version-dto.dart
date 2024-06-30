import 'package:json_annotation/json_annotation.dart';

part 'version-dto.g.dart';

@JsonSerializable(createToJson: false)
class VersionDto {
    VersionDto({
        required this.success,
        required this.data,
    });

    final bool? success;
    final VersionData? data;

    factory VersionDto.fromJson(Map<String, dynamic> json) => _$VersionDtoFromJson(json);

}

@JsonSerializable(createToJson: false)
class VersionData {
    VersionData({
        required this.forceUpgrade,
        required this.recommendUpgrade,
    });

    final bool? forceUpgrade;
    final bool? recommendUpgrade;

    factory VersionData.fromJson(Map<String, dynamic> json) => _$VersionDataFromJson(json);

}
