part of 'propert_list_bloc.dart';

sealed class PropertListEvent extends BaseEvent {
  const PropertListEvent();
}

class OnPropertyListInit extends PropertListEvent {
  final String category;

  OnPropertyListInit({required this.category});
}

class LoadMoreData extends PropertListEvent {}

class RefreshData extends PropertListEvent {}

class OnEnquiryReceived extends PropertListEvent{
  final String mobile;
  final String message;
  final String propertyId;

  OnEnquiryReceived({required this.mobile, required this.message,required this.propertyId});
}

class OnPropertyFiletr extends PropertListEvent {
  final PropertyFilter? propertyFilter;

  OnPropertyFiletr({required this.propertyFilter});
}

class OnPropertyFilterClicked extends PropertListEvent {}
class OnFavouriteClicked extends PropertListEvent {
  final String id;

  OnFavouriteClicked({required this.id});
}