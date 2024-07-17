part of 'delete_account_bloc.dart';

sealed class DeleteAccountState extends Equatable {
  const DeleteAccountState();
  
  @override
  List<Object> get props => [];
}

final class DeleteAccountInitial extends DeleteAccountState {}

class ValidationError extends DeleteAccountState {
  final String message;

  ValidationError({required this.message});
}

class ShowProgress extends DeleteAccountState {}

class Navigate extends DeleteAccountState {
  final String route;

  Navigate({required this.route});
}
