import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/base_bloc.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/entity/token/refresh_token_request.dart';
import 'package:realtbox/domain/entity/token/token_response.dart';
import 'package:realtbox/domain/entity/version-request/version-request.dart';
import 'package:realtbox/domain/usecase/fcm-token.dart';
import 'package:realtbox/domain/usecase/get_refresh_token.dart';
import 'package:realtbox/domain/usecase/get_user_self.dart';
import 'package:realtbox/domain/usecase/version-check.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends BaseBlock<SplashEvent, SplashState> {
  CheckVersion checkVersion;
  GetUserSelf getUserSelf;
  GetFcmToken getFcmToken;
  GetRefreshToken getRefreshToken;
  SplashBloc(this.getUserSelf, this.checkVersion, this.getFcmToken,
      this.getRefreshToken)
      : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      switch (event) {
        case OnSplashScrennShown():
          await handleSplashInitState(event, emit);
          break;
        case OnSkipVersion():
          await checkToken(emit);
          break;
      }
    });
  }
  Future handleSplashInitState(
    OnSplashScrennShown event,
    Emitter<SplashState> emit,
  ) async {
    await initDefaults();
    await checkAppVersion(emit);
  }

  Future<void> checkAppVersion(Emitter<SplashState> emit) async {
    bool forceUpgrade = false;
    bool recommendUpgrade = false;
    debugPrint("Calling fcmToken");
    String fcmToken = await getFcmToken();
    final response = await checkVersion(
        params: VersionRequest(
      packageName,
      versionCode,
      versionName,
      fcmToken,
    ));
    if (response is DataFailed) {
      debugPrint("version check failed: $response");
    }
    if (response is DataSuccess) {
      forceUpgrade = response.data?.forceUpgrade ?? false;
      recommendUpgrade = response.data?.recommendUpgrade ?? false;

      String alertMessage = "";
      String title = "";
      bool showSkip = true;

      if (!forceUpgrade && !recommendUpgrade) {
        debugPrint("Update not required");
        await checkToken(emit);
      } else if (forceUpgrade) {
        debugPrint("force update required");
        showSkip = false;
        title = "Update required";
        alertMessage = forceUpdateMessage;
        //show non-cancellable dialog with update option
      } else if (recommendUpgrade) {
        debugPrint("app update required");
        showSkip = true;
        title = "Update";
        alertMessage = recommendUpgradeMessage;
        //show non-cancellable dialog with update and skip option
      }
      if (alertMessage.isNotEmpty) {
        emit(
          ShowVersionUpdate(
            title: title,
            message: alertMessage,
            showSkip: showSkip,
          ),
        );
      }
    }
  }

  Future<void> checkToken(
    Emitter<SplashState> emit,
  ) async {
    String token = LocalStorage.getString(StringConstants.token);
    String refresh = LocalStorage.getString(StringConstants.refreshToken);
    debugPrint("token: $token");
    //Temp to check screens
    //comment always or remove
    //emit(SplashNavigate(RouteNames.authentication));

    //Actual logic to go to authentication
    //Uncomment to check actual flow
    if (refresh.isNotEmpty) {
      //call refresh token here
      await refreshToken(refresh,emit);
    } else {
      await Future.delayed(const Duration(seconds: 2)).then((value) async => {
         emit(SplashNavigate(RouteNames.landing))
        });
      
    }

    
  }

  Future<void> self(Emitter<SplashState> emit) async {
    createDio();
    final response = await getUserSelf();

    if (response is DataFailed) {
      /* String msg = response.exception?.message ?? "User self failed";
      emit(SplashError(message: msg)); */
      await handleLogout(emit);
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
      await LocalStorage.setString(
        StringConstants.enrollmentType,
        self?.enrollmentType ?? "",
      );
      await LocalStorage.setString(
        StringConstants.phoneNumber,
        self?.phoneNumber ?? "",
      );
      await LocalStorage.setString(
        StringConstants.id,
        self?.id ?? "",
      );

      //navigate to next
      emit(SplashNavigate(RouteNames.landing));
    }
  }

  Future<void> initDefaults() async {
    await LocalStorage.init();
    String deviceId = LocalStorage.getString(StringConstants.deviceId);
    if (deviceId.isEmpty) {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? "";
      }
      await LocalStorage.setString(StringConstants.deviceId, deviceId);
    }
  }

  Future<void> handleLogout(Emitter<SplashState> emit) async {
    SharedPreferences? preferences = await LocalStorage.init();
    await preferences?.clear();
    emit(SplashNavigate(RouteNames.splash));
  }

  Future<void> refreshToken(String refreshToken, Emitter<SplashState> emit) async {
    final response = await getRefreshToken(
      params: RefreshTokenRequest(refreshToken: refreshToken),
    );
     if (response is DataFailed) {
      emit(SplashNavigate(RouteNames.landing));
      return;
    }
    if (response is DataSuccess) {
      
      if (response.data?.success == true) {
        final tokenData = response.data?.data;
        if (tokenData != null) {
          await saveTokenData(tokenData);
          await self(emit);
        }
      }
    }
  }

  Future<void> saveTokenData(TokenData tokenData) async {
    await LocalStorage.setString(
      StringConstants.token,
      tokenData.token,
    );
    await LocalStorage.setString(
      StringConstants.refreshToken,
      tokenData.refreshToken,
    );
  }
}
