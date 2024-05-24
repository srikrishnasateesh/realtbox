part of 'propert_list_bloc.dart';

sealed class PropertListEvent extends Equatable {
  const PropertListEvent();

  @override
  List<Object> get props => [];
}

class OnPropertyListInit extends PropertListEvent {}

class LoadMoreData extends PropertListEvent {}

class RefreshData extends PropertListEvent {}
