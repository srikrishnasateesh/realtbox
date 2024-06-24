import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realtbox/domain/entity/amenity.dart';
import 'package:realtbox/presentation/property-filter/property-filter-entity.dart';

part 'property_filetr_event.dart';
part 'property_filetr_state.dart';

class PropertyFilterBloc extends Bloc<PropertyFilterEvent, PropertyFilterState> {
  late PropertyFilter propsFilter;
  PropertyFilterBloc() : super(PropertyFiletrInitial()) {
    on<PropertyFilterEvent>((event, emit) {
      switch(event){
        case OnFilterInit():
        propsFilter = event.propertyFilter;
          emit(LoadFilters(propertyFilter: propsFilter));
          break;
        case OnFilterClearClicked():
        propsFilter.selectedAmenities = [];
        emit(PropertyFiletrInitial());
        emit(LoadFilters(propertyFilter: propsFilter));
        break;
        case OnAmenitiesReceived():
         propsFilter.selectedAmenities = event.amenities;
         break;
      }
    });
  }
}
