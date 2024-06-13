import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/base_bloc.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/utils/validation_utils.dart';
import 'package:realtbox/di.dart';
import 'package:realtbox/domain/entity/otp/token_request_entity.dart';
import 'package:realtbox/domain/entity/otp/token_response.dart';
import 'package:realtbox/domain/usecase/get_token.dart';
import 'package:realtbox/domain/usecase/get_user_self.dart';
import 'package:realtbox/domain/usecase/login_otp_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends BaseBlock<OtpEvent, OtpState> {
  late bool isExistingUser;
  late String phoneNumber;
  ValidationUtils utils = getIt<ValidationUtils>();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  GetLoginOtp getLoginOtp;
  GetToken getToken;
  GetUserSelf getUserSelf;

  OtpBloc(
    this.getLoginOtp,
    this.getToken,
    this.getUserSelf,
  ) : super(OtpInitial()) {
    on<OtpEvent>((event, emit) async {
      switch (event) {
        case OnOtpInit():
          await handleOtpInit(event, emit);
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
  Future<void> handleOtpInit(OnOtpInit event, Emitter<OtpState> emit) async {
    await LocalStorage.init();
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
    if ((!isExistingUser) && !utils.isValidUserName(event.name ?? "")) {
      emit(OtpError(message: "User name required"));
      return;
    }

    if (event.email.isNotEmpty && !utils.isValidEmail(event.email)) {
      emit(OtpError(message: "Invalid Email"));
      return;
    }

    if (!utils.isValidPassword(event.otp)) {
      emit(OtpError(message: "Invalid Otp"));
      return;
    }
    String fcmToken = LocalStorage.getString(StringConstants.fcmToken);
    if (fcmToken.isEmpty) {
      await firebaseMessaging.getToken().then((token) async => {
            fcmToken = token ?? "",
            await LocalStorage.setString(StringConstants.fcmToken, fcmToken),
          });
    }

    emit(OtpInProgress(isLoading: true));
    final response = await getToken(
      params: TokenRequest(
        phoneNumber: phoneNumber,
        otp: event.otp,
        name: event.name,
        fcmToken: fcmToken,
        email: event.email,
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
          await self(emit);
          emit(OtpNavigate(route: RouteNames.landing));
        }
      }
    }
  }

  Future<void> self(Emitter<OtpState> emit) async {
    final response = await getUserSelf();

    if (response is DataFailed) {
      String msg = response.exception?.message ?? "User self failed";
      emit(OtpError(message: msg));
      return;
    }
    if (response is DataSuccess) {
      final self = response.data;
      await LocalStorage.setString(
        StringConstants.userName,
        self?.name ?? " ",
      );

      await LocalStorage.setString(
        StringConstants.profileImage,
        self?.profileImageUrl ?? "",
      );
       await LocalStorage.setString(
        StringConstants.userEmail,
        self?.email ?? "",
      );
    }
  }

  Future<void> saveTokenData(TokenData tokenData) async {
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
