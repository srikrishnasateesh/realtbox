import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/usecase/get_property_list.dart';

part 'propert_list_event.dart';
part 'propert_list_state.dart';

class PropertListBloc extends Bloc<PropertListEvent, PropertListState> {
  final GetPropertyList getPropertyList;
  int count = 0;
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
    emit(PropertListLoading());
    final response = await getData(emit);
    if (response is DataFailed) {
      handleDataFailed(response as DataFailed, emit);
    }
    if (response is DataSuccess) {
      final list = response.data ?? List.empty();
      count += list.length;
      emit(PropertListLoaded(data: list, hasReachedMax: count % 20 > 0));
    }
  }

  Future<DataState<List<Property>>> getData(
      Emitter<PropertListState> emit) async {
    emit(PropertListLoading());
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
    if (count % 20 != 0) return;
    if (state is! PropertListLoaded) return;

    final data = (state as PropertListLoaded).data;
    emit(PropertMoreListLoading());
    final response = await getData(emit);
    if (response is DataFailed) {
      handleDataFailed(response as DataFailed, emit);
    }
    if (response is DataSuccess) {
      final list = response.data ?? List.empty();
      count += list.length;
      emit(PropertListLoaded(data: data + list, hasReachedMax: count % 20 > 0));
    }
  }

  Future<void> refreshData(Emitter<PropertListState> emit) async {
    count = 0;
    await fetchData(emit);
  }
}
