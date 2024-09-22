import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/core/usecase/usecase.dart';
import 'package:realtbox/domain/entity/amenity.dart';
import 'package:realtbox/domain/entity/birdview.dart';
import 'package:realtbox/domain/entity/category-type/category.dart';
import 'package:realtbox/domain/repository/propert_repository.dart';
import 'package:realtbox/presentation/bird_view/bird_view_screen.dart';

class GetBirdView extends UseCase<DataState<List<BirdView>>,String> {
  final PropertyRepository repository;

  GetBirdView({required this.repository});
  @override
  Future<DataState<List<BirdView>>> call({String? params}) {
    return repository.birdView();
  }

}