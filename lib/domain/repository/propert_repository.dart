import 'package:realtbox/data/model/enquiry/enquiry_request.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';

abstract class PropertyRepository {
  Future<DataState<List<Property>>> getPropertiesList(int skip);
  Future<DataState> enquiry(EnquiryRequestObject enquiryRequest);
}
