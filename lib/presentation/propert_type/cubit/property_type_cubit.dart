import 'package:bloc/bloc.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/entity/category-type/category.dart';
import 'package:realtbox/domain/usecase/category-list.dart';

part 'property_type_state.dart';

class PropertyTypeCubit extends Cubit<PropertyTypeState> {
  final GetCategoryList getCategoryList;
  PropertyTypeCubit(this.getCategoryList) : super(PropertyTypeState.initial()) {
    loadPropertyTypes();
  }

  Future<void> loadPropertyTypes() async {
    emit(state.copyWith(status: PropertyTypeStatus.loading));
    try {
      final response = await getCategoryList();
      if (response is DataFailed) {
        return;
      }
      if (response is DataSuccess) {
        final list = response.data ?? List.empty();
        list.insert(0,Category(displayName: "All", key: ""));
        //final propertyTypes = ['All', 'House', 'Villa', 'Apartment'];
        emit(state.copyWith(
            status: PropertyTypeStatus.loaded,
            propertyTypes: list,
            selectedIndex: 0));
      }
    } catch (_) {
      emit(state.copyWith(status: PropertyTypeStatus.error));
    }
  }

  void selectPropertyType(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
