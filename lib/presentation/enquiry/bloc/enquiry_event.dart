part of 'enquiry_bloc.dart';

sealed class EnquiryEvent extends Equatable {
  const EnquiryEvent();

  @override
  List<Object> get props => [];
}

class OnAppStarted extends EnquiryEvent {
  final String id;

  OnAppStarted({required this.id});
}

class OnEnquirySubmitted extends EnquiryEvent {
  final String mobileNumber;
  final String message;

  const OnEnquirySubmitted({required this.mobileNumber, required this.message});
}

 class OnMobileNumberChanged extends EnquiryEvent {
  final String text;

  OnMobileNumberChanged({required this.text});
 }

class OnValuesChanged extends EnquiryEvent {}