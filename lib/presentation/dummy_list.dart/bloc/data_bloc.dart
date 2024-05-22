import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final List<String> _allData =
      List<String>.generate(100, (index) => 'Item $index');
  final int _pageSize = 20;
  DataBloc() : super(DataInitial()) {
    on<DataEvent>((event, emit) async {
      debugPrint("Received event: ${event.toString()}");
      switch (event) {
        case FetchData():
          _mapFetchDataToState(emit);
          break;
        case LoadMoreData():
          _mapLoadMoreDataToState(emit);
          break;
        case RefreshData():
          await _mapRefreshDataToState(emit);
          break;
      }
    });
  }

  void _mapFetchDataToState(Emitter<DataState> emit) {
    debugPrint("inside fetched data:");
    emit(DataLoading());
    try {
      final data = _fetchData(0);
      debugPrint("fetched data: ${data.join(',')}");
      emit(DataLoaded(
          data: data, hasReachedMax: data.length >= _allData.length));
    } catch (e) {
      debugPrint("exception fetched data: ${e.toString()}");
      emit(const DataError('Failed to fetch data'));
    }
  }

  void _mapLoadMoreDataToState(Emitter<DataState> emit) {
    if (state is DataLoaded) {
      final currentState = state as DataLoaded;
      final currentData = currentState.data;
      if (currentState.hasReachedMax) return;

      try {
        final data = _fetchData(currentData.length);
        emit(DataLoaded(
          data: currentData + data,
          hasReachedMax: currentData.length + data.length >= _allData.length,
        ));
      } catch (_) {
        emit(const DataError('Failed to fetch data'));
      }
    }
  }

  Future _mapRefreshDataToState(Emitter<DataState> emit) async {
    try {
      List<String> data = List.empty();
      emit(DataLoaded(
        data: data,
        hasReachedMax: data.length >= _allData.length,
      ));
      data = _fetchData(0);
      debugPrint("onRefresh: data: ${data.join()}");
      emit(DataLoaded(
        data: data,
        hasReachedMax: data.length >= _allData.length,
      ));
    } catch (_) {
      emit(const DataError('Failed to refresh data'));
    }
  }

  List<String> _fetchData(int startIndex) {
    return _allData.skip(startIndex).take(_pageSize).toList();
  }
}
