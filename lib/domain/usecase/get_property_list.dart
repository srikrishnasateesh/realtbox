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

  PropertyRequest({
    required this.category,
    required this.skip,
    this.propertyFilter,
  });
}

class GetPropertyList
    extends UseCase<DataState<List<Property>>, PropertyRequest> {
  final PropertyRepository repository;

  GetPropertyList({required this.repository});
  @override
  Future<DataState<List<Property>>> call({PropertyRequest? params}) {
    String? amenitiesIn =
        params?.propertyFilter?.selectedAmenities.map((e) => e.id).join(",") ?? "";
    final rangeValues = params?.propertyFilter?.selectedBudget;
    if(amenitiesIn.isEmpty){
      amenitiesIn = null;
    }
    //price
    String? priceMin;
    String? priceMax;
    if (rangeValues != null) {
      priceMin = ((rangeValues.rangeValues.start).toInt()).toString();
      priceMax = ((rangeValues.rangeValues.end).toInt()).toString();
      if (priceMax == "0") {
        priceMax = null;
      }
      if (priceMin == "0") {
        priceMin = null;
      }
    }

    //sort
    String? sort;
    String? sortDir;
    SortBy? sortBy = params?.propertyFilter?.sortBy;
    if (sortBy != null) {
      if (sortBy.selectedId == "MostViewd-ASC") {
        sort = "mostViewed";
        sortDir = "1";
      } else if (sortBy.selectedId == "MostViewd-DESC") {
        sort = "mostViewed";
        sortDir = "-1";
      }
    }

    //location
    PlaceDetail? place = params?.propertyFilter?.selectedLocation;
    double? lat;
    double? lng;
    if (place != null) {
      if(place.lattitude!=0.0 && place.longitude!=0.0){
        lat = place.lattitude;
        lng = place.longitude;
      }
    }

    return repository.getPropertiesList(
      params?.skip ?? 0,
      params?.category,
      amenitiesIn,
      priceMin,
      priceMax,
      sort,
      sortDir,
      lat,
      lng,
    );
  }
}
