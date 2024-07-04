import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/token/refresh_token_request.dart';
import 'package:realtbox/domain/entity/token/token_request_entity.dart';
import 'package:realtbox/domain/entity/token/token_response.dart';
import 'package:realtbox/domain/repository/auth_repository.dart';

class GetRefreshToken implements UseCase<DataState<TokenResponse>, RefreshTokenRequest> {
  AuthRepository authRepository;

  GetRefreshToken(this.authRepository);

  @override
  Future<DataState<TokenResponse>> call({RefreshTokenRequest? params}) {
    return authRepository.refreshToken(params);
  }
}
