part of 'enquiry_bloc.dart';

sealed class EnquiryState extends Equatable {
  const EnquiryState();
  
  @override
  List<Object> get props => [];
}

final class EnquiryInitial extends EnquiryState {}

final class UserMobileNumber extends EnquiryState {
  final String mobile;

  UserMobileNumber({required this.mobile});

}

class EnquiryValidationFailed extends EnquiryState {
  final String message;

  const EnquiryValidationFailed({required this.message});
}

class EnquiryValidationSuccess extends EnquiryState {}

class ShowProgress extends EnquiryState {}

class ShowConfirmationMessage extends EnquiryState {
  final String message;

  ShowConfirmationMessage({required this.message});
}

class ShowError extends EnquiryState {
  final String message;

  ShowError({required this.message});
}
