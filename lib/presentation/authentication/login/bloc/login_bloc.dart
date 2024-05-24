import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/core/base_bloc.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/utils/validation_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/usecase/login_otp_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBlock<LoginEvent, LoginState> {
  ValidationUtils utils = getIt<ValidationUtils>();
  GetLoginOtp getLoginOtp;
  LoginBloc(this.getLoginOtp) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      switch (event) {
        case OnLoginOtpRequested():
          await handleRequestOtp(event, emit);
          break;
      }
    });
  }
  Future<void> handleRequestOtp(
      OnLoginOtpRequested event, Emitter<LoginState> emit) async {
    emit(LoginProgress(true));
    String userName = event.userName;
    /* final arguments = {"userName": "9999988888", "isExistingUser": false};
    emit(LoginNavigate(
      RouteNames.otp,
      arguments,
    )); */
    if (utils.validateMobile(userName)) {
      final response = await getLoginOtp(params: userName);
      if (response is DataSuccess) {
        emit(LoginProgress(false));
        if (response.data?.success == true) {
          bool isExistingUser = response.data?.data?.isExists ?? false;
          final arguments = {
            "userName": userName,
            "isExistingUser": isExistingUser
          };
          emit(LoginNavigate(
            RouteNames.otp,
            arguments,
          ));
        }
      } else if (response is DataFailed) {
        String msg = response.data?.error?.message ?? "Something went wrong";
        emit(LoginError(msg));
      }
    } else {
      emit(LoginError(StringConstants.invalidMobileNumber));
    }
  }
}
