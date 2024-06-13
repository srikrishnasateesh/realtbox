part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoginState extends AuthState {}

final class AuthRegisterState extends AuthState {
  final String mobile;
  final bool isExistingUser;

  AuthRegisterState({required this.mobile, required this.isExistingUser});
}

final class AuthLoading extends AuthState {}

class AuthErrorMessage extends AuthState {
  final String message;

  const AuthErrorMessage({required this.message});
}
