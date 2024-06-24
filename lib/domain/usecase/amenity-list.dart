import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/amenity.dart';
import 'package:realtbox/domain/entity/category-type/category.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';

class GetAmenityList extends UseCase<DataState<List<Amenity>>,String> {
  final PropertyRepository repository;

  GetAmenityList({required this.repository});
  @override
  Future<DataState<List<Amenity>>> call({String? params}) {
    return repository.amenityList();
  }

}