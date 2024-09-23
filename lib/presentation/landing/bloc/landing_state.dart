part of 'landing_bloc.dart';

sealed class LandingState extends Equatable {
  const LandingState();
  
  @override
  List<Object> get props => [];
}


final class LandingInitial extends LandingState {}

class LandingHomeState extends LandingState {}

class LandingSavedState extends LandingState {}

class LandingMapState extends LandingState {}

class LandingProfileState extends LandingState {}
