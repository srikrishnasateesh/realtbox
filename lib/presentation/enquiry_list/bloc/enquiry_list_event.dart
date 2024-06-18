part of 'enquiry_list_bloc.dart';

sealed class EnquiryListEvent extends BaseEvent {
  const EnquiryListEvent();
}

class OnEnquiryListInit extends EnquiryListEvent {
  final String properyId;

  OnEnquiryListInit({required this.properyId});
}
