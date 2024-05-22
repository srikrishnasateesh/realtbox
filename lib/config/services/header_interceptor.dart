import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/constants/string_constants.dart';
import 'package:realtbox/config/services/local_storage.dart';

class HeaderInterceptor extends Interceptor {
  late Map<String, String> headers;
  HeaderInterceptor() {
    headers = <String, String>{};
    headers["contentType"] = "application/json";
  }

  Future<Map<String, String>> getAppHeaders()  async {
    debugPrint("Inside app headers");
    final headers = <String, String>{};
    await LocalStorage.init();
    String token =  LocalStorage.getString(StringConstants.token);
    debugPrint("Inside app headers:Token: $token");
    if (token.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }
    headers["package"] = "in.axivise.realtbox";
    headers["versionCode"] = "1";
    headers["versionName"] = "1.0";
    return headers;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final appHeaders = await getAppHeaders();
    debugPrint("appHeaders: $appHeaders");
    headers.addAll(appHeaders);
    headers.forEach((key, value) {
      options.headers[key] = value;
    });
    return  super.onRequest(options, handler);
  }
}
