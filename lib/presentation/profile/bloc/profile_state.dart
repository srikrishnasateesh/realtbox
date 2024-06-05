part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileDataLoaded extends ProfileState {
  final String userName;
  final String userImageUrl;
  final String mobile;

  ProfileDataLoaded({
    required this.userName,
    required this.userImageUrl,
    required this.mobile,
  });
}

final class ShowLogoutConfirmation extends ProfileState {}

final class ProfileNavigation extends ProfileState {
  final String route;

  ProfileNavigation({required this.route});
}
