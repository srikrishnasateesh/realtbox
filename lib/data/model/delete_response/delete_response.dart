import 'package:json_annotation/json_annotation.dart';

part 'delete_response.g.dart';

@JsonSerializable(createToJson: false)
class DeleteResponse {
    DeleteResponse({
        required this.success,
        required this.data,
    });

    final bool? success;
    final Data? data;

    factory DeleteResponse.fromJson(Map<String, dynamic> json) => _$DeleteResponseFromJson(json);

}

@JsonSerializable(createToJson: false)
class Data {
    Data({
        required this.message,
    });

    final String? message;

    factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

}
