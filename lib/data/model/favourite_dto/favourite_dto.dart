import 'package:json_annotation/json_annotation.dart';

part 'favourite_dto.g.dart';

@JsonSerializable(createToJson: false)
class FavouriteDto {
    FavouriteDto({
        required this.success,
        required this.data,
    });

    final bool success;
    final FavouriteData? data;

    factory FavouriteDto.fromJson(Map<String, dynamic> json) => _$FavouriteDtoFromJson(json);

}

@JsonSerializable(createToJson: false)
class FavouriteData {
    FavouriteData({
        required this.id,
        required this.userId,
        required this.propertyId,
        required this.status,
    });

    @JsonKey(name: '_id') 
    final String? id;
    final String? userId;
    final String? propertyId;
    final String? status;

    factory FavouriteData.fromJson(Map<String, dynamic> json) => _$FavouriteDataFromJson(json);

}
