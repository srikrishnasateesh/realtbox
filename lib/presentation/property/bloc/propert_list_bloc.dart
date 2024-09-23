import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtbox/config/routes/route_names.dart';
import 'package:realtbox/core/base_bloc.dart';
import 'package:realtbox/core/resources/data_state.dart';
import 'package:realtbox/data/model/enquiry/enquiry_request.dart';
import 'package:realtbox/domain/entity/favourite.dart';
import 'package:realtbox/domain/entity/property/property.dart';
import 'package:realtbox/domain/usecase/get_property_list.dart';
import 'package:realtbox/domain/usecase/submit_enquiry.dart';
import 'package:realtbox/domain/usecase/toggle_favourite.dart';
import 'package:realtbox/presentation/property-filter/property-filter-entity.dart';

part 'propert_list_event.dart';
part 'propert_list_state.dart';

class PropertListBloc extends BaseBlock<PropertListEvent, PropertListState> {
  final GetPropertyList getPropertyList;
  final SubmitEnquiry submitEnquiry;
  final ToggleFavourite toggleFavourite;

  int count = 0;

  List<Property> propertyList = List.empty(growable: true);

  bool showEnquiryConfirmation = false;

  String? category;
  PropertyFilter? propertyFilter;

  PropertListBloc(
    this.getPropertyList,
    this.submitEnquiry,
    this.toggleFavourite,
  ) : super(PropertListInitial()) {
    on<PropertListEvent>((event, emit) async {
      showEnquiryConfirmation = false;
      switch (event) {
        case OnPropertyListInit():
          {
            category = null;
            if (event.category.isNotEmpty) {
              category = event.category;
            }
            count = 0;
            await fetchData(emit);
          }
        case LoadMoreData():
          await loadMoreData(emit);
        case RefreshData():
          await refreshData(emit);
        case OnEnquiryReceived():
          await handleEnquirySubmit(emit, event);
          break;
        case OnPropertyFiletr():
          propertyFilter = event.propertyFilter;
          await refreshData(emit);
          break;
        case OnPropertyFilterClicked():
          final filter = propertyFilter ??
              PropertyFilter(
                selectedAmenities: [],
                selectedBudget: Budget(rangeValues: RangeValues(0, 0)),
                selectedLocation: null,
                sortBy: SortBy(selectedId: ""),
              );
          emit(NavigatetoRoute(
              route: RouteNames.propertyfilters, propertyFilter: filter));
          break;
        case OnFavouriteClicked():
          await handleToggleFavourite(emit, event);
          break;
      }
    });
  }

  Future<void> handleToggleFavourite(
      Emitter<PropertListState> emit, OnFavouriteClicked event) async {
    emit(RequestProcess());
    final response = await toggleFavourite(params: event.id);
    if (response is DataSuccess) {
      Favourite? data = response.data;
      String status = data?.status ?? "";
      bool fav = false;
      if (status == "Disable") {
        fav = false;
      } else {
        fav = true;
      }
      propertyList.firstWhere((p) => p.propertyId == event.id).favProperty =
          fav;
      //await  fetchData(emit);
      emit(
        PropertListLoaded(data: propertyList, hasReachedMax: count % 20 > 0),
      );
    } else {
      debugPrint("$response");
    }
  }

  Future<void> handleEnquirySubmit(
      Emitter<PropertListState> emit, OnEnquiryReceived event) async {
    emit(RequestProcess());
    final response = await submitEnquiry(
        params: EnquiryRequestObject(
            enquiryRequest: EnquiryRequest(
                phoneNumber: event.mobile, message: event.message),
            propertyId: event.propertyId));
    if (response is DataSuccess) {
      showEnquiryConfirmation = true;
      //emit(OnEnquirySubmittedSuccessfully());
    } else {
      debugPrint("$response");
    }
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
        PropertListLoaded(data: propertyList, hasReachedMax: count % 20 > 0),
      );
    }
  }

  Future<DataState<List<Property>>> getData(
      Emitter<PropertListState> emit) async {
    final params = PropertyRequest(
        category: category, propertyFilter: propertyFilter, skip: count);
    return await getPropertyList(
      params: params,
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
