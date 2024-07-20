part of 'user_enquiries_bloc.dart';

sealed class UserEnquiriesEvent extends Equatable {
  const UserEnquiriesEvent();

  @override
  List<Object> get props => [];
}
class OnEnquiryListInit extends UserEnquiriesEvent {}