import 'package:json_annotation/json_annotation.dart';

part 'enquiry_list_dto.g.dart';

@JsonSerializable(createToJson: false,includeIfNull: true)
class EnquiryList {
    EnquiryList({
        required this.success,
        required this.data,
    });

    final bool? success;
    final List<EnquiryData>? data;

    factory EnquiryList.fromJson(Map<String, dynamic> json) => _$EnquiryListFromJson(json);

}

@JsonSerializable(createToJson: false,includeIfNull: true)
class EnquiryData {
    EnquiryData({
        required this.id,
        required this.user,
        required this.message,
        required this.phoneNumber,
        required this.propertyId,
        required this.created,
        required this.createdBy,
    });

    @JsonKey(name: '_id') 
    final String? id;
    final User? user;
    final String? message;
    final String? phoneNumber;
    final String? propertyId;
    final DateTime? created;
    final String? createdBy;


    factory EnquiryData.fromJson(Map<String, dynamic> json) => _$EnquiryDataFromJson(json);

}

@JsonSerializable(createToJson: false,includeIfNull: true)
class User {
    User({
        required this.id,
        required this.name,
        required this.profileUrl,
    });

    @JsonKey(name: '_id') 
    final String? id;
    final String? name;
    final ProfileUrl? profileUrl;

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

}

@JsonSerializable(createToJson: false,includeIfNull: true)
class ProfileUrl {
    ProfileUrl({
        required this.document,
        required this.objectUrl,
    });

    final String? document;
    final String? objectUrl;

    factory ProfileUrl.fromJson(Map<String, dynamic> json) => _$ProfileUrlFromJson(json);

}
