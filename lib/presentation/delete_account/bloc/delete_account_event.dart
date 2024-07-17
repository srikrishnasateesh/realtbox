part of 'delete_account_bloc.dart';

sealed class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}

class OnFormSubmit extends DeleteAccountEvent {
  final String reason;

  OnFormSubmit({required this.reason});
}
