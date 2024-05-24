import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';

class GetPropertyList extends UseCase<DataState<List<Property>>, String> {
  final PropertyRepository repository;

  GetPropertyList({required this.repository});
  @override
  Future<DataState<List<Property>>> call({String? params}) {
    return repository.getPropertiesList();
  }
}
