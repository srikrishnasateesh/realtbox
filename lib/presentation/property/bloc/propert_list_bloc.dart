import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:realtbox/core/base_bloc.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/usecase/get_property_list.dart';

part 'propert_list_event.dart';
part 'propert_list_state.dart';

class PropertListBloc extends BaseBlock<PropertListEvent, PropertListState> {
  final GetPropertyList getPropertyList;

  int count = 0;

  List<Property> propertyList = List.empty(growable: true);

  PropertListBloc(this.getPropertyList) : super(PropertListInitial()) {
    on<PropertListEvent>((event, emit) async {
      switch (event) {
        case OnPropertyListInit():
          count = 0;
          await fetchData(emit);
        case LoadMoreData():
          await loadMoreData(emit);
        case RefreshData():
          await refreshData(emit);
      }
    });
  }

  Future<void> fetchData(Emitter<PropertListState> emit) async {
    if (count == 0) {
      emit(PropertListLoading());
    }
    final response = await getData(emit);
    if (response is DataFailed) {
      handleDataFailed(response as DataFailed, emit);
    }
    if (response is DataSuccess) {
      final list = response.data ?? List.empty();

      debugPrint("List received size: ${list.length}");

      if (count == 0) propertyList.clear();

      propertyList.addAll(list);
      count = propertyList.length;

      debugPrint("Property List size: ${propertyList.length}");
      debugPrint("Count: $count");

      emit(
        PropertListLoaded(data: propertyList, hasReachedMax: count%20>0),
      );
    }
  }

  Future<DataState<List<Property>>> getData(
      Emitter<PropertListState> emit) async {
    return await getPropertyList(
      params: null,
    );
  }

  void handleDataFailed(
    DataFailed response,
    Emitter<PropertListState> emit,
  ) {
    String msg = response.exception?.message ?? "No data available";
    emit(PropertListError(msg));
    return;
  }

  Future<void> loadMoreData(Emitter<PropertListState> emit) async {
    debugPrint("Inside Load more dta");
    if (count % 20 != 0) return;
    if (state is! PropertListLoaded) return;
    debugPrint("Fetching Load more dta");
    await fetchData(emit);
  }

  Future<void> refreshData(Emitter<PropertListState> emit) async {
    count = 0;
    await fetchData(emit);
  }
}
