import 'dart:io';

import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/entity/login/login_request_entity.dart';
import 'package:realtbox/domain/entity/login/login_response.dart';
import 'package:realtbox/domain/entity/token/refresh_token_request.dart';
import 'package:realtbox/domain/entity/token/token_request_entity.dart';
import 'package:realtbox/domain/entity/token/token_response.dart';
import 'package:realtbox/domain/entity/self/self.dart';
import 'package:realtbox/domain/entity/version-request/version-request.dart';
import 'package:realtbox/domain/entity/version-request/version-response.dart';

abstract class AuthRepository {
  Future<DataState<VersionResponse>> version(VersionRequest versionRequest);
  Future<DataState<LoginResponse>> requestOtp(LoginRequest loginRequest);
  Future<DataState<TokenResponse>> getToken(TokenRequest? tokenRequest);
  Future<DataState<TokenResponse>> refreshToken(RefreshTokenRequest? tokenRequest);
  Future<DataState<Self>> self();
  Future<DataState> deleteAccount(String reason);
}
