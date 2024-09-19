import 'package:json_annotation/json_annotation.dart';

part 'amenity-list-dto.g.dart';

@JsonSerializable(createToJson: false)
class AmenityList {
    AmenityList({
        required this.success,
        required this.data,
    });

    final bool? success;
    final List<AmenityData>? data;

    factory AmenityList.fromJson(Map<String, dynamic> json) => _$AmenityListFromJson(json);

}

@JsonSerializable()
class AmenityData {
    AmenityData({
        required this.id,
        required this.name,
        required this.icon,
        required this.created,
        required this.createdBy,
    });

    @JsonKey(name: '_id') 
    final String? id;
    final String? name;
    final String? icon;
    final DateTime? created;
    final String? createdBy;

    

    factory AmenityData.fromJson(Map<String, dynamic> json) => _$AmenityDataFromJson(json);

}