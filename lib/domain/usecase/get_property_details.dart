import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';

class GetPropertyDetails extends UseCase<DataState<Property>, String?> {
  final PropertyRepository repository;

  GetPropertyDetails({required this.repository});
  @override
  Future<DataState<Property>> call({String? params}) {
    return repository.getPropertiesDetails(params!);
  }
}
