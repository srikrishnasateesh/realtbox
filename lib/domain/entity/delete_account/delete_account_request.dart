import 'package:json_annotation/json_annotation.dart';
part 'delete_account_request.g.dart';

@JsonSerializable()
class DeleteAccountRequest{
  final String reason;

  DeleteAccountRequest({required this.reason});
   Map<String, dynamic> toJson()  => _$DeleteAccountRequestToJson(this);

  factory DeleteAccountRequest.fromJson(Map<String, dynamic> json) => _$DeleteAccountRequestFromJson(json);
}