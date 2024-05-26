part of 'propert_list_bloc.dart';

sealed class PropertListState extends BaseState {
  const PropertListState();
}

final class PropertListInitial extends PropertListState {}

final class PropertListLoading extends PropertListState {}
final class PropertMoreListLoading extends PropertListState {}

final class PropertListLoaded extends PropertListState {
  final List<Property> data;
  final bool hasReachedMax;

  const PropertListLoaded({required this.data, required this.hasReachedMax});

  @override
  List<Object> get props => [data, hasReachedMax];
}

final class PropertListError extends PropertListState {
  final String message;

  const PropertListError(this.message);

  @override
  List<Object> get props => [message];
}