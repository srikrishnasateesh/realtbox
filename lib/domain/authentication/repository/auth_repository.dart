import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/authentication/entity/login/login_request_entity.dart';
import 'package:realtbox/domain/authentication/entity/login/login_response.dart';
import 'package:realtbox/domain/authentication/entity/otp/token_request_entity.dart';
import 'package:realtbox/domain/authentication/entity/otp/token_response.dart';

abstract class AuthRepository {

  Future<DataState<LoginResponse>> requestOtp(LoginRequest loginRequest);
  Future<DataState<TokenResponse>> getToken(TokenRequest? tokenRequest);
}
