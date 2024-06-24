part of 'propert_list_bloc.dart';

sealed class PropertListState extends BaseState {
  final bool showConfirmation;
  const PropertListState({this.showConfirmation = false});
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

class NavigatetoRoute extends PropertListState{
  final String route;
  final PropertyFilter propertyFilter;

  NavigatetoRoute({super.showConfirmation, required this.route, required this.propertyFilter});
}


class RequestProcess extends PropertListState {}

class OnEnquirySubmittedSuccessfully extends PropertListState {}