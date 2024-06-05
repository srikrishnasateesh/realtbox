import 'package:json_annotation/json_annotation.dart';
part 'self.g.dart';

@JsonSerializable()
class Self {
  final String createdBy;
  final String id;
  final String name;
  final String phoneNumber;
  final DateTime created;
  final String enrollmentType;
  final String profileImageUrl;

  Self({
    required this.createdBy,
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.created,
    required this.enrollmentType,
    required this.profileImageUrl,
  });
}
