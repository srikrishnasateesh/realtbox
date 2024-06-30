import 'dart:io';

import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/version-request/version-request.dart';
import 'package:realtbox/domain/entity/version-request/version-response.dart';
import 'package:realtbox/domain/repository/auth_repository.dart';

class CheckVersion implements UseCase<DataState<VersionResponse>,VersionRequest> {
  final AuthRepository repository;

  CheckVersion({required this.repository});
  @override
  Future<DataState<VersionResponse>> call({VersionRequest? params}) {
    return repository.version(params!);
  }

}