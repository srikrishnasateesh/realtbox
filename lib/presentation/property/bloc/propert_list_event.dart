part of 'propert_list_bloc.dart';

sealed class PropertListEvent extends BaseEvent {
  const PropertListEvent();
}

class OnPropertyListInit extends PropertListEvent {}

class LoadMoreData extends PropertListEvent {}

class RefreshData extends PropertListEvent {}

class OnEnquiryReceived extends PropertListEvent{
  final String mobile;
  final String message;
  final String propertyId;

  OnEnquiryReceived({required this.mobile, required this.message,required this.propertyId});
}