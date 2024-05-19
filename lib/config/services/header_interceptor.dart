import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HeaderInterceptor extends Interceptor {
  late Map<String, String> headers;
  HeaderInterceptor() {
    headers = <String, String>{};
    headers["contentType"] = "application/json";
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    headers.forEach((key, value) {
      options.headers[key] = value;
    });
    return super.onRequest(options, handler);
  }
}
