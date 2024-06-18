import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/enquiry_list/enquiry_data_model.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';

class GetEnquiryList extends UseCase<DataState<List<EnquiryDataModel>>, String> {
   final PropertyRepository repository;

  GetEnquiryList({required this.repository});
  @override
  Future<DataState<List<EnquiryDataModel>>> call({String? params}) {
    return repository.enquiryList(params??"");
  }
  

}