import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/data/model/enquiry/enquiry_request.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';

class EnquiryRequestObject {
  final EnquiryRequest enquiryRequest;
  final String propertyId;

  EnquiryRequestObject({required this.enquiryRequest, required this.propertyId});
}

class SubmitEnquiry extends UseCase<DataState, EnquiryRequestObject> {
  final PropertyRepository repository;
  SubmitEnquiry({required this.repository});
  @override
  Future<DataState> call({EnquiryRequestObject? params}) {
    return repository.enquiry(params!);
  }
}