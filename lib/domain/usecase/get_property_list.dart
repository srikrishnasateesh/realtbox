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
    final rangeValues = params?.propertyFilter?.selectedBudget;
    
    String price_min = "0";
    String? price_max;
    if(rangeValues!=null){
      price_min = ((rangeValues.rangeValues?.start ?? 0.0).toInt()).toString();
      price_max = ((rangeValues.rangeValues?.end ?? 0.0).toInt()).toString();
      if(price_max == "0"){
        price_max = null;
      }
    }

    String? sort;
    String? sortDir;
    SortBy? sortBy = params?.propertyFilter?.sortBy;
    if(sortBy!=null){
      if(sortBy.selectedId == "MostViewd-ASC"){
        sort = "mostViewed";
        sortDir = "1";
      } else if(sortBy.selectedId == "MostViewd-DESC"){
        sort = "mostViewed";
        sortDir = "-1";
      }
    }

    return repository.getPropertiesList(
      params?.skip ?? 0,
      params?.category,
      amenitiesIn,
      price_min,
      price_max,
      sort,
      sortDir,
    );
  }
}
