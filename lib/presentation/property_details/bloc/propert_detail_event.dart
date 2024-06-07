part of 'propert_detail_bloc.dart';

sealed class PropertDetailEvent extends BaseEvent {
  const PropertDetailEvent();
}

class PropertyDetailResumed extends PropertDetailEvent{}

class OnEnquiryReceived extends PropertDetailEvent{
  final String mobile;
  final String message;
  final String propertyId;

  OnEnquiryReceived({required this.mobile, required this.message,required this.propertyId});
}