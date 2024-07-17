import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/repository/auth_repository.dart';

class DeleteAccount implements UseCase<DataState, String> {
  final AuthRepository authRepository;

  DeleteAccount(this.authRepository);
  @override
  Future<DataState> call({String? params}) {
    return authRepository.deleteAccount(params!);
  }
}
