part of 'otp_bloc.dart';

@immutable
sealed class OtpState extends BaseState {}

final class OtpInitial extends OtpState {}

final class OtpInProgress extends OtpState {
  final bool isLoading;

  OtpInProgress({required this.isLoading});
}

final class OtpShowProfileFields extends OtpState{}

final class OtpError extends OtpState{
  final String message;

  OtpError({required this.message});
}

final class OtpResent extends OtpState{
  final String message;

  OtpResent({required this.message});
}

final class OtpNavigate extends OtpState {
  final String route;

  OtpNavigate({required this.route});
}
