import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/category-type/category.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';

class GetCategoryList extends UseCase<DataState<List<Category>>,String> {
  final PropertyRepository repository;

  GetCategoryList({required this.repository});
  @override
  Future<DataState<List<Category>>> call({String? params}) {
    return repository.categoryList();
  }

}