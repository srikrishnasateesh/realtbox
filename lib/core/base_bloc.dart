import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtbox/di.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:realtbox/config/services/header_interceptor.dart';

class BaseBlock<Event extends BaseEvent, State extends BaseState> extends Bloc<Event,State> {
  BaseBlock(super.initialState){
    debugPrint("Createing Dio");
    createDio();
  }

  Dio createDio() {
  Dio dio = getIt<Dio>();
  dio.interceptors.clear();
  dio.interceptors.add(HeaderInterceptor());
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));
  return dio;
}
  
}

abstract class BaseState {
  const BaseState();
}

abstract class BaseEvent {
  const BaseEvent();
}

