part of 'enquiry_list_bloc.dart';

sealed class EnquiryListState extends BaseState {
  const EnquiryListState();
}

final class EnquiryListInitial extends EnquiryListState {}


final class EnquiryListLoaded extends EnquiryListState {
  final List<EnquiryDataModel> data;

  EnquiryListLoaded({required this.data});
}

class EnquiryListLoading extends EnquiryListState {}
