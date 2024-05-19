import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/authentication/entity/otp/token_request_entity.dart';
import 'package:realtbox/domain/authentication/entity/otp/token_response.dart';
import 'package:realtbox/domain/authentication/repository/auth_repository.dart';

class GetToken implements UseCase<DataState<TokenResponse>, TokenRequest> {
  AuthRepository authRepository;

  GetToken(this.authRepository);

  @override
  Future<DataState<TokenResponse>> call({TokenRequest? params}) {
    return authRepository.getToken(params);
  }
}
