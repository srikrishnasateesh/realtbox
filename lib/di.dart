import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:realtbox/config/services/header_interceptor.dart';
import 'package:realtbox/core/utils/validation_utils.dart';
import 'package:realtbox/data/datasource/remote/api_service.dart';
import 'package:realtbox/data/repository/auth_repository_impl.dart';
import 'package:realtbox/domain/authentication/repository/auth_repository.dart';
import 'package:realtbox/domain/authentication/usecase/get_token.dart';
import 'package:realtbox/domain/authentication/usecase/login_otp_usecase.dart';

final getIt = GetIt.instance;

Future<void> initDI() async {

  getIt.registerSingleton<ValidationUtils>(ValidationUtils());

  //Dio
  getIt.registerSingleton<Dio>(Dio());

  //repos
  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));

  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(getIt<ApiService>()));

  //usecases
  getIt.registerSingleton<GetLoginOtp>(GetLoginOtp(getIt<AuthRepository>()));
  getIt.registerSingleton<GetToken>(GetToken(getIt<AuthRepository>()));
}

/* Dio createDio() {
  Dio dio = Dio();
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
} */
