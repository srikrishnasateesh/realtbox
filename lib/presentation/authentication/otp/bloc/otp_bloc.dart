import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/utils/validation_utils.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/authentication/entity/otp/token_request_entity.dart';
import 'package:realtbox/domain/authentication/entity/otp/token_response.dart';
import 'package:realtbox/domain/authentication/usecase/get_token.dart';
import 'package:realtbox/domain/authentication/usecase/login_otp_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  late bool isExistingUser;
  late String phoneNumber;
  ValidationUtils utils = getIt<ValidationUtils>();

  GetLoginOtp getLoginOtp;
  GetToken getToken;

  OtpBloc(
    this.getLoginOtp,
    this.getToken,
  ) : super(OtpInitial()) {
    on<OtpEvent>((event, emit) async {
      switch (event) {
        case OnOtpInit():
          handleOtpInit(event, emit);
          break;
        case OnOtpSubmit():
          await handleOtpSubmit(event, emit);
          break;
        case OnResnedOtp():
          handleResendOtp(event, emit);
          break;
        default:
      }
    });
  }
  void handleOtpInit(OnOtpInit event, Emitter<OtpState> emit) {
    isExistingUser = event.isExistingUser;
    phoneNumber = event.userName;
    if (!isExistingUser) {
      emit(OtpShowProfileFields());
    }
  }

  Future<void> handleResendOtp(
      OnResnedOtp event, Emitter<OtpState> emit) async {
    if (phoneNumber.isNotEmpty) {
      emit(OtpInProgress(isLoading: true));
      final response = await getLoginOtp(params: phoneNumber);
      if (response is DataSuccess) {
        emit(OtpInProgress(isLoading: false));
        if (response.data?.success == true) {
          emit(OtpResent(message: StringConstants.resentOtpMessage));
        }
      } else if (response is DataFailed) {
        String msg = response.data?.error?.message ?? "Something went wrong";
        emit(OtpError(message: msg));
      }
    }
  }

  Future<void> handleOtpSubmit(
      OnOtpSubmit event, Emitter<OtpState> emit) async {
    if (!utils.isValidUserName(event.name ?? "")) {
      emit(OtpError(message: "User name required"));
      return;
    }
    if (!utils.isValidUserName(event.otp)) {
      emit(OtpError(message: "Invalid Otp"));
      return;
    }

    final response = await getToken(
      params: TokenRequest(
        phoneNumber,
        event.otp,
        event.name,
      ),
    );

    if (response is DataFailed) {
      String msg = response.exception?.message ?? "Otp submit failed";
      emit(OtpError(message: msg));
      return;
    }

    if (response is DataSuccess) {
      if (response.data?.success == false) {
        String msg = response.exception?.message ?? "Invalid Otp";
        emit(OtpError(message: msg));
        return;
      }
      if (response.data?.success == true) {
        final tokenData = response.data?.data;
        if (tokenData != null) {
          await saveTokenData(tokenData);
          emit(OtpNavigate(route: RouteNames.home));
        }
      }
    }

    emit(OtpInProgress(isLoading: true));
  }

  Future<void> saveTokenData(TokenData tokenData) async {
    await LocalStorage.init();
    await LocalStorage.setString(
      StringConstants.enrollmentType,
      tokenData.enrollmentType,
    );
    await LocalStorage.setString(
      StringConstants.phoneNumber,
      tokenData.phoneNumber,
    );
    await LocalStorage.setString(
      StringConstants.token,
      tokenData.token,
    );
    await LocalStorage.setString(
      StringConstants.user,
      tokenData.user,
    );
    await LocalStorage.setString(
      StringConstants.id,
      tokenData.id,
    );
  }
}
