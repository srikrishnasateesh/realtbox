part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class OnLoginOtpRequested extends LoginEvent {
  String userName;
  OnLoginOtpRequested(this.userName);
}
