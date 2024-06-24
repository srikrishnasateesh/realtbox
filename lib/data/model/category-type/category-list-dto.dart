import 'package:json_annotation/json_annotation.dart';

part 'category-list-dto.g.dart';

@JsonSerializable(createToJson: false)
class CategoryList {
    CategoryList({
        required this.success,
        required this.data,
    });

    final bool? success;
    final List<CategoryData>? data;

    factory CategoryList.fromJson(Map<String, dynamic> json) => _$CategoryListFromJson(json);

}

@JsonSerializable(createToJson: false)
class CategoryData {
    CategoryData({
        required this.id,
        required this.name,
    });

    @JsonKey(name: '_id') 
    final String? id;
    final String? name;
    /* final String? status;
    final CategoryDoc? categoryDoc;
    final DateTime? created;
    final String? createdBy;

    @JsonKey(name: '__v') 
    final int? v;
    final DateTime? modified;
    final String? modifiedBy; */

    factory CategoryData.fromJson(Map<String, dynamic> json) => _$CategoryDataFromJson(json);

}

/* @JsonSerializable(createToJson: false)
class CategoryDoc {
    CategoryDoc({
        required this.objectUrl,
        required this.document,
    });

    final String? objectUrl;
    final String? document;

    factory CategoryDoc.fromJson(Map<String, dynamic> json) => _$CategoryDocFromJson(json);

} */
