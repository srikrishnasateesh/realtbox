import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/authentication/entity/login/login_request_entity.dart';
import 'package:realtbox/domain/authentication/entity/login/login_response.dart';
import 'package:realtbox/domain/authentication/repository/auth_repository.dart';

class GetLoginOtp implements UseCase<DataState<LoginResponse>,String> {

  AuthRepository authRepository;
  GetLoginOtp(this.authRepository);
  @override
  Future<DataState<LoginResponse>> call({String? params}) {
    return authRepository.requestOtp(LoginRequest(params??""));
  }
}