part of 'splash_bloc.dart';

@immutable
sealed class SplashState extends BaseState {}

final class SplashInitial extends SplashState {}

final class SplashError extends SplashState {
  final String message;

  SplashError({required this.message});
}

final class SplashNavigate extends SplashState {
  final String route;
  SplashNavigate(this.route);
}