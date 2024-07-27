import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/services/local_storage.dart';
import 'package:realtbox/core/usecase/usecase.dart';

class GetFcmToken implements UseCase<String, String> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  Future<String> call({String? params}) async {
    String fcmToken = LocalStorage.getString(StringConstants.fcmToken);
    debugPrint("fcmToken-ls: $fcmToken");
    if (fcmToken.isEmpty) {
      if (Platform.isIOS) {
        /*  final apnsToken = await firebaseMessaging.getAPNSToken();
        debugPrint("apnsToken: $apnsToken"); */
        await Future.delayed(const Duration(seconds: 2), () async {
          final apnsToken = await firebaseMessaging.getAPNSToken();
          debugPrint("apnsToken-ios: $apnsToken");
          fcmToken = await firebaseMessaging.getToken() ?? "";
          debugPrint("fcmToken-ios: $fcmToken");
          
        });
      } else {
        await firebaseMessaging.getToken().then((token) async => {
              fcmToken = token ?? "",
              debugPrint("fcmToken-android: $fcmToken"),
            });
      }
      await LocalStorage.setString(StringConstants.fcmToken, fcmToken);
    }
    return fcmToken;
  }
}
