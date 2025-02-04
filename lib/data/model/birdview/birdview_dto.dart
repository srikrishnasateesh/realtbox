import 'package:json_annotation/json_annotation.dart';

part 'birdview_dto.g.dart';

@JsonSerializable(createToJson: false)
class BirdViewDto {
    BirdViewDto({
        required this.success,
        required this.data,
    });

    final bool? success;
    final List<BirdViewData>? data;

    factory BirdViewDto.fromJson(Map<String, dynamic> json) => _$BirdViewDtoFromJson(json);

}

@JsonSerializable(createToJson: false)
class BirdViewData {
    BirdViewData({
        required this.id,
        required this.address,
        required this.projectName,
        required this.totalPrice,
        required this.minimumPrice,
        required this.minimumSize,
        required this.projectImage,
    });

    @JsonKey(name: '_id') 
    final String? id;
    final LatLngAddress? address;
    final String? projectName;
    final String? totalPrice;
    final double? minimumPrice;
    final MinimumSize? minimumSize;
    final ProjectImage? projectImage;

    factory BirdViewData.fromJson(Map<String, dynamic> json) => _$BirdViewDataFromJson(json);

}

@JsonSerializable(createToJson: false)
class LatLngAddress {
    LatLngAddress({
        required this.location,
    });

    final List<double>? location;

    factory LatLngAddress.fromJson(Map<String, dynamic> json) => _$LatLngAddressFromJson(json);

}

@JsonSerializable(createToJson: false)
class MinimumSize {
    MinimumSize({
        required this.value,
        required this.unitType,
        required this.valueInSqFt,
    });

    final int? value;
    final String? unitType;
    final int? valueInSqFt;

    factory MinimumSize.fromJson(Map<String, dynamic> json) => _$MinimumSizeFromJson(json);

}

@JsonSerializable(createToJson: false)
class ProjectImage {
    ProjectImage({
        required this.objectUrl,
        required this.document,
        required this.id,
    });

    final String? objectUrl;
    final String? document;

    @JsonKey(name: '_id') 
    final String? id;

    factory ProjectImage.fromJson(Map<String, dynamic> json) => _$ProjectImageFromJson(json);

}
