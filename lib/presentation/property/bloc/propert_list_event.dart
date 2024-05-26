part of 'propert_list_bloc.dart';

sealed class PropertListEvent extends BaseEvent {
  const PropertListEvent();
}

class OnPropertyListInit extends PropertListEvent {}

class LoadMoreData extends PropertListEvent {}

class RefreshData extends PropertListEvent {}
