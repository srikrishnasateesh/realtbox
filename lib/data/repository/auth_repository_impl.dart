import 'dart:io';

import 'package:flutter/material.dart';
import 'package:realtbox/config/resources/constants/api_constnats.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/data/datasource/remote/api_service.dart';
import 'package:realtbox/data/model/self/self_response.dart';
import 'package:realtbox/domain/entity/login/login_request_entity.dart';
import 'package:realtbox/domain/entity/login/login_response.dart';
import 'package:realtbox/domain/entity/otp/token_request_entity.dart';
import 'package:realtbox/domain/entity/otp/token_response.dart';
import 'package:realtbox/domain/entity/self/self.dart';
import 'package:realtbox/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl implements AuthRepository {
  ApiService apiService;
  AuthRepositoryImpl(this.apiService);

  @override
  Future<DataState<LoginResponse>> requestOtp(
    LoginRequest loginRequest,
  ) async {
    try {
      /* return DataSuccess(LoginResponseModel(
          success: true, data: Data(message: "mes", isExists: false))); */
      final httpResponse = await apiService.requestOtp(loginRequest);
      debugPrint(httpResponse.toString());
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.unknown,
                requestOptions: httpResponse.response.requestOptions),
            httpResponse.data);
      }
    } on DioException catch (e) {
      return DataFailed(e, null);
    }
  }

  @override
  Future<DataState<TokenResponse>> getToken(TokenRequest? tokenRequest) async {
    try {
      if (tokenRequest == null) {
        return DataFailed(
          DioException(
              requestOptions: RequestOptions(baseUrl: ApiConstants.baseUrl),
              error: "Inavlid request"),
          null,
        );
      }
      final httpResponse = await apiService.token(tokenRequest);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.unknown,
                requestOptions: httpResponse.response.requestOptions),
            httpResponse.data);
      }
    } on DioException catch (e) {
      return DataFailed(e, null);
    }
  }

  @override
  Future<DataState<Self>> self() async {
    try {
      final httpResponse = await apiService.self();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final data = httpResponse.data;
        if (data.success == true) {
          final selfData = data.data;

          return DataSuccess(maptoSelf(selfData!));
        }
      }
      return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.unknown,
              requestOptions: httpResponse.response.requestOptions),
          null);
    } on DioException catch (e) {
      return DataFailed(e, null);
    }
  }

  Self maptoSelf(SelfData data) {
    return Self(
      createdBy: data.createdBy ?? "",
      id: data.id ?? "",
      name: data.name ?? "",
      phoneNumber: data.phoneNumber ?? "",
      created: data.created ?? DateTime.now(),
      enrollmentType: data.enrollmentType ?? "",
      profileImageUrl: data.profileUrl?.objectUrl ?? "",
      email: data.email ?? ""
    );
  }
}
