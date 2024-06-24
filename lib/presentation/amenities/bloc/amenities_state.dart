part of 'amenities_bloc.dart';

sealed class AmenitiesState extends Equatable {
  const AmenitiesState();

  @override
  List<Object> get props => [];
}

final class AmenitiesInitial extends AmenitiesState {}

final class AmenitiesLoaded extends AmenitiesState {
  final List<Amenity> amenities;
  final List<Amenity> amenitiesSelected;

  AmenitiesLoaded({
    required this.amenities,
    required this.amenitiesSelected,
  });
   @override
  List<Object> get props => [amenities,amenitiesSelected];
}

final class AmenitiesSelectedList extends AmenitiesState {
  final List<Amenity> amenitiesSelected;

  AmenitiesSelectedList({required this.amenitiesSelected});
}

