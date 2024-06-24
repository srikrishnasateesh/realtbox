part of 'amenities_bloc.dart';

sealed class AmenitiesEvent extends Equatable {
  const AmenitiesEvent();

  @override
  List<Object> get props => [];
}

class AmenitiesRequested extends AmenitiesEvent {
  final List<Amenity> amenitiesSelected;

  AmenitiesRequested({required this.amenitiesSelected});
}

class AmenitySelected extends AmenitiesEvent {
  final Amenity selectedAmenity;

  AmenitySelected({required this.selectedAmenity});

  @override
  List<Object> get props => [selectedAmenity];
}
