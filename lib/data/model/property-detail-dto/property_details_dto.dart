import 'package:json_annotation/json_annotation.dart';
import 'package:realtbox/data/model/property/property_response.dart';
part 'property_details_dto.g.dart';

@JsonSerializable()
class PropertyDetailsDto {
  final bool success;
  final PropertyData data;

  PropertyDetailsDto({
    required this.success,
    required this.data,
  });

  factory PropertyDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$PropertyDetailsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyDetailsDtoToJson(this);
}