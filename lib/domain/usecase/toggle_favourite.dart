import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/favourite.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';

class ToggleFavourite extends UseCase<DataState<Favourite>, String> {
   final PropertyRepository repository;

  ToggleFavourite({required this.repository});
  @override
  Future<DataState<Favourite>> call({String? params}) {
    return repository.toggleFavorite(params!);
  }
  

}