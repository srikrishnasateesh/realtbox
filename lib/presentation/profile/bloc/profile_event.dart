part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class OnProfileInit extends ProfileEvent {}

class OnLogoutConfirmed extends ProfileEvent {}
