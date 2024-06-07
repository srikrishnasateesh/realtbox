import 'dart:ffi';

import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';

class GetPropertyList extends UseCase<DataState<List<Property>>, int> {
  final PropertyRepository repository;

  GetPropertyList({required this.repository});
  @override
  Future<DataState<List<Property>>> call({int? params}) {
    return repository.getPropertiesList(params ?? 0);
  }
}
