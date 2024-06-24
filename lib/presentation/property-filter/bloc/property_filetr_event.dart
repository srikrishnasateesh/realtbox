part of 'property_filetr_bloc.dart';

sealed class PropertyFilterEvent extends Equatable {
  const PropertyFilterEvent();

  @override
  List<Object> get props => [];
}

class OnFilterInit extends PropertyFilterEvent {
  final PropertyFilter propertyFilter;

  OnFilterInit({required this.propertyFilter});
}

class OnFilterClearClicked extends PropertyFilterEvent {}

class OnAmenitiesReceived extends PropertyFilterEvent {
  final List<Amenity> amenities;

  OnAmenitiesReceived({required this.amenities});
}

class OnBudgetChanged extends PropertyFilterEvent {
  final RangeValues rangeValues;

  OnBudgetChanged({required this.rangeValues});
}

class OnSortTypeSelected extends PropertyFilterEvent {
  final String selectedId;

  OnSortTypeSelected({required this.selectedId});
}
