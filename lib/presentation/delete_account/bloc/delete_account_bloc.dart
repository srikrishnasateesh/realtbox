import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/usecase/delete_account.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final DeleteAccount deleteAccount;
  DeleteAccountBloc(this.deleteAccount) : super(DeleteAccountInitial()) {
    on<DeleteAccountEvent>((event, emit) async {
      switch (event) {
        case OnFormSubmit():
          await handleFormSubmit(event, emit);
          break;
      }
    });
  }

  Future<void> handleFormSubmit(
      OnFormSubmit event, Emitter<DeleteAccountState> emit) async {
    String reason = event.reason;
    if (reason.isEmpty) {
      emit(ValidationError(message: "Reason required"));
    }
    emit(ShowProgress());
    final response = await deleteAccount(params: reason);
    debugPrint("Reason: $reason");
    if (response is DataSuccess) {
      await handleLogout(emit);
    } else if (response is DataFailed){
      emit(ValidationError(message: "Something went wrong"));
    }
  }

  Future<void> handleLogout(Emitter<DeleteAccountState> emit) async {
    SharedPreferences? preferences = await LocalStorage.init();
    await preferences?.clear();
    emit(Navigate(route: RouteNames.splash));
  }
}
