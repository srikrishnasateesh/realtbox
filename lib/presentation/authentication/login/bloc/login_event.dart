part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends BaseEvent {}

class OnLoginOtpRequested extends LoginEvent {
  String mobileNumber;
  OnLoginOtpRequested(this.mobileNumber);
}

class OnMobileInputChanged extends LoginEvent {}
