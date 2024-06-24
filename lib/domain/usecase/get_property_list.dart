import 'dart:ffi';

import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';
import 'package:realtbox/presentation/property-filter/property-filter-entity.dart';

class PropertyRequest {
  final String? category;
  final PropertyFilter? propertyFilter;
  final int skip;

  PropertyRequest({required this.category, required this.skip,this.propertyFilter,});
}

class GetPropertyList
    extends UseCase<DataState<List<Property>>, PropertyRequest> {
  final PropertyRepository repository;

  GetPropertyList({required this.repository});
  @override
  Future<DataState<List<Property>>> call({PropertyRequest? params}) {
    final amenitiesIn = params?.propertyFilter?.selectedAmenities.map((e)=>e.name).join(",");
    return repository.getPropertiesList(
      params?.skip ?? 0,
      params?.category,
      amenitiesIn,
    );
  }
}
