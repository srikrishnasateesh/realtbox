part of 'login_bloc.dart';

@immutable
sealed class LoginState extends BaseState {}

final class LoginInitial extends LoginState {}

final class LoginProgress extends LoginState {
  final bool isLoading;
  LoginProgress(this.isLoading);
}

final class LoginNavigate extends LoginState {
  final String route;
  final Object arguments;
  LoginNavigate(
    this.route,
    this.arguments,
  );
}

final class LoginError extends LoginState {
  final String errorMessage;
  LoginError(this.errorMessage);
}
