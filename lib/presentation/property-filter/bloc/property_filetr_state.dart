part of 'property_filetr_bloc.dart';

sealed class PropertyFilterState extends Equatable {
  const PropertyFilterState();

  @override
  List<Object> get props => [];
}

final class PropertyFiletrInitial extends PropertyFilterState {}

class LoadFilters extends PropertyFilterState {
  final PropertyFilter propertyFilter;

  LoadFilters({required this.propertyFilter});
}
