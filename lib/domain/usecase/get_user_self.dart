import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/self/self.dart';
import 'package:realtbox/domain/repository/auth_repository.dart';

class GetUserSelf extends UseCase<DataState<Self>, String> {
  AuthRepository authRepository;
  GetUserSelf(this.authRepository);
  @override
  Future<DataState<Self>> call({String? params}) {
    return authRepository.self();
  }
}
