part of 'data_bloc.dart';

sealed class DataState extends Equatable {
  const DataState();
  
  @override
  List<Object> get props => [];
}

final class DataInitial extends DataState {}

final class DataLoading extends DataState {}

final class DataLoaded extends DataState {
  final List<String> data;
  final bool hasReachedMax;

  const DataLoaded({required this.data, required this.hasReachedMax});

  @override
  List<Object> get props => [data, hasReachedMax];
}

final class DataError extends DataState {
  final String message;

  const DataError(this.message);

  @override
  List<Object> get props => [message];
}

