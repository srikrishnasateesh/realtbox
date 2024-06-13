// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/core/utils/validation_utils.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/usecase/login_otp_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ValidationUtils utils = getIt<ValidationUtils>();
  GetLoginOtp getLoginOtp;

  AuthBloc(this.getLoginOtp) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{
      switch (event) {
        case AppStarted():
          emit(AuthLoginState());
          break;
        case LoginInit():
          debugPrint("Login Page rendered");
          break;
        case RegisterInit():
          debugPrint("Register Page rendered");
          break;
        case OnLoginSuccess():
          emit(AuthRegisterState(
            mobile: event.mobile,
            isExistingUser: event.isExistingUser
          ));
          break;
      }
    });
  }
}
