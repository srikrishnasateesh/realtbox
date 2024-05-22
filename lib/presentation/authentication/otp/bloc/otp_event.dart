part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent extends BaseEvent {}

final class OnOtpInit extends OtpEvent{
  final bool isExistingUser;
  final String userName;
  OnOtpInit(this.userName,this.isExistingUser);
}

final class OnOtpSubmit extends OtpEvent {
  final String? name;
  final String otp;
  OnOtpSubmit(this.name,this.otp);
}

final class OnResnedOtp extends OtpEvent {}
