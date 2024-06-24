import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/domain/entity/amenity.dart';
import 'package:realtbox/presentation/property-filter/property-filter-entity.dart';

part 'property_filetr_event.dart';
part 'property_filetr_state.dart';

class PropertyFilterBloc
    extends Bloc<PropertyFilterEvent, PropertyFilterState> {
  late PropertyFilter propsFilter;
  PropertyFilterBloc() : super(PropertyFiletrInitial()) {
    on<PropertyFilterEvent>((event, emit) {
      switch (event) {
        case OnFilterInit():
          propsFilter = event.propertyFilter;
          emit(LoadFilters(propertyFilter: propsFilter));
          break;
        case OnAmenitiesReceived():
          propsFilter.selectedAmenities = event.amenities;
          break;
        case OnBudgetChanged():
          /* propsFilter.selectedBudget = Budget(rangeValues: event.rangeValues);
          emit(PropertyFiletrInitial());
          emit(LoadFilters(propertyFilter: propsFilter)); */
          if(state is LoadFilters){
          final curState = (state as LoadFilters);
          PropertyFilter filter = (curState.propertyFilter);
          filter.selectedBudget = Budget(rangeValues: event.rangeValues);
           emit(PropertyFiletrInitial());
           emit(LoadFilters(propertyFilter: filter));
        }
          break;
        case OnFilterClearClicked():
          propsFilter.selectedAmenities = [];
          propsFilter.selectedBudget =
              Budget(rangeValues: const RangeValues(0, 0));
          propsFilter.selectedLocation = null;
          propsFilter.sortBy = SortBy(selectedId: "");

          emit(PropertyFiletrInitial());

          emit(LoadFilters(propertyFilter: propsFilter));
          break;
        case OnSortTypeSelected():
        if(state is LoadFilters){
          final curState = (state as LoadFilters);
          PropertyFilter filter = (curState.propertyFilter);
          filter.sortBy = SortBy(selectedId: event.selectedId);
           emit(PropertyFiletrInitial());
           emit(LoadFilters(propertyFilter: filter));
        }
          break;
      }
    });
  }
}
