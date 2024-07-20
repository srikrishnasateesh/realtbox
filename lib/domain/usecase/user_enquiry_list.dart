import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/user_enquiry.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';

class GetUserEnquiryList extends UseCase<DataState<List<UserEnquiry>>, String> {
   final PropertyRepository repository;

  GetUserEnquiryList({required this.repository});
  @override
  Future<DataState<List<UserEnquiry>>> call({String? params}) {
    return repository.userEnquiryList();
  }
  

}