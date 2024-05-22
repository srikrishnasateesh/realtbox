part of 'data_bloc.dart';

@immutable
sealed class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class FetchData extends DataEvent {}

class LoadMoreData extends DataEvent {}

class RefreshData extends DataEvent {}

