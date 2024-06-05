import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/entity/login/login_request_entity.dart';
import 'package:realtbox/domain/entity/login/login_response.dart';
import 'package:realtbox/domain/entity/otp/token_request_entity.dart';
import 'package:realtbox/domain/entity/otp/token_response.dart';
import 'package:realtbox/domain/entity/self/self.dart';

abstract class AuthRepository {
  Future<DataState<LoginResponse>> requestOtp(LoginRequest loginRequest);
  Future<DataState<TokenResponse>> getToken(TokenRequest? tokenRequest);
  Future<DataState<Self>> self();
}
