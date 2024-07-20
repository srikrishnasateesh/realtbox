part of 'user_enquiries_bloc.dart';

sealed class UserEnquiriesState extends Equatable {
  const UserEnquiriesState();
  
  @override
  List<Object> get props => [];
}

final class UserEnquiriesInitial extends UserEnquiriesState {}


final class EnquiryListLoaded extends UserEnquiriesState {
  final List<UserEnquiry> data;

  EnquiryListLoaded({required this.data});
}

class EnquiryListLoading extends UserEnquiriesState {}