import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/core/resources/data_state.dart';

abstract class PropertyRepository {
  Future<DataState<List<Property>>> getPropertiesList();
}