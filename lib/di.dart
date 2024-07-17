import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:realtbox/config/services/header_interceptor.dart';
import 'package:realtbox/core/utils/validation_utils.dart';
import 'package:realtbox/data/datasource/remote/api_service.dart';
import 'package:realtbox/data/repository/auth_repository_impl.dart';
import 'package:realtbox/data/repository/property_repository_impl.dart';
import 'package:realtbox/domain/repository/auth_repository.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';
import 'package:realtbox/domain/usecase/amenity-list.dart';
import 'package:realtbox/domain/usecase/category-list.dart';
import 'package:realtbox/domain/usecase/delete_account.dart';
import 'package:realtbox/domain/usecase/enquiry_list.dart';
import 'package:realtbox/domain/usecase/fcm-token.dart';
import 'package:realtbox/domain/usecase/get_property_list.dart';
import 'package:realtbox/domain/usecase/get_refresh_token.dart';
import 'package:realtbox/domain/usecase/get_token.dart';
import 'package:realtbox/domain/usecase/get_user_self.dart';
import 'package:realtbox/domain/usecase/login_otp_usecase.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';
import 'package:realtbox/domain/usecase/version-check.dart';

final getIt = GetIt.instance;

Future<void> initDI() async {
  getIt.registerSingleton<ValidationUtils>(ValidationUtils());

  //Dio
  getIt.registerSingleton<Dio>(Dio());

  //apis
  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));

  //repos
  getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(getIt<ApiService>()));
  getIt.registerSingleton<PropertyRepository>(
    PropertyRepositoryImplementation(
      apiService: getIt<ApiService>(),
    ),
  );

  //usecases
  getIt.registerSingleton<GetLoginOtp>(GetLoginOtp(getIt<AuthRepository>()));
  getIt.registerSingleton<GetToken>(GetToken(getIt<AuthRepository>()));
  getIt.registerSingleton<GetRefreshToken>(
      GetRefreshToken(getIt<AuthRepository>()));
  getIt.registerSingleton<GetUserSelf>(GetUserSelf(getIt<AuthRepository>()));
  getIt.registerSingleton<GetPropertyList>(
    GetPropertyList(
      repository: getIt<PropertyRepository>(),
    ),
  );
  getIt.registerSingleton<SubmitEnquiry>(
    SubmitEnquiry(
      repository: getIt<PropertyRepository>(),
    ),
  );
  getIt.registerSingleton<GetEnquiryList>(
    GetEnquiryList(
      repository: getIt<PropertyRepository>(),
    ),
  );
  getIt.registerSingleton<GetCategoryList>(
    GetCategoryList(
      repository: getIt<PropertyRepository>(),
    ),
  );

  getIt.registerSingleton<GetAmenityList>(
    GetAmenityList(
      repository: getIt<PropertyRepository>(),
    ),
  );

  getIt.registerSingleton<CheckVersion>(
    CheckVersion(
      repository: getIt<AuthRepository>(),
    ),
  );
  getIt.registerSingleton<GetFcmToken>(
    GetFcmToken(),
  );

  getIt.registerSingleton<DeleteAccount>(
    DeleteAccount(getIt<AuthRepository>()),
  );
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
