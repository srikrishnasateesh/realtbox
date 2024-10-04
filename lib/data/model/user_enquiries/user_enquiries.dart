import 'package:json_annotation/json_annotation.dart';

part 'user_enquiries.g.dart';

@JsonSerializable(createToJson: false)
class UserEnquiries {
    UserEnquiries({
        required this.success,
        required this.data,
    });

    final bool? success;
    final List<UserEnquiryData>? data;

    factory UserEnquiries.fromJson(Map<String, dynamic> json) => _$UserEnquiriesFromJson(json);

}

@JsonSerializable(createToJson: false)
class UserEnquiryData {
    UserEnquiryData({
        required this.id,
        required this.user,
        required this.message,
        required this.phoneNumber,
        required this.propertyId,
        required this.created,
        required this.createdBy,
        required this.v,
    });

    @JsonKey(name: '_id') 
    final String? id;
    final User? user;
    final String? message;
    final String? phoneNumber;
    final PropertyId? propertyId;
    final String? created;
    final String? createdBy;

    @JsonKey(name: '__v') 
    final int? v;

    factory UserEnquiryData.fromJson(Map<String, dynamic> json) => _$UserEnquiryDataFromJson(json);

}

@JsonSerializable(createToJson: false)
class PropertyId {
    PropertyId({
        required this.id,
        required this.projectName,
        required this.propertyDocs,
    });

    @JsonKey(name: '_id') 
    final String? id;
    final String? projectName;
    final List<PropertyDoc>? propertyDocs;

    factory PropertyId.fromJson(Map<String, dynamic> json) => _$PropertyIdFromJson(json);

}

@JsonSerializable(createToJson: false)
class PropertyDoc {
    PropertyDoc({
        required this.objectUrl,
        required this.document,
        required this.id,
    });

    final String? objectUrl;
    final String? document;

    @JsonKey(name: '_id') 
    final String? id;

    factory PropertyDoc.fromJson(Map<String, dynamic> json) => _$PropertyDocFromJson(json);

}

@JsonSerializable(createToJson: false)
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
