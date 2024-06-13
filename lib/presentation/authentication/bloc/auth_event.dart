part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}
class AppStarted extends AuthEvent {}
class OnLoginSuccess extends AuthEvent {
  final String mobile;
  final bool isExistingUser;

  OnLoginSuccess({required this.mobile, required this.isExistingUser});
}
class LoginInit extends AuthEvent {}
class RegisterInit extends AuthEvent {}
